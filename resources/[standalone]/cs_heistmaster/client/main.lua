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
-- BANK GUARD SYSTEM (Start heist when guards are shot)
-- ============================================================

local BankGuards = {} -- [heistId] = {ped1, ped2, ...}

function SpawnBankGuards(heistId)
    local heist = Config.Heists[heistId]
    if not heist or not heist.guards or #heist.guards == 0 then return end

    -- Only cleanup if guards already exist (for respawn scenarios)
    if BankGuards[heistId] then
        for _, ped in ipairs(BankGuards[heistId]) do
            if DoesEntityExist(ped) then DeletePed(ped) end
        end
    end

    BankGuards[heistId] = {}

    for _, g in ipairs(heist.guards) do
        local model = joaat(g.model or 's_m_m_security_01')
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(10) end

        local coords = vecFromTable(g.coords, g.coords.w or 0.0)
        local ped = CreatePed(4, model, coords.x, coords.y, coords.z, coords.w or 0.0, true, true)
        
        SetEntityAsMissionEntity(ped, true, true)
        SetPedArmour(ped, g.armor or 50)
        SetPedAccuracy(ped, g.accuracy or 50)
        GiveWeaponToPed(ped, joaat(g.weapon or 'weapon_pistol'), 250, false, true)

        SetPedRelationshipGroupHash(ped, joaat('BANK_GUARD'))
        SetPedCanRagdoll(ped, true)
        SetPedFleeAttributes(ped, 0, false)
        SetPedCombatRange(ped, 0)
        SetPedAlertness(ped, 0) -- Start passive
        SetPedCombatAttributes(ped, 46, true)
        SetBlockingOfNonTemporaryEvents(ped, false) -- Allow them to react

        table.insert(BankGuards[heistId], ped)
        debugPrint(('Bank guard spawned for heist: %s'):format(heistId))
    end
end

function IsBankGuard(entity)
    for heistId, guardList in pairs(BankGuards) do
        for _, ped in ipairs(guardList) do
            if entity == ped then
                return heistId
            end
        end
    end
    return false
end

-- Track which heists have been auto-started to prevent double-triggering
local BankHeistStarted = {} -- [heistId] = true
local StoreHeistStarted = {} -- [heistId] = true

-- Auto-start heist when guards are shot
AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= "CEventNetworkEntityDamage" then return end

    local victim = args[1]
    local attacker = args[2]

    if not DoesEntityExist(victim) or not DoesEntityExist(attacker) then return end
    if attacker ~= PlayerPedId() then return end

    local heistId = IsBankGuard(victim)
    if not heistId then return end

    -- Prevent double-triggering
    if BankHeistStarted[heistId] then return end

    local state = HeistClientState[heistId] or "idle"
    if state ~= "idle" then return end -- Already started

    -- Mark as started to prevent duplicate triggers
    BankHeistStarted[heistId] = true

    -- START HEIST
    debugPrint(('Bank heist auto-started by shooting guard: %s'):format(heistId))
    TriggerServerEvent("cs_heistmaster:requestStart", heistId)

    -- Make guards aggressive after start (with delay to ensure heist initialized)
    CreateThread(function()
        Wait(1000) -- Wait for heist to initialize
        if BankGuards[heistId] then
            for _, ped in ipairs(BankGuards[heistId]) do
                if DoesEntityExist(ped) then
                    SetPedAlertness(ped, 3)
                    SetPedCombatAttributes(ped, 46, true)
                    SetPedCombatRange(ped, 2)
                    SetPedCombatMovement(ped, 2)
                    TaskCombatPed(ped, PlayerPedId(), 0, 16)
                end
            end
        end
    end)
end)

-- ============================================================
-- STORE CLERK SYSTEM (Start heist when aiming gun at clerk)
-- ============================================================

local StoreClerks = {}

function SpawnClerk(heistId)
    local heist = Config.Heists[heistId]
    if not heist or not heist.clerk or not heist.clerk.enabled then return end

    -- Only cleanup if clerk already exists (for respawn scenarios)
    if StoreClerks[heistId] and DoesEntityExist(StoreClerks[heistId]) then
        DeletePed(StoreClerks[heistId])
    end

    local modelName = heist.clerk.npcModel or 'mp_m_shopkeep_01'
    local model = joaat(modelName)
    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local coords = vecFromTable(heist.clerk.coords, heist.clerk.coords.heading or 0.0)
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z, coords.w or 0.0, true, true)

    SetEntityAsMissionEntity(ped, true, true)
    SetPedCanRagdoll(ped, true)
    SetPedFleeAttributes(ped, 0, false)
    SetPedDropsWeaponsWhenDead(ped, false)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, false) -- Allow movement if needed
    
    -- Start scenario at register
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_STAND_IMPATIENT", 0, true)

    StoreClerks[heistId] = ped
    SpawnedClerks[heistId] = ped -- Keep compatibility with existing code
    debugPrint(('Store clerk spawned for heist: %s'):format(heistId))
end

