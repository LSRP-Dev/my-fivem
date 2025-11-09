local QBCore = exports[Config.QBCoreName]:GetCoreObject()
local Type = nil local item = nil

RegisterNetEvent('mt-mechanic:client:SelectPaintMenu', function(Item)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    item = Item
    if distance then
        lib.registerContext({
            id = 'paints_main_menu', title = Lang.PaintMenuHeader,
            options = {
                { title = Lang.Primary, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'Primary' } },
                { title = Lang.Secundary, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'Secundary' } },
                { title = Lang.Pearlescent, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'Pearlescent' } },
                { title = Lang.WheelsColour, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'WheelsColour' } },
                { title = Lang.DashboardColour, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'DashboardColour' } },
                { title = Lang.InteriorColour, icon = 'spray-can', event = 'mt-mechanic:client:PaintMainMenu', args = { Type = 'InteriorColour' } },
            }
        })
        lib.showContext('paints_main_menu')
    else    
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:PaintMainMenu', function(data)
    if data.Type == 'Primary' or data.Type == 'Secundary' then
        lib.registerContext({
            id = 'paints_secund_menu', title = Lang.PaintMenuHeader, menu = 'paints_main_menu',
            options = {
                { title = Lang.Metallic, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Metallic' } },
                { title = Lang.Matte, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Matte' } },
                { title = Lang.Metals, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Metals' } },
                { title = Lang.Chameleon, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Chameleon' } },
                { title = Lang.RGB, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'RGB' } },
            }
        })
    else
        lib.registerContext({
            id = 'paints_secund_menu', title = Lang.PaintMenuHeader, menu = 'paints_main_menu',
            options = {
                { title = Lang.Metallic, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Metallic' } },
                { title = Lang.Matte, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Matte' } },
                { title = Lang.Metals, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Metals' } },
                { title = Lang.Chameleon, icon = 'spray-can', event = 'mt-mechanic:client:PaintsMenu', args = { Type = data.Type, Type2 = 'Chameleon' } },
            }
        })
    end
    lib.showContext('paints_secund_menu')
end)

RegisterNetEvent('mt-mechanic:client:PaintsMenu', function(data)
    if data.Type2 == 'RGB' then
        args = {
            Type2 = data.Type2,
            Type = data.Type,
        }
        TriggerEvent('mt-mechanic:client:ApplyPaintToVehcile', args)
    else
        local Menu = {
            title = Lang.PaintMenuHeader,
            id = 'paints_vehicle_menu',
            menu = 'paints_secund_menu',
            options = {}
        }
        for k, v in pairs(Config.Colours[data.Type2]) do
            Menu.options[#Menu.options+1] = {
                title = Config.Colours[data.Type2][k].Label, event = 'mt-mechanic:client:ApplyPaintToVehcile', args = { Type2 = data.Type2, Type = data.Type, Number = Config.Colours[data.Type2][k].Number },
            }
        end
        lib.registerContext(Menu)
        lib.showContext('paints_vehicle_menu')
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyPaintToVehcile', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    local PrimaryColor, SecundaryColor = GetVehicleColours(vehicle)
    local pearl, wheel = GetVehicleExtraColours(vehicle)

    if distance then
        if data.Type2 == 'RGB' then
            local RGBInput = lib.inputDialog(Lang.RGBColorInput, {
                {type = 'color', format = 'rgb', label = Lang.RGBColorInput},
            })
            
            if RGBInput ~= nil then
                local r, g, b = string.match(RGBInput[1], "rgb%((%d+), (%d+), (%d+)%)")
                spraycan = makeProp({ prop = `ng_proc_spraycan01b`, coords = vector4(0.0, 0.0, 0.0, 0.0)}, 0, 1)
                AttachEntityToEntity(spraycan, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.11, 0.05, -0.06, 28.0, 30.0, 0.0, true, true, false, true, 1, true)
                playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", Config.Times['PaintTime'], 1)
                Wait(1000)
                stopAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar")
                playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", Config.Times['PaintTime'], 8)
                loadPtfxDict("core")
                UseParticleFxAssetNextCall("core")
                local spray = StartParticleFxLoopedOnEntity("ent_amb_steam", spraycan, 0.0, 0.13, 0.0, 90.0, 90.0, 0.0, 0.2, 0.0, 0.0, 0.0)
                SetParticleFxLoopedAlpha(spray, 255.0)
                SetParticleFxLoopedColour(spray, tonumber(r+.0), tonumber(g+.0), tonumber(b+.0))
                QBCore.Functions.Progressbar('name_here', Lang.PaintingVehicle, Config.Times['PaintTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, {}, {}, {}, function()
                    if data.Type == 'Primary' then
                        SetVehicleCustomPrimaryColour(vehicle, tonumber(r), tonumber(g), tonumber(b))
                    elseif data.Type == 'Secundary' then
                        SetVehicleCustomSecondaryColour(vehicle, tonumber(r), tonumber(g), tonumber(b))
                    end
                    ClearPedTasks(PlayerPedId())
                    DeleteEntity(spraycan)
                    TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_paint_spray', 1)
                    saveVehicle()
                end, function()
                    ClearPedTasks(PlayerPedId())
                    DeleteEntity(spraycan)
                end)
            end
        else
            spraycan = makeProp({ prop = `ng_proc_spraycan01b`, coords = vector4(0.0, 0.0, 0.0, 0.0)}, 0, 1)
            AttachEntityToEntity(spraycan, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.11, 0.05, -0.06, 28.0, 30.0, 0.0, true, true, false, true, 1, true)
            if Type == 'dashboard' or Type == 'interior' then
                OpenAllVehicleDoors()
            end
            playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar", Config.Times['PaintTime'], 1)
            Wait(1000)
            stopAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_wall_loop_lamar")
            playAnim("switch@franklin@lamar_tagging_wall", "lamar_tagging_exit_loop_lamar", Config.Times['PaintTime'], 1)
            loadPtfxDict("core")
            UseParticleFxAssetNextCall("core")
            local spray = StartParticleFxLoopedOnEntity("ent_amb_steam", spraycan, 0.0, 0.13, 0.0, 90.0, 90.0, 0.0, 0.2, 0.0, 0.0, 0.0)
            SetParticleFxLoopedAlpha(spray, 255.0)
            SetParticleFxLoopedColour(spray, 255, 255, 255)
            QBCore.Functions.Progressbar('name_here', Lang.PaintingVehicle, Config.Times['PaintTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, {}, {}, {}, function()
                if data.Type == 'Primary' then
                    ClearVehicleCustomPrimaryColour(vehicle)
                    SetVehicleColours(vehicle, data.Number, SecundaryColor)
                elseif data.Type == 'Secundary' then
                    ClearVehicleCustomSecondaryColour(vehicle)
                    SetVehicleColours(vehicle, PrimaryColor, data.Number)
                elseif data.Type == 'Pearlescent' then
                    SetVehicleExtraColours(vehicle, data.Number, wheel)
                elseif data.Type == 'WheelsColour' then
                    SetVehicleExtraColours(vehicle, pearl, data.Number)
                elseif data.Type == 'DashboardColour' then
                    SetVehicleDashboardColor(vehicle, data.Number)
                    ShutAllVehicleDoors()
                elseif data.Type == 'InteriorColour' then
                    SetVehicleInteriorColor(vehicle, data.Number)
                    ShutAllVehicleDoors()
                end
                ClearPedTasks(PlayerPedId())
                DeleteEntity(spraycan)
                TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_paint_spray', 1)
                saveVehicle()
                local LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledPaint, Plate = GetVehicleNumberPlateText(vehicle) }
                TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
            end, function()
                ClearPedTasks(PlayerPedId())
                DeleteEntity(spraycan)
            end)
        end
    else    
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)