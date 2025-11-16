local Robbery = {}
local Utils = CS_HEIST_SHARED_UTILS or {}

local ActiveRobberies = {}
local ActiveGuards = {}
local ActiveTellers = {}
local CashRegisters = {}

local function spawnGuard(robberyId, guardData)
    local coords = guardData.coords or {}
    local model = guardData.model or 's_m_m_security_01'
    local weapon = guardData.weapon or 'WEAPON_CARBINERIFLE'
    
    CreateThread(function()
        local ped = CreatePed(4, GetHashKey(model), coords.x, coords.y, coords.z, coords.w or 0.0, true, true)
        if not DoesEntityExist(ped) then return end
        
        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 0, false)
        SetPedCombatAttributes(ped, 46, true)
        SetPedCombatAbility(ped, 2)
        SetPedAccuracy(ped, 70)
        SetPedCanSwitchWeapon(ped, true)
        GiveWeaponToPed(ped, GetHashKey(weapon), 250, false, true)
        SetPedDropsWeaponsWhenDead(ped, false)
        SetEntityInvincible(ped, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskGuardCurrentPosition(ped, 15.0, 15.0, 1)
        
        local netId = NetworkGetNetworkIdFromEntity(ped)
        ActiveGuards[netId] = {
            ped = ped,
            robberyId = robberyId,
            guardData = guardData
        }
        
        SetNetworkIdCanMigrate(netId, false)
        TriggerClientEvent('cs_heistbuilder:client:guardSpawned', -1, netId, robberyId, coords)
    end)
end

local function spawnTeller(robberyId, tellerData)
    local coords = tellerData.coords or {}
    local model = tellerData.model or 's_f_y_shop_low'
    
    CreateThread(function()
        local ped = CreatePed(4, GetHashKey(model), coords.x, coords.y, coords.z, coords.w or 0.0, true, true)
        if not DoesEntityExist(ped) then return end
        
        SetEntityAsMissionEntity(ped, true, true)
        SetPedFleeAttributes(ped, 512, true)
        SetPedCombatAttributes(ped, 0, false)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskStandStill(ped, -1)
        
        local netId = NetworkGetNetworkIdFromEntity(ped)
        ActiveTellers[netId] = {
            ped = ped,
            robberyId = robberyId,
            tellerData = tellerData
        }
        
        SetNetworkIdCanMigrate(netId, false)
        TriggerClientEvent('cs_heistbuilder:client:tellerSpawned', -1, netId, robberyId, coords)
    end)
end

local function spawnCashRegister(robberyId, registerData)
    local coords = registerData.coords or {}
    local model = registerData.model or `prop_till_01`
    
    CreateThread(function()
        local obj = CreateObject(model, coords.x, coords.y, coords.z, false, true, true)
        if not DoesEntityExist(obj) then return end
        
        SetEntityAsMissionEntity(obj, true, true)
        FreezeEntityPosition(obj, true)
        -- Make register vulnerable to damage
        SetEntityProofs(obj, false, false, false, false, false, false, false, false)
        SetEntityHealth(obj, 100)
        SetEntityMaxHealth(obj, 100)
        
        local netId = NetworkGetNetworkIdFromEntity(obj)
        CashRegisters[netId] = {
            obj = obj,
            robberyId = robberyId,
            registerData = registerData,
            opened = false
        }
        
        SetNetworkIdCanMigrate(netId, false)
        TriggerClientEvent('cs_heistbuilder:client:registerSpawned', -1, netId, robberyId, coords)
    end)
end

function Robbery.spawnRobbery(heist)
    if ActiveRobberies[heist.id] then return end
    
    local robberyType = heist.type or 'bank'
    ActiveRobberies[heist.id] = {
        heist = heist,
        type = robberyType,
        guardsKilled = 0,
        tellersKilled = 0,
        requiredGuards = 0,
        requiredTellers = 0,
        activated = false,
        registers = {}
    }
    
    local state = ActiveRobberies[heist.id]
    
    -- Count required guards/tellers
    if heist.guards then
        state.requiredGuards = #heist.guards
        for _, guard in ipairs(heist.guards) do
            spawnGuard(heist.id, guard)
        end
    end
    
    -- For stores: spawn tellers and cash registers
    if robberyType == 'store' then
        if heist.tellers then
            state.requiredTellers = #heist.tellers
            for _, teller in ipairs(heist.tellers) do
                spawnTeller(heist.id, teller)
            end
        end
        
        if heist.cashRegisters then
            for _, register in ipairs(heist.cashRegisters) do
                spawnCashRegister(heist.id, register)
            end
        end
    end
    
    TriggerClientEvent('cs_heistbuilder:client:robberyReady', -1, heist.id, heist)
