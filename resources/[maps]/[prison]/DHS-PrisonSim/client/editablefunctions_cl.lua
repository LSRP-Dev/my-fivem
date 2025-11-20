local fuelEvent = nil

function RefuelVehicle(vehicle)
    if GetResourceState('ox_fuel') ~= 'started' then
      exports[fuelEvent]:SetFuel(vehicle, 100)
      return
    elseif GetResourceState('ox_fuel') == 'started' then
      Entity(vehicle).state.fuel = 100.0
      return
    end
    print('ERROR: No Fuel Resource Detected')
    fuelEvent = nil
end

function CustomVehicleFunction(vehicle, model)
    if model == "policet" then
        -- Custom Vehicle Function Here
    elseif model == "pbus" then
        -- Custom Vehicle Function Here
    elseif model == "police" then
        -- Custom Vehicle Function Here
    elseif model == "riot" then
        -- Custom Vehicle Function Here
    end
end

CreateThread(function()
    if GetResourceState('LegacyFuel') == 'started' then
       fuelEvent = 'LegacyFuel'
       return
    end
    if GetResourceState('cdn-fuel') == 'started' then
      fuelEvent = 'cdn-fuel'
      return
    end
    if GetResourceState('BigDaddy-Fuel') == 'started' then
      fuelEvent = 'BigDaddy-Fuel'
      return
    end
    if GetResourceState('ps-fuel') == 'started' then
      fuelEvent = 'ps-fuel'
      return
    end
    if GetResourceState('okokGasStation') == 'started' then
      fuelEvent = 'okokGasStation'
      return
    end
  end)

function Notify(text, type, time)
    if Config.Notify == "qbcore" then
        local QBCore = exports['qb-core']:GetCoreObject()
        QBCore.Functions.Notify(text, type, time)
    elseif Config.Notify == "ox_lib" then
        lib.notify({
            title = text,
            type = type,
            duration = time
        })
    else
        print("No Notify System Selected")
    end
end

function ResetClothing()
    if Config.Clothing == "illenium-appearance" then
        TriggerEvent("illenium-appearance:client:reloadSkin")
    elseif Config.Clothing == "custom" then
        --Custom Clothing System Here
    end
end

function CallPolice(message)
    if Config.DispatchSystem == "qbcore" then
        TriggerServerEvent('police:server:policeAlert', message)
    elseif Config.DispatchSystem == "ps-dispatch" then
        --exports['ps-dispatch']:SuspiciousActivity()
    elseif Config.DispatchSystem == "cd-dispatch" then

         local data = exports['cd_dispatch']:GetPlayerInfo()
         TriggerServerEvent('cd_dispatch:AddNotification', {
             job_table = {'police', 'bcso'},
             coords = data.coords,
             title = '10-15 - Prision Break',
             message = 'A '..data.sex..'breaking out of the prision '..data.street,
             flash = 0,
             unique_id = tostring(math.random(0000000,9999999)),
             blip = {
                 sprite = 431,
                 scale = 1.2,
                 colour = 3,
                 flashes = false,
                 text = '911 - Prision Break',
                 time = (5*60*1000),
                 sound = 1,
             }
         })
    else
        if Config.Debug then
            print("No Dispatch System Selected")
        end
    end
end

function GiveKeys(plate)
    if Config.VehicleKeys == 'qb-vehiclekeys' then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    else
        if Config.Debug then
            print("No Vehicle Key System Selected")
        end
    end
end

function WorkoutMinigame(info)
    local success = lib.skillCheck({'medium'}, {'w', 'a', 's', 'd'})
    if success then
        TriggerEvent("DHS-PrisonSim:client:WorkoutSuccess", info)
    else
        TriggerEvent("DHS-PrisonSim:client:WorkoutFailed")
    end
end

function GateDoorMinigame()
    local success = lib.skillCheck({'easy', 'easy', 'easy', 'easy'}, {'w', 'a', 's', 'd'})
    if success then
        return true
    else
        return false
    end
end

function CustomMedicalFunction()
    -- Custom Medical Function Here
end

function OnConvoyStart()
    -- Triggers When The Convoy Starts
end

function PrisonerInConvoyVehicle()
    -- Probabaly Some Seatbelt Function or Something
end

function OnConvoyEnd()
    -- Triggers When The Convoy Ends
end

RegisterNetEvent("DHS-PrisonSim:client:UsePayphone", function()
    --Put Phone Logic Here
end)

RegisterNetEvent("DHS-PrisonSim:client:MedicalEvent", function()
    if Config.UseBuiltInMedicalSystem then
        TriggerEvent("DHS-PrisonSim:client:PrisonHealthCare")
    else
        TriggerEvent("DHS-PrisonSim:client:CustomMedicalFunction")
    end
end)
