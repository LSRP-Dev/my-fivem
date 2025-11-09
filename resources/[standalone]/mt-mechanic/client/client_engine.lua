local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:InstallEngine', function(EngineLevel)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if GetVehicleMod(vehicle,11) >= 0 then
                    QBCore.Functions.Notify(Lang.EngineAlreadyInstalled, 'error', 7500)
                else
                    SetVehicleDoorOpen(vehicle, 4, true, true)
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingEngine .. EngineLevel+1 .. '...', Config.Times['EngineTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) SetVehicleMod(vehicle, 11, EngineLevel) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.EngineInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', tostring('mechanic_engine_lvl'..EngineLevel+1), 1, nil) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames[tostring('mechanic_engine_lvl'..EngineLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items[tostring('mechanic_engine_lvl'..EngineLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:InstallTransmission', function(TransmissionLevel)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if GetVehicleMod(vehicle,13) >= 0 then
                    QBCore.Functions.Notify(Lang.TransmissionAlreadyInstalled, 'error', 7500)
                else
                    SetVehicleDoorOpen(vehicle, 4, true, true)
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingTransmission .. TransmissionLevel+1 .. '...', Config.Times['TransmissionTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) SetVehicleMod(vehicle, 13, TransmissionLevel) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.TransmissionInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', tostring('mechanic_transmission_lvl'..TransmissionLevel+1), 1, nil) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames[tostring('mechanic_transmission_lvl'..TransmissionLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items[tostring('mechanic_transmission_lvl'..TransmissionLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:InstallSuspension', function(SuspensionLevel)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if GetVehicleMod(vehicle,15) >= 0 then
                    QBCore.Functions.Notify(Lang.SuspensionAlreadyInstalled, 'error', 7500)
                else
                    SetVehicleDoorOpen(vehicle, 4, true, true)
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingSuspension .. SuspensionLevel+1 .. '...', Config.Times['SuspensionTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) SetVehicleMod(vehicle, 15, SuspensionLevel) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.SuspensionInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', tostring('mechanic_suspension_lvl'..SuspensionLevel+1), 1, nil) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames[tostring('mechanic_suspension_lvl'..SuspensionLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items[tostring('mechanic_suspension_lvl'..SuspensionLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:InstallBrakes', function(BrakesLevel)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if GetVehicleMod(vehicle,12) >= 0 then
                    QBCore.Functions.Notify(Lang.BrakesAlreadyInstalled, 'error', 7500)
                else
                    SetVehicleDoorOpen(vehicle, 4, true, true)
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingBrakes .. BrakesLevel+1 .. '...', Config.Times['BrakesTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) SetVehicleMod(vehicle, 12, BrakesLevel) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.BrakesInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', tostring('mechanic_brakes_lvl'..BrakesLevel+1), 1, nil) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames[tostring('mechanic_brakes_lvl'..BrakesLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items[tostring('mechanic_brakes_lvl'..BrakesLevel+1)].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:InstallTurbo', function()
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if IsToggleModOn(vehicle, 18) then
                    QBCore.Functions.Notify(Lang.TurboAlreadyInstalled, 'error', 7500)
                else
                    SetVehicleDoorOpen(vehicle, 4, true, true)
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingTurbo, Config.Times['TurboTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) ToggleVehicleMod(vehicle, 18, true) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.TurboInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_turbo', 1, nil) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames['mechanic_turbo'].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items['mechanic_turbo'].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:InstallArmor', function()
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsAuthorized() then
        if distance then
            if HasKeys(QBCore.Functions.GetPlate(vehicle)) then
                if GetVehicleMod(vehicle, 16) >= 0 then
                    QBCore.Functions.Notify(Lang.ArmorAlreadyInstalled, 'error', 7500)
                else
                    OpenAllVehicleDoors()
                    SetVehicleEngineOn(vehicle, false, false, false)
                    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
                    QBCore.Functions.Progressbar('name_here', Lang.InstallingArmor, Config.Times['ArmorTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
                        SetVehicleModKit(vehicle, 0) SetVehicleMod(vehicle, 16, 4) ClearPedTasks(PlayerPedId()) QBCore.Functions.Notify(Lang.ArmorInstalled, 'success', 7500) TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_armor', 1, nil) ShutAllVehicleDoors() SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox) saveVehicle()
                        if Config.QBInventoryName == 'ox_inventory' then
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. itemNames['mechanic_armor'].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        else
                            LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledEngine .. QBCore.Shared.Items['mechanic_armor'].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                        end
                        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                    end, function()
                        ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors() SetVehicleEngineOn(vehicle, true, false, false) DeleteEntity(repairBox)
                    end)
                end
            else
                QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotAuthorized, 'error', 7500)
    end
end)