end

function Robbery.checkGuardKill(netId, attacker)
    local guardData = ActiveGuards[netId]
    if not guardData then return end
    
    local robberyId = guardData.robberyId
    local state = ActiveRobberies[robberyId]
    if not state or state.activated then return end
    
    local ped = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(ped) or not IsEntityDead(ped) then return end
    
    state.guardsKilled = state.guardsKilled + 1
    ActiveGuards[netId] = nil
    
    local msg = ('Guard eliminated (%d/%d)'):format(state.guardsKilled, state.requiredGuards)
    TriggerClientEvent('cs_heistbuilder:client:robberyUpdate', -1, robberyId, msg)
    
    -- Check if all guards are dead
    if state.guardsKilled >= state.requiredGuards then
        if state.type == 'store' then
            -- For stores, wait for tellers too
            if state.tellersKilled >= state.requiredTellers then
                Robbery.activateRobbery(robberyId, attacker)
            end
        else
            -- For banks, activate immediately
            Robbery.activateRobbery(robberyId, attacker)
        end
    end
end

function Robbery.checkTellerKill(netId, attacker)
    local tellerData = ActiveTellers[netId]
    if not tellerData then return end
    
    local robberyId = tellerData.robberyId
    local state = ActiveRobberies[robberyId]
    if not state or state.activated then return end
    
    local ped = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(ped) or not IsEntityDead(ped) then return end
    
    state.tellersKilled = state.tellersKilled + 1
    ActiveTellers[netId] = nil
    
    local msg = ('Teller eliminated (%d/%d)'):format(state.tellersKilled, state.requiredTellers)
    TriggerClientEvent('cs_heistbuilder:client:robberyUpdate', -1, robberyId, msg)
    
    -- For stores, check if all guards and tellers are dead
    if state.type == 'store' and state.guardsKilled >= state.requiredGuards and state.tellersKilled >= state.requiredTellers then
        Robbery.activateRobbery(robberyId, attacker)
    end
end

function Robbery.activateRobbery(robberyId, activator)
    local state = ActiveRobberies[robberyId]
    if not state or state.activated then return end
    
    state.activated = true
    
    TriggerClientEvent('cs_heistbuilder:client:robberyActivated', -1, robberyId)
    
    -- For stores, show register locations
    if state.type == 'store' and state.heist.cashRegisters then
        TriggerClientEvent('cs_heistbuilder:client:registersReady', -1, robberyId, state.heist.cashRegisters)
    end
    
    -- Start the heist for the activator
    if activator then
        TriggerEvent('cs_heistbuilder:internal:startRobbery', activator, robberyId)
    end
end

function Robbery.checkRegisterHit(netId, attacker)
    local registerData = CashRegisters[netId]
    if not registerData or registerData.opened then return end
    
    local robberyId = registerData.robberyId
    local state = ActiveRobberies[robberyId]
    if not state or not state.activated then
        if attacker then
            TriggerClientEvent('cs_heistbuilder:client:robberyUpdate', attacker, robberyId, 'Eliminate guards and tellers first!')
        end
        return
    end
    
    local obj = NetworkGetEntityFromNetworkId(netId)
    if not DoesEntityExist(obj) then return end
    
    -- Check if register was shot - health below 100 means it's been damaged
    local health = GetEntityHealth(obj)
    if health < 100 then
        registerData.opened = true
        
        -- Prevent further damage
        SetEntityHealth(obj, 100)
        FreezeEntityPosition(obj, true)
        
        -- Spawn money
        local coords = registerData.registerData.coords or {}
        local amount = math.random(registerData.registerData.minCash or 500, registerData.registerData.maxCash or 1500)
        
        TriggerClientEvent('cs_heistbuilder:client:registerOpened', -1, netId, coords, amount)
        
        -- Give money to attacker
        if attacker then
            if exports['qbx_core'] and exports['qbx_core'].Functions and exports['qbx_core'].Functions.AddMoney then
                exports['qbx_core'].Functions.AddMoney(attacker, 'cash', amount, 'store_robbery')
            else
                exports['ox_inventory']:AddItem(attacker, 'cash', amount)
            end
            
            TriggerClientEvent('cs_heistbuilder:client:lootCollected', attacker, amount)
        end
    end
