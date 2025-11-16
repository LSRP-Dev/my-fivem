local Config = Config
local Heists = Config.Heists

-- ============================================================
-- STATE TRACKING
-- ============================================================

local currentHeistId = nil
local currentStepIndex = 0
local HeistClientState = {} -- [heistId] = "idle" | "active" | "cooldown"
local ActiveStep = {} -- [heistId] = stepNumber
local alreadyLooted = {} -- [heistId] = { [lootKey] = true }
local ClerkRuntimeState = {} -- [heistId] = { panicked = false, gaveKey = false, aggroTimer = 0 }

-- Entity tracking
local guards = {} -- [heistId] = { ped1, ped2, ... }
local SpawnedClerks = {} -- [heistId] = ped
local VaultDoors = {} -- [heistId] = { obj = entity, heading = number, open = boolean }

-- ============================================================
-- HELPERS
-- ============================================================

local function debugPrint(...)
    if Config.Debug then
        print('[cs_heistmaster:client]', ...)
    end
end

local function vecFromTable(t, defaultW)
    if not t then return vec3(0.0, 0.0, 0.0) end
    if t.w or defaultW then
        return vec4(t.x + 0.0, t.y + 0.0, t.z + 0.0, (t.w or defaultW or 0.0) + 0.0)
    end
    return vec3(t.x + 0.0, t.y + 0.0, t.z + 0.0)
end

local function loadModel(model)
    local hash = (type(model) == 'string') and joaat(model) or model
    if not IsModelInCdimage(hash) then return nil end
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(0) end
    return hash
end

-- ============================================================
-- H) SYNCHRONIZATION - Server Events
-- ============================================================

RegisterNetEvent('cs_heistmaster:client:setHeistState', function(heistId, state)
    HeistClientState[heistId] = state
    if state == "active" then
        currentHeistId = heistId
    elseif state ~= "active" and currentHeistId == heistId then
        currentHeistId = nil
    end
    debugPrint(('Heist state set: %s = %s'):format(heistId, state))
end)

RegisterNetEvent("cs_heistmaster:client:setStep", function(heistId, step)
    ActiveStep[heistId] = step
    debugPrint(('Step set: %s = %s'):format(heistId, step))
end)

-- Forward declaration - will be defined later
local runHeistThread

RegisterNetEvent('cs_heistmaster:client:startHeist', function(heistId, heistData)
    currentHeistId = heistId
    currentStepIndex = 1
    Heists[heistId] = heistData
    HeistClientState[heistId] = "active"
    ActiveStep[heistId] = 1
    alreadyLooted[heistId] = {}
    
    debugPrint('Heist started:', heistId)
    
    lib.notify({
        title = heistData.label,
        description = 'Heist started. Follow the objectives.',
        type = 'success'
    })
    
    -- Start the heist thread
    runHeistThread(heistId, heistData)
end)

RegisterNetEvent('cs_heistmaster:client:forceStart', function(heistId)
    TriggerServerEvent('cs_heistmaster:requestStart', heistId)
end)

-- ============================================================
-- B) VAULT DOOR SYSTEM
-- ============================================================

RegisterNetEvent("cs_heistmaster:client:spawnVaultDoor", function(heistId, coords, heading, model, open)
    -- Delete existing door if present
    if VaultDoors[heistId] and DoesEntityExist(VaultDoors[heistId].obj) then
        DeleteEntity(VaultDoors[heistId].obj)
    end
    
    local hash = joaat(model or 'v_ilev_gb_vauldr')
    RequestModel(hash)
    while not HasModelLoaded(hash) do Wait(10) end
    
    local obj = CreateObject(hash, coords.x, coords.y, coords.z, false, false, false)
    SetEntityHeading(obj, heading or 160.0)
    FreezeEntityPosition(obj, true)
    
    VaultDoors[heistId] = { obj = obj, heading = heading or 160.0, open = open or false }
    
    if open then
        SetEntityHeading(obj, (heading or 160.0) - 100.0)
    end
    
    debugPrint(('Vault door spawned: %s (open: %s)'):format(heistId, tostring(open)))
end)

