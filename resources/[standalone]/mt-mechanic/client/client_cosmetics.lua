local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:CosmeticsMenu', function(mod, item, logs, header)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if distance then
        if HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
            updateProperties()
            if mod == 'bumpers' then
                lib.registerContext({
                    id = 'bumpers_main_menu',
                    title = header,
                    options = {
                        { title = Lang.FrontBumper, icon = 'arrow-right', onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 1, item, logs, header) end },
                        { title = Lang.RearBumper, icon = 'arrow-right', onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 2, item, logs, header) end },
                    }
                })
                lib.showContext('bumpers_main_menu')
            elseif mod == 'interior' then
                lib.registerContext({
                    id = 'interiors_main_menu',
                    title = header,
                    options = {
                        { title = Lang.Interior1, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 27, item, logs, header) end },
                        { title = Lang.Interior2, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 28, item, logs, header) end },
                        { title = Lang.Interior3, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 29, item, logs, header) end },
                        { title = Lang.Interior4, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 30, item, logs, header) end },
                        { title = Lang.Interior5, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 31, item, logs, header) end },
                        { title = Lang.Seats, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 32, item, logs, header) end },
                        { title = Lang.Steering, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 33, item, logs, header) end },
                    }
                })
                lib.showContext('interiors_main_menu')
            elseif mod == 'exterior' then
                lib.registerContext({
                    id = 'exteriors_main_menu',
                    title = header,
                    options = {
                        { title = Lang.Trunk, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 37, item, logs, header) end },
                        { title = Lang.Hydro, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 38, item, logs, header) end },
                        { title = Lang.EngineBay1, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 39, item, logs, header) end },
                        { title = Lang.EngineBay2, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 40, item, logs, header) end },
                        { title = Lang.EngineBay3, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 41, item, logs, header) end },
                        { title = Lang.Chassis1, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 5, item, logs, header) end },
                        { title = Lang.Chassis2, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 42, item, logs, header) end },
                        { title = Lang.Chassis3, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 43, item, logs, header) end },
                        { title = Lang.Chassis4, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 44, item, logs, header) end },
                        { title = Lang.Chassis5, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 45, item, logs, header) end },
                        { title = Lang.LeftFender, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 8, item, logs, header) end },
                        { title = Lang.RightFender, onSelect = function() TriggerEvent('mt-mechanic:client:CosmeticsMenu', 9, item, logs, header) end },
                    }
                })
                lib.showContext('exteriors_main_menu')
            elseif mod == 14 then
                local Menu = { title = header, id = 'cosmetic_menu', options = {} }
                for i = -1, GetNumVehicleMods(vehicle, mod)-1 do
                    if GetVehicleMod(vehicle, mod) == i then
                        if i+2 == 1 then
                            Menu.options[#Menu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                        else
                            Menu.options[#Menu.options + 1] = { title = Lang.Horn .. tonumber(i+1), description = Lang.Applied, disabled = true }
                        end
                    else
                        if i+2 == 1 then
                            Menu.options[#Menu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                        else
                            Menu.options[#Menu.options + 1] = { title = Lang.Horn .. tonumber(i+1), event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                        end
                    end
                end
                lib.registerContext(Menu)
                lib.showContext('cosmetic_menu')
            elseif mod == 48 then
                local Menu = { title = header, id = 'cosmetic_menu', options = {} }
                if GetNumVehicleMods(vehicle, mod)-1 >= 0 then
                    for i = -1, GetNumVehicleMods(vehicle, mod)-1 do
                        if GetVehicleMod(vehicle, mod) == i then
                            if i+2 == 1 then
                                Menu.options[#Menu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                            else
                                Menu.options[#Menu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, mod, i)), description = Lang.Applied, disabled = true }
                            end
                        else
                            if i+2 == 1 then
                                Menu.options[#Menu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                            else
                                Menu.options[#Menu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, mod, i)), event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                            end
                        end
                    end
                else
                    for i = -1, GetVehicleLiveryCount(vehicle)-1 do
                        if GetVehicleLivery(vehicle) == i then
                            if i+2 == 1 then
                                Menu.options[#Menu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                            else
                                Menu.options[#Menu.options + 1] = { title = GetLabelText(GetLiveryName(vehicle, i)), description = Lang.Applied, disabled = true }
                            end
                        else
                            if i+2 == 1 then
                                Menu.options[#Menu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                            else
                                Menu.options[#Menu.options + 1] = { title = GetLabelText(GetLiveryName(vehicle, i)), event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                            end
                        end
                    end
                end
                lib.registerContext(Menu)
                lib.showContext('cosmetic_menu')
            else
                local Menu = { title = header, id = 'cosmetic_menu', options = {} }
                for i = -1, GetNumVehicleMods(vehicle, mod)-1 do
                    if GetVehicleMod(vehicle, mod) == i then
                        if i+2 == 1 then
                            Menu.options[#Menu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                        else
                            Menu.options[#Menu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, mod, i)), description = Lang.Applied, disabled = true }
                        end
                    else
                        if i+2 == 1 then
                            Menu.options[#Menu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                        else
                            Menu.options[#Menu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, mod, i)), event = 'mt-mechanic:client:ApplyMod', args = { mod = mod, id = i, item = item } }
                        end
                    end
                end
                lib.registerContext(Menu)
                lib.showContext('cosmetic_menu')
            end
        else
            QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyMod', function(data)
    SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), false, false, false)
    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
    QBCore.Functions.Progressbar('name_here', Lang.InstallingCosmetic, Config.Times['InstallingCosmeticTime'], false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
        anim = 'machinic_loop_mechandplayer',
    }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), true, false, false)
        DeleteEntity(repairBox)
        SetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), tonumber(data.mod), tonumber(data.id), false)
        if data.mod == 48 then
            SetVehicleLivery(lib.getClosestVehicle(GetEntityCoords(PlayerPedId())), tonumber(data.id))
        end
        saveVehicle()
        TriggerServerEvent('mt-mechanic:server:RemoveItem', data.item, 1, nil)
        if Config.QBInventoryName == 'ox_inventory' then
            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine..itemNames[data.item].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
        else
            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine..QBCore.Shared.Items[data.item].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
        end
        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
    end, function()
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), true, false, false)
        DeleteEntity(repairBox)
    end)
end)