local QBCore = exports['qbx_core']:GetCoreObject()

-- Make GetCoreObject export work for older qb scripts
exports('GetCoreObject', function()
    return QBCore
end)

-- 🏎️ Spawn vehicle (used by qb-admin)
RegisterNetEvent('QBCore:Server:SpawnVehicle', function(model)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
    SetVehicleNumberPlateText(vehicle, "ADMIN")
    TaskWarpPedIntoVehicle(ped, vehicle, -1)
    print(("[qb-core-bridge] Spawned vehicle: %s for %s"):format(model, GetPlayerName(src)))
end)

-- 🎒 Give item (used by qb-admin)
RegisterNetEvent('QBCore:Server:AddItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddItem(item, amount or 1)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
        print(("[qb-core-bridge] Gave %s x%d to %s"):format(item, amount or 1, GetPlayerName(src)))
    else
        print("^1[qb-core-bridge]^7 Failed to give item — player not found.")
    end
end)

-- 💰 Give money
RegisterNetEvent('QBCore:Server:AddMoney', function(type, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.AddMoney(type or 'cash', amount or 0)
    end
end)

-- ☀️ Set weather (for menu weather control)
RegisterNetEvent('QBCore:Server:SetWeather', function(weatherType)
    if GetResourceState('Renewed-Weathersync') == 'started' then
        TriggerEvent('Renewed:server:setWeather', weatherType)
    end
end)

print("^3[qb-core-bridge]^7 Loaded successfully — waiting for qb-admin requests.")