RegisterNetEvent("cs_heistmaster:client:openVaultDoor", function(heistId)
    local door = VaultDoors[heistId]
    if not door or not DoesEntityExist(door.obj) then return end
    
    local start = door.heading
    FreezeEntityPosition(door.obj, false)
    
    for i = 1, 100 do
        SetEntityHeading(door.obj, start - (i * 1.0))
        Wait(15)
    end
    
    FreezeEntityPosition(door.obj, true)
    door.open = true
    
    -- Effects
    local coords = GetEntityCoords(door.obj)
    UseParticleFxAssetNextCall("core")
    StartParticleFxNonLoopedAtCoord("ent_dst_electrical", coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
    PlaySoundFromCoord(-1, "VAULT_DOOR_OPEN", coords.x, coords.y, coords.z, "dlc_heist_fleeca_bank_door_sounds", false, 1.0, false)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.5)
    
    debugPrint(('Vault door opened: %s'):format(heistId))
end)

RegisterNetEvent("cs_heistmaster:client:requestVaultSync", function()
    TriggerServerEvent("cs_heistmaster:server:syncVaultDoors")
end)

-- Sync on join
CreateThread(function()
    Wait(5000)
    TriggerServerEvent("cs_heistmaster:server:syncVaultDoors")
end)

-- ============================================================
-- D) GUARDS SYSTEM
-- ============================================================

RegisterNetEvent('cs_heistmaster:client:spawnGuards', function(heistId, guardList)
    if not guardList or #guardList == 0 then return end
    
    -- Cleanup existing guards for this heist
    if guards[heistId] then
        for _, ped in ipairs(guards[heistId]) do
            if DoesEntityExist(ped) then DeletePed(ped) end
        end
    end
    
    guards[heistId] = {}
    
    for _, data in ipairs(guardList) do
        if data.coords then
            local c = vecFromTable(data.coords, data.coords.w or 0.0)
            local mHash = loadModel(data.model or 's_m_m_security_01')
            if mHash then
                local ped = CreatePed(4, mHash, c.x, c.y, c.z, c.w, true, true)
                
                SetEntityAsMissionEntity(ped, true, true)
                SetPedArmour(ped, data.armor or 50)
                SetPedAccuracy(ped, data.accuracy or 30)
                SetPedFleeAttributes(ped, 0, false)
                SetPedCombatAttributes(ped, 46, true)
                SetPedCombatRange(ped, 2)
                SetPedCombatMovement(ped, 2)
                SetPedRelationshipGroupHash(ped, joaat('GUARD'))
                SetRelationshipBetweenGroups(5, joaat('GUARD'), joaat('PLAYER'))
                SetRelationshipBetweenGroups(5, joaat('PLAYER'), joaat('GUARD'))
                
                GiveWeaponToPed(ped, joaat(data.weapon or 'weapon_pistol'), 250, false, true)
                SetPedCombatAbility(ped, 100)
                SetPedCombatAttributes(ped, 46, true)
                
                -- Make guards attack player on sight
                TaskCombatPed(ped, PlayerPedId(), 0, 16)
                
                table.insert(guards[heistId], ped)
                debugPrint(('Guard spawned for heist: %s'):format(heistId))
            end
        end
    end
end)

-- ============================================================
-- CLEANUP
-- ============================================================

RegisterNetEvent('cs_heistmaster:client:cleanupHeist', function(heistId)
    -- Cleanup guards
    if guards[heistId] then
        for _, ped in ipairs(guards[heistId]) do
            if DoesEntityExist(ped) then DeletePed(ped) end
        end
        guards[heistId] = nil
    end
    
    -- Cleanup clerk
    if SpawnedClerks[heistId] then
        local clerkPed = SpawnedClerks[heistId]
        if DoesEntityExist(clerkPed) then
            DeletePed(clerkPed)
        end
        SpawnedClerks[heistId] = nil
    end
    
    -- Cleanup vault door
    if VaultDoors[heistId] then
        local door = VaultDoors[heistId]
        if DoesEntityExist(door.obj) then
            DeleteEntity(door.obj)
        end
        VaultDoors[heistId] = nil
    end
    
    -- Reset state
    ClerkRuntimeState[heistId] = nil
    alreadyLooted[heistId] = nil
    
    if currentHeistId == heistId then
        currentHeistId = nil
        currentStepIndex = 0
        lib.hideTextUI()
    end
    
    debugPrint(('Heist cleaned up: %s'):format(heistId))
end)

