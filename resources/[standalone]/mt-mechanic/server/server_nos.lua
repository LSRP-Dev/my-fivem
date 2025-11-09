local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:server:LoadNitrous', function(Plate)
    TriggerClientEvent('mt-mechanic:client:LoadNitrous', -1, Plate)
end)

RegisterNetEvent('mt-mechanic:server:SyncFlames', function(netId)
    TriggerClientEvent('mt-mechanic:client:SyncFlames', -1, netId, source)
end)

RegisterNetEvent('mt-mechanic:server:UnloadNitrous', function(Plate)
    TriggerClientEvent('mt-mechanic:client:UnloadNitrous', -1, Plate)
end)

RegisterNetEvent('mt-mechanic:server:UpdateNitroLevel', function(Plate, level)
    TriggerClientEvent('mt-mechanic:client:UpdateNitroLevel', -1, Plate, level)
end)

RegisterNetEvent('mt-mechanic:server:StopSync', function(plate)
    TriggerClientEvent('mt-mechanic:client:StopSync', -1, plate)
end)