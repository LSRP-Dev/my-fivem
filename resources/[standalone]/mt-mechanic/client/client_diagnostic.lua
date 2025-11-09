local QBCore = exports[Config.QBCoreName]:GetCoreObject()
local InsideZone = false

CreateThread(function()
    if Config.DiagnosticOnlyAtWorkshop then
        for i, spot in pairs(Config.WorkshopZones) do
            local _name = tostring('Workshop-'..spot.Job..i)
            local newWorkshop = BoxZone:Create(spot.Coords, spot.Length, spot.Width, { name = _name, debugPoly = Config.DebugPoly, heading = spot.Heading })
            newWorkshop:onPlayerInOut(function(isPointInside, _)
                if isPointInside then InsideZone = true else InsideZone = false end
            end)
        end
    end
    if Config.QBTargetName == 'ox_target' then
        local options = {
            {
                icon = 'fas fa-tools',
                label = Lang.VerifyTuning,
                onSelect = function()
                    TriggerEvent('mt-mechanic:client:OpenTuningMenu')
                end,
                canInteract = function()
                    for k, v in pairs(Config.AuthorizedDiagnostic) do
                        if Config.DiagnosticOnlyAtWorkshop == true then
                            if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        else
                            if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        end
                    end
                end
            },
            {
                icon = 'fas fa-heartbeat',
                label = Lang.VerifyVehicleHealth,
                onSelect = function()
                    TriggerEvent('mt-mechanic:client:OpenVehicleHealthMenu')
                end,
                canInteract = function()
                    for k, v in pairs(Config.AuthorizedDiagnostic) do
                        if Config.DiagnosticOnlyAtWorkshop == true then
                            if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        else
                            if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        end
                    end
                end
            },
            {
                icon = 'fas fa-car-crash',
                label = Lang.RepairVehicle,
                onSelect = function()
                    TriggerEvent('mt-mechanic:client:OpenRepairVehicleMenu')
                end,
                canInteract = function()
                    for k, v in pairs(Config.AuthorizedDiagnostic) do
                        if Config.DiagnosticOnlyAtWorkshop == true then
                            if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        else
                            if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                        end
                    end
                end
            },
        }
        exports.ox_target:addGlobalVehicle(options)
    else
        exports[Config.QBTargetName]:AddGlobalVehicle({ 
            options = {
                {
                    icon = 'fas fa-tools',
                    label = Lang.VerifyTuning,
                    action = function()
                        TriggerEvent('mt-mechanic:client:OpenTuningMenu')
                    end,
                    canInteract = function()
                        for k, v in pairs(Config.AuthorizedDiagnostic) do
                            if Config.DiagnosticOnlyAtWorkshop == true then
                                if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            else
                                if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            end
                        end
                    end
                },
                {
                    icon = 'fas fa-heartbeat',
                    label = Lang.VerifyVehicleHealth,
                    action = function()
                        TriggerEvent('mt-mechanic:client:OpenVehicleHealthMenu')
                    end,
                    canInteract = function()
                        for k, v in pairs(Config.AuthorizedDiagnostic) do
                            if Config.DiagnosticOnlyAtWorkshop == true then
                                if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            else
                                if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            end
                        end
                    end
                },
                {
                    icon = 'fas fa-car-crash',
                    label = Lang.RepairVehicle,
                    action = function()
                        TriggerEvent('mt-mechanic:client:OpenRepairVehicleMenu')
                    end,
                    canInteract = function()
                        for k, v in pairs(Config.AuthorizedDiagnostic) do
                            if Config.DiagnosticOnlyAtWorkshop == true then
                                if InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            else
                                if QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then return true end
                            end
                        end
                    end
                },
            },
            distance = 2.5,
        })
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenToolsMenu', function()
    canUseTools = false
    for k, v in pairs(Config.AuthorizedDiagnostic) do
        if Config.DiagnosticOnlyAtWorkshop and InsideZone and QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
            canUseTools = true
        elseif QBCore.Functions.GetPlayerData().job.name == v and HasKeys(GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
            canUseTools = true
        end
    end
    if canUseTools then
        lib.registerContext({
            id = 'diagnostic_vehicle_menu',
            options = {
                { title = Lang.VerifyTuning, icon = 'tools', event = 'mt-mechanic:client:OpenTuningMenu' },
                { title = Lang.VerifyVehicleHealth, icon = 'heartbeat', event = 'mt-mechanic:client:OpenVehicleHealthMenu' },
                { title = Lang.RepairVehicle, icon = 'car-crash', event = 'mt-mechanic:client:OpenRepairVehicleMenu' },
            }
        })
        lib.showContext('diagnostic_vehicle_menu')
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenTuningMenu', function(data)
    if HasKeys(QBCore.Functions.GetPlate(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
        OpenAllVehicleDoors()
        repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
        QBCore.Functions.Progressbar('name_here', Lang.CheckingTuning, Config.Times['CheckTuneTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'mini@repair', anim = 'fixing_a_ped' }, {}, {}, function()
            local Menu = { id = 'check_tune_menu', title = Lang.TuningStatus, options = {} }
            if GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 11) < 0 then
                Menu.options[#Menu.options+1] = { title = Lang.Engine, description = Lang.NotInstalled, disabled = true, icon = 'close', }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Engine, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),11)+1].name..'.png'), description = itemNames['mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 11)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 11, ItemName = 'mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),11)+1 } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Engine, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),11)+1].name..'.png'), description = QBCore.Shared.Items['mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),11)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 11, ItemName = 'mechanic_engine_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 11)+1 } }
                end
            end
            if GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 13) < 0 then
                Menu.options[#Menu.options+1] = { title = Lang.Transmission, description = Lang.NotInstalled, disabled = true, icon = 'close' }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Transmission, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1].name..'.png'), description = itemNames['mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 13, ItemName = 'mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1 } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Transmission, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1].name..'.png'), description = QBCore.Shared.Items['mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 13, ItemName = 'mechanic_transmission_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),13)+1 } }
                end
            end
            if GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 15) < 0 then
                Menu.options[#Menu.options+1] = { title = Lang.Suspension, description = Lang.NotInstalled, disabled = true, icon = 'close', }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Suspension, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1].name..'.png'), description = itemNames['mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 15, ItemName = 'mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1 } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Suspension, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1].name..'.png'), description = QBCore.Shared.Items['mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 15, ItemName = 'mechanic_suspension_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),15)+1 } }
                end
            end
            if GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 12) < 0 then
                Menu.options[#Menu.options+1] = { title = Lang.Brakes, description = Lang.NotInstalled, disabled = true, icon = 'close' }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Brakes, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1].name..'.png'), description = itemNames['mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 12, ItemName = 'mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1 } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Brakes, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1].name..'.png'), description = QBCore.Shared.Items['mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 12, ItemName = 'mechanic_brakes_lvl'..GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true),12)+1 } }
                end
            end
            if IsToggleModOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 18) then
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Turbo, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_turbo'].name..'.png'), description = itemNames['mechanic_turbo'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 18, ItemName = 'mechanic_turbo' } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Turbo, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_turbo'].name..'.png'), description = QBCore.Shared.Items['mechanic_turbo'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 18, ItemName = 'mechanic_turbo' } }
                end
            else
                Menu.options[#Menu.options+1] = { title = Lang.Turbo, description = Lang.NotInstalled, disabled = true, icon = 'close' }
            end
            if GetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 16) < 0 then
                Menu.options[#Menu.options+1] = { title = Lang.Armor, description = Lang.NotInstalled, disabled = true, icon = 'close' }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.Armor, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_armor'].name..'.png'), description = itemNames['mechanic_armor'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 16, ItemName = 'mechanic_armor' } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.Armor, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_armor'].name..'.png'), description = QBCore.Shared.Items['mechanic_armor'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 16, ItemName = 'mechanic_armor' } }
                end
            end
            if GetDriftTyresEnabled(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) == false then
                Menu.options[#Menu.options+1] = { title = Lang.DriftTyres, description = Lang.NotInstalled, disabled = true, icon = 'close' }
            else
                if Config.QBInventoryName == 'ox_inventory' then 
                    Menu.options[#Menu.options+1] = { title = Lang.DriftTyres, icon = tostring(Config.ImagesDirectory..itemNames['mechanic_drift_tyres'].name..'.png'), description = itemNames['mechanic_drift_tyres'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 'drift_tyres', ItemName = 'mechanic_drift_tyres' } }
                else
                    Menu.options[#Menu.options+1] = { title = Lang.DriftTyres, icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items['mechanic_drift_tyres'].name..'.png'), description = QBCore.Shared.Items['mechanic_drift_tyres'].label .. Lang.Installed, event = 'mt-mechanic:client:RemoveTuning', args = { TuningType = 'drift_tyres', ItemName = 'mechanic_drift_tyres' } }
                end
            end
            Wait(500)
            lib.registerContext(Menu) lib.showContext('check_tune_menu') DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors()
        end, function()
            DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors()
        end)
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenVehicleHealthMenu', function(data)
    if HasKeys(QBCore.Functions.GetPlate(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
        OpenAllVehicleDoors()
        repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
        QBCore.Functions.Progressbar('name_here', Lang.CheckingHealth, Config.Times['CheckHealthTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'mini@repair', anim = 'fixing_a_ped' }, {}, {}, function()
            lib.registerContext({
                id = 'health_vehicle_menu', title = Lang.HealthStatus,
                options = {
                    { title = Lang.EngineHealth, description = math.ceil((GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))/10)) .. "%", icon = 'oil-can', disabled = true },
                    { title = Lang.BodyHealth, description = math.ceil((GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))/10)) .. "%", icon = 'car-crash', disabled = true },
                    { title = Lang.DirtLevel, description = math.ceil(GetVehicleDirtLevel(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) .. "%", icon = 'hands-wash', disabled = true },
                    { title = Lang.EngineTemperature, description = math.ceil(GetVehicleEngineTemperature(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) .. "ºC", icon = 'temperature-high', disabled = true },
                    { title = Lang.OilLevel, description = math.ceil(GetVehicleOilLevel(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) .. "%", icon = 'oil-can', disabled = true },
                    { title = Lang.FuelLevel, description = math.ceil(GetVehicleFuelLevel(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) .. "%", icon = 'gas-pump', disabled = true },
                }
            })
            lib.showContext('health_vehicle_menu') DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors()
        end, function()
            DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors()
        end)
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:RemoveTuning', function(data)
    if HasKeys(QBCore.Functions.GetPlate(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
        OpenAllVehicleDoors()
        repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
        SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), false, true, false)
        QBCore.Functions.Progressbar('name_here', Lang.RomovingTuning, Config.Times['RemovingTuningTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
            SetVehicleModKit(vehicle, 0)
            if data.TuningType == 18  then
                ToggleVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 18, false)
            elseif data.TuningType == 'drift_tyres' then
                SetDriftTyresEnabled(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), false)
            else
                SetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), data.TuningType, -1)
            end
            ClearPedTasks(PlayerPedId()) TriggerServerEvent('mt-mechanic:server:AddItem', data.ItemName, 1) ShutAllVehicleDoors() DeleteEntity(repairBox) saveVehicle()
            if Config.QBInventoryName == 'ox_inventory' then 
                LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.RemovedTuning .. itemNames[data.ItemName].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)), }
            else
                LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.RemovedTuning .. QBCore.Shared.Items[data.ItemName].label, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)), }
            end
            TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
        end, function()
            ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors() DeleteEntity(repairBox)
        end)
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenRepairVehicleMenu', function(data)
    if HasKeys(QBCore.Functions.GetPlate(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))) then
        if GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < Config.NeededHealthToRepair or GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < Config.NeededHealthToRepair then
            local Menu = {
                id = 'rapir_vehicle_menu', title = Lang.RepairVehicle,
                options = {
                    { title = Lang.VehicleInfo, icon = 'info', disabled = true, description = Lang.EngineHealth .. ': ' .. math.ceil(GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))/10) .. '% \n' .. Lang.BodyHealth .. ': ' .. math.ceil(GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true))/10) .. '%' },
                }
            }
            local text = ""
            for k, v in pairs(Config.RepairNeededItems) do
                if GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) <= 1000.0 and GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 700.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) <= 1000.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 700.0 then
                    if Config.QBInventoryName == 'ox_inventory' then
                        text = text .. "• " .. itemNames[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    else
                        text = text .. "• " .. QBCore.Shared.Items[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    end
                elseif GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 700.0 and GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 300.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 700.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 300.0 then
                    if Config.UseItemsMultiplier then NeededAmount = v.NeededAmount*2 else NeededAmount = v.NeededAmount end
                    if Config.QBInventoryName == 'ox_inventory' then
                        text = text .. "• " .. itemNames[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    else
                        text = text .. "• " .. QBCore.Shared.Items[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    end
                else
                    if Config.UseItemsMultiplier then NeededAmount = v.NeededAmount*3 else NeededAmount = v.NeededAmount end
                    if Config.QBInventoryName == 'ox_inventory' then
                        text = text .. "• " .. itemNames[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    else
                        text = text .. "• " .. QBCore.Shared.Items[v.ItemName].label .. ": " .. v.NeededAmount .. "x \n"
                    end
                end
            end
            Menu.options[#Menu.options+1] = { title = Lang.NeededRepairItems, disabled = true, description = text, icon = 'tools' }
            if GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 990.0 and GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 700.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 990.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 700.0 then
                Menu.options[#Menu.options+1] = { title = Lang.RepairVehicle, icon = 'car-crash', event = 'mt-mechanic:client:RepairVehicleItems', args = { Multiplier = 0 } }
            elseif GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 700.0 and GetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 300.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) < 700.0 and GetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) > 300.0 then
                Menu.options[#Menu.options+1] = { title = Lang.RepairVehicle, icon = 'fas fa-car-crash', event = 'mt-mechanic:client:RepairVehicleItems', args = { Multiplier = 2 } }
            else
                Menu.options[#Menu.options+1] = { title = Lang.RepairVehicle, icon = 'car-crash', event = 'mt-mechanic:client:RepairVehicleItems', args = { Multiplier = 3 } }
            end
            lib.registerContext(Menu)
            lib.showContext('rapir_vehicle_menu')
        else
            QBCore.Functions.Notify(Lang.NoNeedRepair, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NoKeys, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:RepairVehicleItems', function(data)
    if Config.UseItemsMultiplier then Multiplier = data.Multiplier else Multiplier = 0 end
    lib.callback('mt-mechanic:server:CheckRepairItems', source, function(result)
        if result then
            OpenAllVehicleDoors()
            repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
            SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), false, true, false)
            QBCore.Functions.Progressbar('name_here', Lang.RepairingEngine, Config.Times['RepairEngineTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'mini@repair', anim = 'fixing_a_ped' }, {}, {}, function()
                QBCore.Functions.Progressbar('name_here', Lang.RepairingBody, Config.Times['RepairBodyTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
                    SetVehicleFixed(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) SetVehicleEngineHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 1000.0) SetVehicleBodyHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 1000.0) SetVehiclePetrolTankHealth(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 1000.0) SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), true, false)
                    for i = 0, 4 do
                        SetVehicleTyreFixed(GetVehiclePedIsIn(PlayerPedId(), false), i)
                    end
                    DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors() TriggerServerEvent('mt-mechanic:server:RemoveItemRepair', Config.RepairNeededItems, Multiplier)
                end, function() DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors() end)
            end, function() DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) ShutAllVehicleDoors() end)
        else
            QBCore.Functions.Notify(Lang.NoItem, 'error', 7500)
        end
    end, Config.RepairNeededItems, Multiplier)
end)

-- Repair Kit

RegisterNetEvent('mt-mechanic:client:UseRepairKit', function()
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)

    if distance then
        if GetVehicleEngineHealth(vehicle) < Config.NeededHealthToRepair then
            SetVehicleDoorOpen(vehicle, 4, false, false)
            repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
            SetVehicleEngineOn(vehicle, false, true, false)
            QBCore.Functions.Progressbar('name_here', Lang.RepairingEngine, Config.Times['RepairEngineTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'mini@repair', anim = 'fixing_a_ped', }, {}, {}, function()
                SetVehicleEngineHealth(vehicle, 1000.0) SetVehicleEngineOn(vehicle, true, false) DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false) TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_repair_kit', 1) AnotherActionsOnRepair(vehicle)
            end, function()
                DeleteEntity(repairBox) ClearPedTasks(PlayerPedId()) SetVehicleDoorShut(vehicle, 4, false)
            end)
        else
            QBCore.Functions.Notify(Lang.NoNeedRepair, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)