-- ============================================================
-- ALERT & ALARM HANDLER
-- ============================================================

local function handleStepAlert(heistId, heist, step)
    local alertType = step.alert or 'none'
    if alertType ~= 'none' then
        TriggerServerEvent('cs_heistmaster:alertPolice', heistId, alertType)
    end
    
    if step.alarmSound then
        PlaySoundFrontend(-1, 'Bed', 'WastedSounds', true)
        -- You can add more alarm sounds here
    end
end

-- ============================================================
-- C) STEP PROGRESSION & ACTIONS
-- ============================================================

local function runHeistThread(heistId, heist)
    CreateThread(function()
        local heistStartPos = vecFromTable(heist.start)
        local maxDistance = 80.0 -- Abort if player goes too far
        local heistRadius = 50.0 -- Abort if player leaves heist radius
        
        while currentHeistId == heistId do
            local ped = PlayerPedId()
            if not ped or ped == 0 then
                -- F) Player logged out
                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                break
            end
            
            local pCoords = GetEntityCoords(ped)
            
            -- F) ABORT CONDITIONS
            if IsEntityDead(ped) then
                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                break
            end
            
            local distFromStart = #(pCoords - heistStartPos)
            if distFromStart > maxDistance then
                lib.notify({
                    description = 'You left the heist area!',
                    type = 'error'
                })
                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                break
            end
            
            -- Get current step
            local stepIndex = ActiveStep[heistId] or 1
            local step = heist.steps[stepIndex]
            
            if not step then
                -- No more steps, check for escape
                break
            end
            
            currentStepIndex = stepIndex
            local stepPos = vecFromTable(step.coords)
            local dist = #(pCoords - stepPos)
            
            -- Draw marker when near
            if dist < 25.0 then
                DrawMarker(
                    1,
                    stepPos.x, stepPos.y, stepPos.z - 1.0,
                    0.0, 0.0, 0.0,
                    0.0, 0.0, 0.0,
                    1.0, 1.0, 1.0,
                    255, 165, 0, 150,
                    false, true, 2, false, nil, nil, false
                )
            end
            
            if dist < (step.radius or 1.5) then
                -- C) Check if this is the active step
                if ActiveStep[heistId] ~= stepIndex then
                    lib.hideTextUI()
                    goto continue_step_loop
                end
                
                lib.showTextUI(('[E] %s'):format(step.label or 'Do step'))
                
                if IsControlJustPressed(0, 38) then
                    lib.hideTextUI()
                    
                    -- Trigger alert/alarm
                    handleStepAlert(heistId, heist, step)
                    
                    local success = false
                    local lootKey = ('step_%s'):format(stepIndex)
                    
                    -- E) Check if already looted
                    if alreadyLooted[heistId] and alreadyLooted[heistId][lootKey] then
                        lib.notify({
                            description = 'This has already been completed.',
                            type = 'error'
                        })
                        goto continue_step_loop
                    end
                    
                    -- Handle different action types
                    if step.action == 'hack' then
                        RequestAnimDict('anim@heists@prison_heiststation@cop_reactions')
                        while not HasAnimDictLoaded('anim@heists@prison_heiststation@cop_reactions') do Wait(0) end
                        
                        TaskPlayAnim(ped, 'anim@heists@prison_heiststation@cop_reactions', 'console_peek_a', 8.0, -8.0, -1, 1, 0.0, false, false, false)
                        
                        -- Skill check
                        local difficulty = step.difficulty or { 'easy', 'medium', 'hard' }
                        local inputs = step.inputs or nil
                        local result = lib.skillCheck(difficulty, inputs)
                        
                        if result then
                            local hackDuration = step.time or 5000
                            local progressResult = lib.progressCircle({
                                duration = hackDuration,
                                label = step.label or 'Hacking...',
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = { move = true, car = true, combat = true },
                            })
                            
                            if not progressResult then
                                -- F) Player cancelled
                                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                                currentHeistId = nil
                                break
                            end
                            
                            success = true
                        else
                            lib.notify({
                                description = 'Hack failed!',
                                type = 'error'
                            })
                            success = false
                        end
                        ClearPedTasks(ped)
                        
                    elseif step.action == 'drill' then
                        -- Check for safe key
                        local keyName = "safe_key_"..heistId
                        local hasKey = false
                        
                        if exports['ox_inventory'] then
                            local searchResult = exports['ox_inventory']:Search('count', keyName)
                            if type(searchResult) == 'number' then
                                hasKey = searchResult > 0
                            elseif type(searchResult) == 'table' then
                                if searchResult[keyName] then
                                    hasKey = searchResult[keyName] > 0
                                end
                            end
                        end
                        
                        if hasKey then
                            local progressResult = lib.progressCircle({
                                duration = 3500,
                                label = "Unlocking safe with key...",
                                position = 'bottom',
                                disable = { move = true, car = true, combat = true },
                                canCancel = true
                            })
                            
                            if not progressResult then
                                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                                currentHeistId = nil
                                break
                            end
                            
                            TriggerServerEvent('cs_heistmaster:safeReward', heistId)
                            TriggerServerEvent('cs_heistmaster:removeSafeKey', heistId)
                            lib.notify({
                                title = 'Safe',
                                description = 'You unlocked the safe silently!',
                                type = 'success'
                            })
                            success = true
                        else
                            local duration = step.time or 20000
                            RequestAnimDict('anim@heists@fleeca_bank@drilling')
                            while not HasAnimDictLoaded('anim@heists@fleeca_bank@drilling') do Wait(0) end
                            
                            TaskPlayAnim(ped, 'anim@heists@fleeca_bank@drilling', 'drill_straight_idle', 8.0, -8.0, duration, 1, 0.0, false, false, false)
                            
                            local progressResult = lib.progressCircle({
                                duration = duration,
                                label = step.label or 'Drilling...',
                                position = 'bottom',
                                useWhileDead = false,
                                canCancel = true,
                                disable = { move = true, car = true, combat = true },
                            })
                            
                            ClearPedTasks(ped)
                            
                            if not progressResult then
                                TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                                currentHeistId = nil
                                break
                            end
                            
                            -- Open vault door for Fleeca
                            if heist.heistType == 'fleeca' and heist.vault then
                                TriggerServerEvent('cs_heistmaster:server:setVaultOpen', heistId)
                            end
                            
                            success = true
                        end
                        
                    elseif step.action == 'smash' then
                        RequestAnimDict('melee@unarmed@streamed_core_fps')
                        while not HasAnimDictLoaded('melee@unarmed@streamed_core_fps') do Wait(0) end
                        
                        TaskPlayAnim(ped, 'melee@unarmed@streamed_core_fps', 'ground_attack_0', 8.0, -8.0, step.time or 4000, 0, 0.0, false, false, false)
                        
                        local progressResult = lib.progressCircle({
                            duration = step.time or 4000,
                            label = step.label or 'Smashing...',
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = { move = true, car = true, combat = true },
                        })
                        
                        ClearPedTasks(ped)
                        
                        if not progressResult then
                            TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                            currentHeistId = nil
                            break
                        end
                        
                        success = true
                        
                    elseif step.action == 'loot' then
                        RequestAnimDict('anim@heists@ornate_bank@grab_cash')
                        while not HasAnimDictLoaded('anim@heists@ornate_bank@grab_cash') do Wait(0) end
                        
                        TaskPlayAnim(ped, 'anim@heists@ornate_bank@grab_cash', 'grab', 8.0, -8.0, -1, 1, 0.0, false, false, false)
                        
                        local lootDuration = step.time or 3000
                        local progressResult = lib.progressCircle({
                            duration = lootDuration,
                            label = step.label or 'Looting...',
                            position = 'bottom',
                            useWhileDead = false,
                            canCancel = true,
                            disable = { move = true, car = true, combat = true },
                        })
                        
                        ClearPedTasks(ped)
                        
                        if not progressResult then
                            TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                            currentHeistId = nil
                            break
                        end
                        
                        -- E) Mark as looted and request reward
                        alreadyLooted[heistId] = alreadyLooted[heistId] or {}
                        alreadyLooted[heistId][lootKey] = true
                        TriggerServerEvent('cs_heistmaster:server:giveLoot', heistId, lootKey)
                        
                        success = true
                        
                    elseif step.action == 'escape' then
                        -- G) ESCAPE STEP
                        local escapePos = vecFromTable(step.coords)
                        local distFromEscape = #(pCoords - escapePos)
                        local escapeRadius = step.radius or 5.0
                        
                        -- Check if player is within escape radius
                        if distFromEscape <= escapeRadius then
                            -- Player is at escape point, finish heist
                            success = true
                        else
                            lib.notify({
                                description = 'You need to reach the escape point!',
                                type = 'error'
                            })
                            success = false
                        end
                    end
                    
                    -- Handle step completion
                    if success then
                        -- E) Mark step as completed (if not already marked for loot)
                        if step.action ~= 'loot' then
                            alreadyLooted[heistId] = alreadyLooted[heistId] or {}
                            alreadyLooted[heistId][lootKey] = true
                        end
                        
                        -- C) Notify server step is complete
                        TriggerServerEvent("cs_heistmaster:server:completeStep", heistId, stepIndex)
                        
                        local nextStepIndex = stepIndex + 1
                        local nextStep = heist.steps[nextStepIndex]
                        
                        if not nextStep then
                            -- Finished all steps
                            TriggerServerEvent('cs_heistmaster:finishHeist', heistId)
                            currentHeistId = nil
                            break
                        else
                            lib.notify({
                                description = 'Objective complete. Move to the next location.',
                                type = 'success'
                            })
                        end
                    else
                        lib.notify({
                            description = 'You failed the objective!',
                            type = 'error'
                        })
                        -- F) Abort on failure
                        TriggerServerEvent('cs_heistmaster:abortHeist', heistId)
                        currentHeistId = nil
                        break
                    end
                end
            else
                lib.hideTextUI()
            end
            
            ::continue_step_loop::
            Wait(0)
        end
    end)
