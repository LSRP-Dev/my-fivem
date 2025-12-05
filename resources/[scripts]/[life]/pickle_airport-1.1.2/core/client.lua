function CreateVeh(modelHash, ...)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local veh = CreateVehicle(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    
    -- Wait for vehicle to exist and be fully loaded
    local timeout = 0
    while not DoesEntityExist(veh) and timeout < 50 do
        Wait(100)
        timeout = timeout + 1
    end
    
    if not DoesEntityExist(veh) then
        return 0
    end
    
    -- Wait a bit for vehicle to fully initialize
    Wait(100)
    
    -- Request network control to ensure proper ownership
    if not NetworkHasControlOfEntity(veh) then
        NetworkRequestControlOfEntity(veh)
        timeout = 0
        while not NetworkHasControlOfEntity(veh) and timeout < 50 do
            Wait(10)
            timeout = timeout + 1
        end
    end
    
    -- Get network ID and ensure proper network registration
    local netId = NetworkGetNetworkIdFromEntity(veh)
    if netId and netId > 0 then
        -- Allow network migration to prevent desync issues
        SetNetworkIdCanMigrate(netId, true)
        -- Wait for network ID to be properly registered (with timeout)
        timeout = 0
        while not NetworkDoesEntityExistWithNetworkId(netId) and timeout < 100 do
            Wait(10)
            timeout = timeout + 1
        end
    end
    
    -- Set vehicle ownership and properties BEFORE mission entity
    SetVehicleHasBeenOwnedByPlayer(veh, true)
    SetVehicleNeedsToBeHotwired(veh, false)
    SetVehRadioStation(veh, 'OFF')
    
    -- Set as mission entity to prevent automatic cleanup
    SetEntityAsMissionEntity(veh, true, true)
    
    -- Wait a moment after setting mission entity to ensure it's registered
    Wait(50)
    
    -- Verify entity still exists and is a mission entity
    if not DoesEntityExist(veh) or not IsEntityAMissionEntity(veh) then
        -- Retry setting as mission entity
        SetEntityAsMissionEntity(veh, true, true)
        Wait(50)
    end
    
    -- Ensure vehicle is properly positioned (especially important for planes)
    SetVehicleOnGroundProperly(veh)
    
    -- Additional wait for aircraft to fully stabilize
    Wait(100)
    
    if (GiveKeys) then 
        GiveKeys(veh)
    end
    return veh
end

function CreateNPC(modelHash, ...)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local ped = CreatePed(26, modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return ped
end

function CreateProp(modelHash, ...)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do Wait(0) end
    local obj = CreateObject(modelHash, ...)
    SetModelAsNoLongerNeeded(modelHash)
    return obj
end

function PlayAnim(ped, dict, ...)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) end
    TaskPlayAnim(ped, dict, ...)
end

function PlayEffect(dict, particleName, entity, off, rot, time, cb)
    CreateThread(function()
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
            Wait(0)
        end
        UseParticleFxAssetNextCall(dict)
        Wait(10)
        local particleHandle = StartParticleFxLoopedOnEntity(particleName, entity, off.x, off.y, off.z, rot.x, rot.y, rot.z, 1.0)
        SetParticleFxLoopedColour(particleHandle, 0, 255, 0 , 0)
        Wait(time)
        StopParticleFxLooped(particleHandle, false)
        cb()
    end)
end

function CreateBlip(data)
    local x,y,z = table.unpack(data.Location)
    local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite(blip, data.ID)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, data.Scale)
    SetBlipColour(blip, data.Color)
    if (data.Rotation) then 
        SetBlipRotation(blip, math.ceil(data.Rotation))
    end
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(data.Label)
    EndTextCommandSetBlipName(blip)
    return blip
end

for i=1, #Config.Blips do 
    CreateBlip(Config.Blips[i])
end
