local QBCore

CreateThread(function()
    -- same tolerant core grab on client
    while true do
        if GetResourceState('qbx_core') == 'started' then
            QBCore = exports['qbx_core'].GetCoreObject and exports['qbx_core']:GetCoreObject()
                       or (exports['qbx_core'].GetQBCoreObject and exports['qbx_core']:GetQBCoreObject())
        elseif GetResourceState('qb-core') == 'started' then
            QBCore = exports['qb-core'].GetCoreObject and exports['qb-core']:GetCoreObject()
        end
        if QBCore then break end
        Wait(500)
    end
end)

local function spawnNow(model, plate, props)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    -- Use QBCore helper if available; fallback to native create.
    if QBCore and QBCore.Functions and QBCore.Functions.SpawnVehicle then
        QBCore.Functions.SpawnVehicle(model, function(veh)
            SetEntityHeading(veh, heading)
            SetVehicleOnGroundProperly(veh)
            TaskWarpPedIntoVehicle(ped, veh, -1)
            if plate then SetVehicleNumberPlateText(veh, plate) end
            if props then
                -- if you use a vehicle props util in your pack, apply here
                -- exports['qb-vehiclekeys']:SetVehicleProperties(veh, props) -- example
            end
        end, coords, true)
        return
    end

    -- fallback
    local hash = type(model) == 'string' and GetHashKey(model) or model
    RequestModel(hash) while not HasModelLoaded(hash) do Wait(0) end
    local veh = CreateVehicle(hash, coords.x, coords.y, coords.z, heading, true, false)
    SetVehicleOnGroundProperly(veh)
    TaskWarpPedIntoVehicle(ped, veh, -1)
    if plate then SetVehicleNumberPlateText(veh, plate) end
    SetModelAsNoLongerNeeded(hash)
end

RegisterNetEvent('qb-core-bridge:client:spawnVehicle', function(model, plate, props)
    spawnNow(model, plate, props)
end)