end

-- ============================================================
-- A) REALISTIC START SYSTEM
-- ============================================================

-- A1) Start Zone Trigger
CreateThread(function()
    while true do
        Wait(250)
        
        local ped = PlayerPedId()
        if IsPedInAnyVehicle(ped) then
            lib.hideTextUI()
            goto continue_start_loop
        end
        
        local coords = GetEntityCoords(ped)
        local anyPrompt = false
        
        for heistId, heist in pairs(Config.Heists) do
            local state = HeistClientState[heistId] or "idle"
            
            if state ~= "idle" then
                goto continue_heist_start
            end
            
            -- Skip store heists (handled by clerk)
            if heist.heistType == 'store' then
                goto continue_heist_start
            end
            
            if heist.start then
                local startPos = vector3(heist.start.x, heist.start.y, heist.start.z)
                local dist = #(coords - startPos)
                
                if dist < 2.0 then
                    anyPrompt = true
                    lib.showTextUI("[E] Start " .. heist.label)
                    
                    if IsControlJustReleased(0, 38) then
                        lib.hideTextUI()
                        TriggerServerEvent("cs_heistmaster:requestStart", heistId)
                        Wait(1000)
                    end
                end
            end
            
            ::continue_heist_start::
        end
        
        if not anyPrompt then
            lib.hideTextUI()
        end
        
        ::continue_start_loop::
    end
end)