end

function Robbery.cleanupRobbery(robberyId)
    if not ActiveRobberies[robberyId] then return end
    
    -- Clean up guards
    for netId, guardData in pairs(ActiveGuards) do
        if guardData.robberyId == robberyId then
            local ped = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(ped) then
                DeleteEntity(ped)
            end
            ActiveGuards[netId] = nil
        end
    end
    
    -- Clean up tellers
    for netId, tellerData in pairs(ActiveTellers) do
        if tellerData.robberyId == robberyId then
            local ped = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(ped) then
                DeleteEntity(ped)
            end
            ActiveTellers[netId] = nil
        end
    end
    
    -- Clean up registers
    for netId, registerData in pairs(CashRegisters) do
        if registerData.robberyId == robberyId then
            local obj = NetworkGetEntityFromNetworkId(netId)
            if DoesEntityExist(obj) then
                DeleteEntity(obj)
            end
            CashRegisters[netId] = nil
        end
    end
    
    ActiveRobberies[robberyId] = nil
    TriggerClientEvent('cs_heistbuilder:client:robberyCleaned', -1, robberyId)
end

function Robbery.getRobberyState(robberyId)
    return ActiveRobberies[robberyId]
end

-- Track guard kills
AddEventHandler('entityDamaged', function(victim, damageData)
    if not victim or not DoesEntityExist(victim) then return end
    if IsPedAPlayer(victim) then return end
    
    local netId = NetworkGetNetworkIdFromEntity(victim)
    if ActiveGuards[netId] then
        if IsEntityDead(victim) then
            local attacker = damageData.damagedBy and damageData.damagedBy.entity or nil
            local attackerSrc = attacker and NetworkGetEntityOwner(attacker) or nil
            Robbery.checkGuardKill(netId, attackerSrc)
        end
    elseif ActiveTellers[netId] then
        if IsEntityDead(victim) then
            local attacker = damageData.damagedBy and damageData.damagedBy.entity or nil
            local attackerSrc = attacker and NetworkGetEntityOwner(attacker) or nil
            Robbery.checkTellerKill(netId, attackerSrc)
        end
    end
end)

-- Track register hits
AddEventHandler('entityDamaged', function(victim, damageData)
    if not victim or not DoesEntityExist(victim) then return end
    if IsPedAPlayer(victim) then return end
    
    local netId = NetworkGetNetworkIdFromEntity(victim)
    if CashRegisters[netId] then
        local attacker = damageData.damagedBy and damageData.damagedBy.entity or nil
        local attackerSrc = attacker and NetworkGetEntityOwner(attacker) or nil
        Robbery.checkRegisterHit(netId, attackerSrc)
    end
end)

-- Server events from client
RegisterNetEvent('cs_heistbuilder:server:guardKilled', function(netId)
    local src = source
    Robbery.checkGuardKill(netId, src)
end)

RegisterNetEvent('cs_heistbuilder:server:tellerKilled', function(netId)
    local src = source
    Robbery.checkTellerKill(netId, src)
end)

RegisterNetEvent('cs_heistbuilder:server:registerHit', function(netId)
    local src = source
    Robbery.checkRegisterHit(netId, src)
end)

-- Start robbery event
AddEventHandler('cs_heistbuilder:internal:startRobbery', function(source, robberyId)
    local heist = Robbery.getRobberyState(robberyId)
    if not heist then return end
    
    -- Trigger normal heist start
    TriggerEvent('cs_heistbuilder:internal:startTest', source, robberyId)
end)

CS_HEIST_ROBBERY = Robbery

return Robbery

