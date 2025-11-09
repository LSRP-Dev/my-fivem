local QBCore = exports[Config.QBCoreName]:GetCoreObject()
local VehicleOut = false local Vehicle = nil local onDuty = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        if PlayerData.job.onduty then
            TriggerServerEvent("QBCore:ToggleDuty")
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    onDuty = PlayerJob.onduty
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
end)

RegisterNetEvent("mt-mechanic:client:ToogleDuty", function()
    if onDuty ~= true then onDuty = not onDuty TriggerServerEvent("QBCore:ToggleDuty") else onDuty = not onDuty TriggerServerEvent("QBCore:ToggleDuty") end
end)

CreateThread(function()
    for k, v in pairs(Config.JobLocations['GaragesLocations']) do
        makeProp({coords = vector4(v['Location'].x, v['Location'].y, v['Location'].z, v['Location'].h), prop = `prop_park_ticket_01`}, 1, 0)
        if Config.QBTargetName == 'ox_target' then
            exports.ox_target:addBoxZone({
                coords = vec3(v['Location'].x, v['Location'].y, v['Location'].z), size = vec3(1.2, 1.2, 2.5), rotation = 0, debug = Config.DebugPoly,
                options = {
                    {
                        icon = "fas fa-credit-card",
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and VehicleOut == false then return true end return false
                        end,
                        onSelect = function()
                            TriggerEvent('mt-mechanic:client:OpenGarageMenu', k)
                        end,
                        label = Lang.AccessGarage,
                    },
                    {
                        icon = "fas fa-ban",
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and VehicleOut == true then return true end return false
                        end,
                        onSelect = function()
                            VehicleOut = false DeleteEntity(Vehicle) DeleteVehicle(Vehicle) Vehicle = nil
                        end,
                        label = Lang.DeleteVehicle,
                    },
                }
            })
        else
            exports[Config.QBTargetName]:AddBoxZone('Garage'..k, vector3(v['Location'].x, v['Location'].y, v['Location'].z), 1.2, 1.2, { name='Garage'..k, heading=0, debugPoly = Config.DebugPoly }, {
                options = {
                    {
                        icon = "fas fa-credit-card",
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and VehicleOut == false then return true end return false
                        end,
                        action = function()
                            TriggerEvent('mt-mechanic:client:OpenGarageMenu', k)
                        end,
                        label = Lang.AccessGarage,
                    },
                    {
                        icon = "fas fa-ban",
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and VehicleOut == true then return true end return false
                        end,
                        action = function()
                            VehicleOut = false DeleteEntity(Vehicle) DeleteVehicle(Vehicle) Vehicle = nil
                        end,
                        label = Lang.DeleteVehicle,
                    },
                },
                distance = 2.5
            })
        end
    end
    for k, v in pairs(Config.JobLocations['Duty']) do
        if Config.QBTargetName == 'ox_target' then
            exports.ox_target:addBoxZone({ coords = vec3(v['Coords'].x, v['Coords'].y, v['Coords'].z), size = vec3(v['Length'], v['Width'], 2.5), rotation = 0, debug = Config.DebugPoly,
                options = {
                    {
                        icon = "fas fa-clipboard",
                        event = 'mt-mechanic:client:ToogleDuty',
                        label = Lang.ToggleDuty,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job then return true end
                        end,
                    },
                    {
                        icon = "fas fa-clipboard",
                        event = 'mt-mechanic:client:Charge',
                        label = Lang.ChargeCustomer,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and onDuty == true then return true end return false
                        end,
                    },
                    {
                        icon = "fas fa-clipboard",
                        onSelect = function()
                            TriggerEvent('qb-bossmenu:client:OpenMenu')
                        end,
                        label = Lang.OpenBossMenu,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and onDuty == true and QBCore.Functions.GetPlayerData().job.isboss == true then return true end return false
                        end,
                    },
                }
            })
        else
            exports[Config.QBTargetName]:AddBoxZone('Duty'..k, v['Coords'], v['Length'], v['Width'], { name='Duty'..k, heading=0, debugPoly = Config.DebugPoly }, {
                options = {
                    {
                        icon = "fas fa-clipboard",
                        event = 'mt-mechanic:client:ToogleDuty',
                        label = Lang.ToggleDuty,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job then return true end
                        end,
                    },
                    {
                        icon = "fas fa-clipboard",
                        event = 'mt-mechanic:client:Charge',
                        label = Lang.ChargeCustomer,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and onDuty == true then return true end return false
                        end,
                    },
                    {
                        icon = "fas fa-clipboard",
                        action = function()
                            TriggerEvent('qb-bossmenu:client:OpenMenu')
                        end,
                        label = Lang.OpenBossMenu,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job and onDuty == true and QBCore.Functions.GetPlayerData().job.isboss == true then return true end return false
                        end,
                    },
                },
                distance = 2.5
            })
        end
    end
    for k, v in pairs(Config.JobLocations['Stashes']) do
        if Config.QBTargetName == 'ox_target' then
            exports.ox_target:addBoxZone({ coords = vec3(v['Coords'].x, v['Coords'].y, v['Coords'].z), size = vec3(v['Length'], v['Width'], 2.5), rotation = 0, debug = Config.DebugPoly,
                options = {
                    {
                        icon = "fas fa-circle",
                        onSelect = function()
                            if Config.QBInventoryName == 'ox_inventory' then
                                TriggerServerEvent('mt-mechanic:server:RegisterStash', tostring(v.Name.."_"..v.Job), tostring(v.Name.."_"..v.Job), v['Slots'], v['Weigth'])
                                exports.ox_inventory:openInventory('stash', tostring(v.Name.."_"..v.Job))
                            else
                                TriggerEvent("inventory:client:SetCurrentStash", v.Name.."_"..v.Job)
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", v.Name.."_"..v.Job, {
                                    maxweight = v['Weigth'],
                                    slots = v['Slots'],
                                })
                            end
                        end,
                        label = Lang.OpenStash,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job then return true end
                        end,
                    },
                }
            })
        else
            exports[Config.QBTargetName]:AddBoxZone('Stashes'..k..v['Job'], v['Coords'], v['Length'], v['Width'], { name='Stashes'..k..v['Job'], heading=0, debugPoly = Config.DebugPoly }, {
                options = {
                    {
                        icon = "fas fa-circle",
                        action = function()
                            if Config.QBInventoryName == 'ox_inventory' then
                                TriggerServerEvent('mt-mechanic:server:RegisterStash', tostring(v.Name.."_"..v.Job), tostring(v.Name.."_"..v.Job), v.Slots, v.Weigth)
                                exports.ox_inventory:openInventory('stash', tostring(v.Name.."_"..v.Job))
                            else
                                TriggerEvent("inventory:client:SetCurrentStash", v.Name.."_"..v.Job)
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", v.Name.."_"..v.Job, {
                                    maxweight = v.Weigth,
                                    slots = v.Slots,
                                })
                            end
                        end,
                        label = Lang.OpenStash,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.Job then return true end
                        end,
                    },
                },
                distance = 2.5
            })
        end
    end
    for k, v in pairs(Config.JobLocations['Blips']) do
        v.blipvariantid = AddBlipForCoord(v.blipcoords) SetBlipSprite (v.blipvariantid, v.blipsprite) SetBlipDisplay(v.blipvariantid, v.blipdisplay) SetBlipScale  (v.blipvariantid, v.blipscale) SetBlipAsShortRange(v.blipvariantid, true) SetBlipColour(v.blipvariantid, v.blipcolour) BeginTextCommandSetBlipName("STRING") AddTextComponentSubstringPlayerName(v.blipname) EndTextCommandSetBlipName(v.blipvariantid)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenGarageMenu', function(data)
    registeredMenu = { id = 'garage_menu', title = Lang.GarageMenuHeader, options = {} }
    for _, v in pairs(Config.JobLocations['GaragesLocations'][data]['Vehicles']) do
        registeredMenu.options[#registeredMenu.options + 1] = { title = v.VehicleName, description = v.VehicleDescription, icon = 'car', event = 'mt-mechanic:client:SpawnVehicle', args = { Current = data, VehicleName = v.VehicleSpawnName, } }
    end
    lib.registerContext(registeredMenu)
    lib.showContext('garage_menu')
end)

RegisterNetEvent('mt-mechanic:client:SpawnVehicle', function(data)
    QBCore.Functions.SpawnVehicle(tostring(data.VehicleName), function(veh)
        SetVehicleNumberPlateText(veh, "MTFN"..tostring(math.random(1000, 9999)))
        exports[Config.LegacyFuelName]:SetFuel(veh, 100.0)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        VehicleOut = true
        Vehicle = veh
    end, Config.JobLocations['GaragesLocations'][data.Current]['SpawnLocation'], true)
end)