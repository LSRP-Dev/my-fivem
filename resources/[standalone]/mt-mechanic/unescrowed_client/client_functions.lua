local QBCore = exports[Config.QBCoreName]:GetCoreObject()

local time = 1000
function loadModel(model) 
    if not HasModelLoaded(model) then
        while not HasModelLoaded(model) do
            if time > 0 then time = time - 1 RequestModel(model)
            else time = 1000 break
            end
            Wait(10)
        end
    end 
end

function loadAnimDict(dict)	
    if not HasAnimDictLoaded(dict) then 
        while not HasAnimDictLoaded(dict) do 
            RequestAnimDict(dict) Wait(5) 
        end 
    end 
end

function loadPtfxDict(dict)	
    if not HasNamedPtfxAssetLoaded(dict) then 
        while not HasNamedPtfxAssetLoaded(dict) do 
            RequestNamedPtfxAsset(dict) Wait(5)
        end 
    end 
end

function playAnim(animDict, animName, duration, flag)
    loadAnimDict(animDict)
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, flag, 1, false, false, false)
end

function stopAnim(animDict, animName)
    StopAnimTask(PlayerPedId(), animName, animDict)
    RemoveAnimDict(animDict)
end

function makeProp(data, freeze, synced)
    loadModel(data.prop)
    local prop = CreateObject(data.prop, data.coords.x, data.coords.y, data.coords.z-1.03, synced or 0, synced or 0, 0)
    SetEntityHeading(prop, data.coords.w-180.0)
    FreezeEntityPosition(prop, freeze or 0)
    return prop
end

function OpenAllVehicleDoors()
    for i = 0, 5 do
        SetVehicleDoorOpen(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), i, false, false)
    end
end

function ShutAllVehicleDoors()
    for i = 0, 5 do
        SetVehicleDoorShut(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), i, false)
    end
end

function saveVehicle()
    TriggerServerEvent('mt-mechanic:server:updateVehicle', lib.getVehicleProperties(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)))
end

function HasKeys(plate)
    if Config.UsingVehicleKeys then
        if exports[Config.QBVehicleKeysName]:HasKeys(plate) then return true end
    else
        return true
    end
end

function updateProperties()
    lib.setVehicleProperties(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), lib.getVehicleProperties(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)))
end

function IsAuthorized()
    for k, v in pairs(Config.InstallModsAuthorized) do
        if QBCore.Functions.GetPlayerData().job.name == v then return true end
    end
end

function AnotherActionsOnRepair(vehicle)
    -- Here you can add some action on using repair kit at vehicle
end

if Config.QBInventoryName == 'ox_inventory' then
    itemNames = {}
    for item, data in pairs(exports.ox_inventory:Items()) do
        itemNames[item] = data
    end
end