local QBCore
local coreRes -- 'qbx_core' or 'qb-core'

local function tryGetCore(res, fnName)
    local ok, obj = pcall(function()
        return exports[res][fnName] and exports[res][fnName](exports[res]) or nil
    end)
    return ok and obj or nil
end

CreateThread(function()
    -- wait for either core to actually be started
    while true do
        if GetResourceState('qbx_core') == 'started' then
            coreRes = 'qbx_core'
        elseif GetResourceState('qb-core') == 'started' then
            coreRes = 'qb-core'
        end

        if coreRes then
            -- try both common export names, tolerate different cores
            QBCore = tryGetCore(coreRes, 'GetCoreObject') or tryGetCore(coreRes, 'GetQBCoreObject')
            if QBCore then
                print(('[qb-core-bridge] Hooked %s successfully.'):format(coreRes))
                break
            end
        end

        Wait(500)
    end

    print('[qb-core-bridge] Ready — waiting for qb-admin requests.')
end)

-- ===========
--  VEHICLES
-- ===========

-- qb-admin (legacy) calls this; we forward to client to actually spawn.
RegisterNetEvent('QBCore:Server:SpawnVehicle', function(model, plate, props)
    local src = source
    TriggerClientEvent('qb-core-bridge:client:spawnVehicle', src, model, plate, props)
    print(('[qb-core-bridge] SpawnVehicle -> %s %s'):format(tostring(model), tostring(plate)))
end)

-- ===========
--   ITEMS
-- ===========

-- Give item to target id (admin menu usually passes these)
RegisterNetEvent('QBCore:Server:AddItem', function(target, name, amount, slot, info)
    if not QBCore then return end
    local Player = QBCore.Functions.GetPlayer(tonumber(target))
    if not Player then return end
    local ok = Player.Functions.AddItem(name, tonumber(amount or 1), slot, info)
    if ok then
        TriggerClientEvent('inventory:client:ItemBox', Player.PlayerData.source, QBCore.Shared.Items[name], "add", tonumber(amount or 1))
    end
    print(('[qb-core-bridge] AddItem -> id:%s item:%s x%s'):format(target, name, amount or 1))
end)
RegisterNetEvent('qb-core-bridge:client:spawnVehicle', function(model, plate, props)
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)

    if not IsModelInCdimage(model) or not IsModelAVehicle(model) then
        print(("[qb-core-bridge] Invalid vehicle model: %s"):format(model))
        return
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(0)
    end

    local veh = CreateVehicle(model, pos.x + 2.0, pos.y, pos.z, heading, true, false)
    SetPedIntoVehicle(playerPed, veh, -1)
    SetVehicleNumberPlateText(veh, plate or "ADMIN")
    SetEntityAsMissionEntity(veh, true, true)

    if props then
        QBCore.Functions.SetVehicleProperties(veh, props)
    end

    SetModelAsNoLongerNeeded(model)
    print(("[qb-core-bridge] Vehicle spawned: %s"):format(model))
end)
