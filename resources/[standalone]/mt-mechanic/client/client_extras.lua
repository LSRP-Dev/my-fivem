local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:PlatesMenu', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if distance then
        lib.registerContext({
            id = 'plates_main_menu', title = Lang.PlatesMenuHeader,
            options = {
                { title = Lang.BlueOnWhite, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'BlueOnWhite' } },
                { title = Lang.BlueOnWhite2, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'BlueOnWhite2' } },
                { title = Lang.YellowOnBlack, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'YellowOnBlack' } },
                { title = Lang.YellowOnBlue, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'YellowOnBlue' } },
                { title = Lang.BlueOnWhite3, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'BlueOnWhite3' } },
                { title = Lang.NorthYankton, event = 'mt-mechanic:client:AplyPlate', args = { Type = 'NorthYankton' } },
            }
        })
        lib.showContext('plates_main_menu')
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:AplyPlate', function(data)
    SetVehicleEngineOn(vehicle, false, false, false)
    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
    QBCore.Functions.Progressbar('name_here', Lang.InstallingPlate, Config.Times['PlateTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
        if data.Type == 'BlueOnWhite' then
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 0)
        elseif data.Type == 'BlueOnWhite2' then 
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 3)
        elseif data.Type == 'BlueOnWhite2' then 
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 4)
        elseif data.Type == 'YellowOnBlack' then
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 1)
        elseif data.Type == 'YellowOnBlue' then
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 2)
        elseif data.Type == 'NorthYankton' then
            SetVehicleNumberPlateTextIndex(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 5)
        end
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(vehicle, true, false, false)
        DeleteEntity(repairBox)
        saveVehicle()
        TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_plate', 1, nil)
        local LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledPlate, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
    end, function()
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(vehicle, true, false, false)
        DeleteEntity(repairBox)
        saveVehicle()
    end)
end)

RegisterNetEvent('mt-mechanic:client:WindowTintMenu', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if distance then
        lib.registerContext({
            id = 'window_main_menu', title = Lang.WindowTintMenu,
            options = {
                { title = Lang.Default, event = 'mt-mechanic:client:ApplyWindowTint', args = { Type = 'Default' } },
                { title = Lang.PureBlack, event = 'mt-mechanic:client:ApplyWindowTint', args = { Type = 'PureBlack' } },
                { title = Lang.DarkSmoke, event = 'mt-mechanic:client:ApplyWindowTint', args = { Type = 'DarkSmoke' } },
                { title = Lang.LightSmoke, event = 'mt-mechanic:client:ApplyWindowTint', args = { Type = 'LightSmoke' } },
            }
        })
        lib.showContext('window_main_menu')
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyWindowTint', function(data)
    TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
    QBCore.Functions.Progressbar('name_here', Lang.InstallintWindowTint, Config.Times['WindowTintTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if data.Type == 'Default' then
            SetVehicleWindowTint(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 0)
        elseif data.Type == 'PureBlack' then
            SetVehicleWindowTint(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 1)
        elseif data.Type == 'DarkSmoke' then
            SetVehicleWindowTint(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 2)
        elseif data.Type == 'LightSmoke' then
            SetVehicleWindowTint(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 3)
        end
        saveVehicle()
        TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_window_tint', 1, nil)
        local LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledWindowTint, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
    end, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    end)
end)

RegisterNetEvent('mt-mechanic:client:ApplyDriftTyres', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if distance then
        if GetDriftTyresEnabled(vehicle) == false then
            SetVehicleEngineOn(vehicle, false, false, false)
            repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
            QBCore.Functions.Progressbar('name_here', Lang.InstallingDriftTyres, Config.Times['DriftTyresTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                SetVehicleEngineOn(vehicle, true, false, false)
                DeleteEntity(repairBox)
                SetDriftTyresEnabled(vehicle, true)
                saveVehicle()
                TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_drift_tyres', 1, nil)
                local LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledDriftTyres, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
                TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
            end, function()
                ClearPedTasks(PlayerPedId())
                SetVehicleEngineOn(vehicle, true, false, false)
                DeleteEntity(repairBox)
            end)
        else
            QBCore.Functions.Notify(Lang.DriftTyresAlreadyInstalled)
        end
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

-- Clear Vehicle

RegisterNetEvent('mt-mechanic:client:WashVehicle', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if distance then
        if not IsPedInAnyVehicle(PlayerPedId()) then
            if GetVehicleDirtLevel(vehicle) > 0 then
                TriggerEvent('animations:client:EmoteCommandStart', {"clean2"})
                QBCore.Functions.Progressbar('name_here', Lang.WashingVehicle, Config.Times['WashTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, {}, {}, {}, function()
                    SetVehicleDirtLevel(vehicle, 0.0)
                    WashDecalsFromVehicle(vehicle, 1.0)
                    ClearPedTasks(PlayerPedId())
                    QBCore.Functions.Notify(Lang.VehicleCleaned, 'error', 7500)
                    TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_washing_kit', 1, nil)
                end, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    ClearPedTasks(PlayerPedId())
                    SetVehicleDirtLevel(vehicle, 15.0)
                end)
            else
                QBCore.Functions.Notify(Lang.VehicleCleanAlredy, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NeedOutOfVehicle, 'error', 7500)
        end
    else    
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

-- Menu Extras

RegisterNetEvent('mt-mechanic:client:OpenExtrasMenu', function()
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if distance then
        if HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
            updateProperties()
            local ExtrasMenu = { title = Lang.ExtrasMenu, id = 'extras_mechanic_menu', options = {} }
            for i = 0, 9 do
                ExtrasMenu.options[#ExtrasMenu.options + 1] = { title = Lang.ToggleExtra .. '#' .. i, icon = 'plus', event = 'mt-mechanic:client:SetExtra', args = { extra = i } }
            end
            lib.registerContext(ExtrasMenu)
            lib.showContext('extras_mechanic_menu')
        else
            QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:SetExtra', function(data)
    local vehicle = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if IsVehicleExtraTurnedOn(vehicle, data.extra) then
        SetVehicleExtra(vehicle, data.extra, 1) SetVehicleAutoRepairDisabled(true)
    else
        SetVehicleExtra(vehicle, data.extra, 0) SetVehicleAutoRepairDisabled(true)
    end
    QBCore.Functions.Notify(Lang.ExtraToggled .. '#' .. data.extra)
    local LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledExtra, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
    TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
    TriggerEvent('mt-mechanic:client:OpenExtrasMenu')
end)