-- Detect aiming a gun at clerk
CreateThread(function()
    while true do
        Wait(150)

        local player = PlayerPedId()
        if not DoesEntityExist(player) then goto continue_store_loop end

        -- Check if player has weapon and is aiming
        if not IsPedArmed(player, 4) then goto continue_store_loop end
        if not IsPlayerFreeAiming(PlayerId()) then goto continue_store_loop end

        local aiming, target = GetEntityPlayerIsFreeAimingAt(PlayerId())

        if aiming and IsEntityAPed(target) and DoesEntityExist(target) then
            for heistId, clerkPed in pairs(StoreClerks) do
                if not DoesEntityExist(clerkPed) then goto continue_clerk_check end
                if target ~= clerkPed then goto continue_clerk_check end

                -- Prevent double-triggering
                if StoreHeistStarted[heistId] then goto continue_clerk_check end

                local state = HeistClientState[heistId] or "idle"
                if state ~= "idle" then goto continue_clerk_check end -- Already started

                -- Check distance (max 10 meters)
                local playerCoords = GetEntityCoords(player)
                local clerkCoords = GetEntityCoords(clerkPed)
                local dist = #(playerCoords - clerkCoords)
                if dist > 10.0 then goto continue_clerk_check end

                -- Mark as started to prevent duplicate triggers
                StoreHeistStarted[heistId] = true

                -- Clerk panics and gives up
                ClearPedTasksImmediately(clerkPed)
                TaskHandsUp(clerkPed, 7000, player, -1, true)

                -- Start heist
                debugPrint(('Store heist auto-started by aiming at clerk: %s'):format(heistId))
                TriggerServerEvent("cs_heistmaster:requestStart", heistId)

                -- Optional: key chance
                local heist = Config.Heists[heistId]
                if heist and heist.clerk and (heist.clerk.safeKeyChance or 0) > 0 then
                    if math.random(1, 100) <= heist.clerk.safeKeyChance then
                        TriggerServerEvent("cs_heistmaster:giveSafeKey", heistId)
                        lib.notify({
                            title = "Clerk",
                            description = "The clerk gave you a safe key!",
                            type = "success"
                        })
                    end
                end

                -- Alert Police (panic)
                TriggerServerEvent("cs_heistmaster:clerkPanic", heistId)

                Wait(5000) -- Prevent spam
                ::continue_clerk_check::
            end
        end
        ::continue_store_loop::
    end
end)


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
    -- Cleanup guards (server-spawned)
    if guards[heistId] then
        for _, ped in ipairs(guards[heistId]) do
            if DoesEntityExist(ped) then DeletePed(ped) end
        end
        guards[heistId] = nil
    end
    
    -- DO NOT delete bank guards on cleanup - they should persist
    -- Bank guards are only deleted when resource stops or heist is reset
    
    -- Cleanup clerk
    if SpawnedClerks[heistId] then
        local clerkPed = SpawnedClerks[heistId]
        if DoesEntityExist(clerkPed) then
            DeletePed(clerkPed)
        end
        SpawnedClerks[heistId] = nil
    end
    
    if StoreClerks[heistId] then
        StoreClerks[heistId] = nil
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
    BankHeistStarted[heistId] = nil -- Reset start flag for next heist
    StoreHeistStarted[heistId] = nil -- Reset start flag for next heist
    
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
                
                -- NO UI PROMPTS - Actions trigger automatically when player begins the action
                -- Detect action initiation based on step type
                local actionStarted = false
                
                -- Detect action initiation based on step type
                if step.action == 'hack' then
                    -- Hack starts when player presses E
                    if IsControlJustPressed(0, 38) then
                        actionStarted = true
                    end
                elseif step.action == 'drill' then
                    -- Drill starts when player presses E
                    if IsControlJustPressed(0, 38) then
                        actionStarted = true
                    end
                elseif step.action == 'smash' then
                    -- Smash starts when player attacks (melee or weapon)
                    if IsControlJustPressed(0, 24) or (IsPedArmed(ped, 4) and IsControlJustPressed(0, 25)) then
                        actionStarted = true
                    end
                elseif step.action == 'loot' then
                    -- Loot starts when player presses E
                    if IsControlJustPressed(0, 38) then
                        actionStarted = true
                    end
                else
                    -- Custom actions: start on E press
                    if IsControlJustPressed(0, 38) then
                        actionStarted = true
                    end
                end
                
                if actionStarted then
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
-- SPAWN GUARDS AND CLERKS ON RESOURCE START
-- ============================================================

CreateThread(function()
    Wait(2000) -- Wait for config to load
    
    for heistId, heist in pairs(Heists) do
        -- Spawn bank guards for bank heists (fleeca, etc.)
        if (heist.heistType == 'fleeca' or heist.heistType == 'bank') and heist.guards then
            SpawnBankGuards(heistId)
        end
        
        -- Spawn clerks for store heists
        if heist.heistType == 'store' and heist.clerk and heist.clerk.enabled then
            SpawnClerk(heistId)
        end
    end
end)