-- A2) Clerk System
local function spawnClerkForHeist(heistId, clerkData)
    if SpawnedClerks[heistId] and DoesEntityExist(SpawnedClerks[heistId]) then
        return SpawnedClerks[heistId]
    end
    
    local model = joaat(clerkData.npcModel or 'mp_m_shopkeep_01')
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(0) end
    
    local ped = CreatePed(4, model, clerkData.coords.x, clerkData.coords.y, clerkData.coords.z - 1.0, clerkData.coords.heading or 0.0, false, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedFleeAttributes(ped, 0, 0)
    FreezeEntityPosition(ped, true)
    
    SpawnedClerks[heistId] = ped
    return ped
end

CreateThread(function()
    Wait(2000)
    
    while true do
        Wait(0)
        
        local ped = PlayerPedId()
        local pCoords = GetEntityCoords(ped)
        local hasGun = IsPedArmed(ped, 4)
        local aiming = IsPlayerFreeAiming(PlayerId())
        
        for heistId, heist in pairs(Heists) do
            if heist.heistType == 'store' and heist.clerk and heist.clerk.enabled then
                local state = HeistClientState[heistId] or "idle"
                
                if state == "cooldown" then
                    goto continue_clerk
                end
                
                local clerkPed = SpawnedClerks[heistId]
                if not clerkPed or not DoesEntityExist(clerkPed) then
                    clerkPed = spawnClerkForHeist(heistId, heist.clerk)
                end
                
                local clerkCoords = GetEntityCoords(clerkPed)
                local dist = #(pCoords - clerkCoords)
                
                if dist > 10.0 then
                    goto continue_clerk
                end
                
                -- Initialize runtime state
                ClerkRuntimeState[heistId] = ClerkRuntimeState[heistId] or { panicked = false, gaveKey = false, aggroTimer = 0 }
                local rt = ClerkRuntimeState[heistId]
                
                -- A3) Aggro Start - gun pointing for >2 seconds
                if dist < 5.0 and hasGun and aiming then
                    rt.aggroTimer = (rt.aggroTimer or 0) + 1
                    
                    if rt.aggroTimer > 120 then -- 2 seconds at 60fps
                        -- Auto-start heist
                        if state == "idle" then
                            TriggerServerEvent('cs_heistmaster:requestStart', heistId)
                            rt.aggroTimer = 0
                            Wait(1500)
                        end
                    end
                    
                    -- Surrender animation
                    if heist.clerk.surrenderAnim then
                        RequestAnimDict('missfbi5ig_22')
                        while not HasAnimDictLoaded('missfbi5ig_22') do Wait(0) end
                        TaskPlayAnim(clerkPed, 'missfbi5ig_22', 'hands_up_anxious_scared', 8.0, -8.0, -1, 1, 0, false, false, false)
                    end
                    
                    -- Panic logic (only once)
                    if not rt.panicked then
                        if math.random(1, 100) <= (heist.clerk.panicChance or 60) then
                            rt.panicked = true
                            TriggerServerEvent('cs_heistmaster:clerkPanic', heistId)
                        end
                    end
                    
                    -- Safe key logic (only once)
                    if not rt.gaveKey and (heist.clerk.safeKeyChance or 0) > 0 then
                        if math.random(1, 100) <= heist.clerk.safeKeyChance then
                            rt.gaveKey = true
                            
                            RequestAnimDict("mp_common")
                            while not HasAnimDictLoaded("mp_common") do Wait(0) end
                            TaskPlayAnim(clerkPed, "mp_common", "givetake1_a", 8.0, -8.0, 2000, 1, 0, false, false, false)
                            
                            TriggerServerEvent("cs_heistmaster:giveSafeKey", heistId)
                            
                            lib.notify({
                                title = "Clerk",
                                description = "The clerk gave you a safe key!",
                                type = "success"
                            })
                        end
                    end
                    
                    -- Show interact prompt
                    if dist < 2.0 then
                        if state == "idle" then
                            lib.showTextUI("[E] Interact with clerk")
                            
                            if IsControlJustPressed(0, 38) then
                                lib.hideTextUI()
                                TriggerServerEvent('cs_heistmaster:requestStart', heistId)
                                Wait(1500)
                            end
                        end
                    end
                else
                    rt.aggroTimer = 0
                    if dist > 5.0 then
                        lib.hideTextUI()
                    end
                end
            end
            
            ::continue_clerk::
        end
    end
end)
