local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:NeonTypeMenu', function(data)
    if IsPedInAnyVehicle(PlayerPedId()) then
        lib.registerContext({
            id = 'mechanic_main_neons_menu',
            title = Lang.NeonsMenuHeader, 
            options = {
                { title = Lang.ControlXenons, icon = 'lightbulb', event = 'mt-mechanic:client:OpenXenonsMenu' },
                { title = Lang.ControlNeons, icon = 'lightbulb', event = 'mt-mechanic:client:OpenNeonsMenu' },
            }
        })
        lib.showContext('mechanic_main_neons_menu')
    else
        QBCore.Functions.Notify(Lang.NotInVehicle, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenNeonsMenu', function(data)
    if IsVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), 0) and IsVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), 1) and IsVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), 2) and IsVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), 3) then
        lib.registerContext({
            id = 'mechanic_active_neons_menu',
            title = Lang.NeonsMenuHeader, 
            menu = 'mechanic_main_neons_menu',
            options = {
                { title = Lang.DisableNeons, icon = 'power-off', event = 'mt-mechanic:client:NeonsActions', args = { Action = 'DisableNeons' } },
                { title = Lang.ChangeRGBColor, icon = 'exchange-alt', event = 'mt-mechanic:client:NeonsActions', args = { Action = 'ChangeRGBColor' } },
                { title = Lang.ChangeColor, icon = 'exchange-alt', event = 'mt-mechanic:client:NeonsActions', args = { Action = 'ChangeColor' } },
            }
        })
        lib.showContext('mechanic_active_neons_menu')
    else
        lib.registerContext({
            id = 'mechanic_disabled_neons_menu',
            title = Lang.NeonsMenuHeader, 
            menu = 'mechanic_main_neons_menu',
            options = {
                { title = Lang.EnableNeons, icon = 'power-off', event = 'mt-mechanic:client:NeonsActions', args = { Action = 'EnableNeons' } },
            }
        })
        lib.showContext('mechanic_disabled_neons_menu')
    end
end)

RegisterNetEvent('mt-mechanic:client:NeonsActions', function(data)
    if data.Action == 'EnableNeons' then
        for i = 0, 3 do
            SetVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), i, true)
        end
        saveVehicle()
        TriggerEvent('mt-mechanic:client:OpenNeonsMenu')
    elseif data.Action == 'DisableNeons' then
        for i = 0, 3 do
            SetVehicleNeonLightEnabled(GetVehiclePedIsIn(PlayerPedId(), false), i, false)
        end
        saveVehicle()
        TriggerEvent('mt-mechanic:client:OpenNeonsMenu')
    elseif data.Action == 'ChangeRGBColor' then
        local RGBColorInput = lib.inputDialog(Lang.RGBColorInput, {
            {type = 'color', format = 'rgb', label = Lang.RGBColorInput},
        })
        
        if RGBColorInput ~= nil then
            local r, g, b = string.match(RGBColorInput[1], "rgb%((%d+), (%d+), (%d+)%)")
            SetVehicleNeonLightsColour(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(r), tonumber(g), tonumber(b))
            saveVehicle()
            TriggerEvent('mt-mechanic:client:OpenNeonsMenu')
        end
    elseif data.Action == 'ChangeColor' then
        Menu = {
            title = Lang.NeonsMenuHeader,
            id = 'neons_controller_colours',
            options = {}
        }
        for _, v in pairs(Config.NeonColours) do
            Menu.options[#Menu.options+1] = {
                title = v.Label,
                event = 'mt-mechanic:client:NeonsActions',
                args = {
                    Action = 'SetNeonColor',
                    RColor = v.RGBCode.R,
                    GColor = v.RGBCode.G,
                    BColor = v.RGBCode.B,
                },
            }
        end
        lib.registerContext(Menu)
        lib.showContext('neons_controller_colours')
    elseif data.Action == 'SetNeonColor' then
        SetVehicleNeonLightsColour(GetVehiclePedIsIn(PlayerPedId(), false), data.RColor, data.GColor, data.BColor)
        saveVehicle()
        args = { Action = 'ChangeColor' }
        TriggerEvent('mt-mechanic:client:NeonsActions', args)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenXenonsMenu', function(data)
    if IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), true), 22) then
        lib.registerContext({
            id = 'mechanic_active_xeons_menu',
            title = Lang.NeonsMenuHeader, 
            options = {
                { title = Lang.DisableXenons, icon = 'power-off', event = 'mt-mechanic:client:XenonsActions', args = { Action = 'DisableXenons' } },
                { title = Lang.ChangeRGBColor, icon = 'exchange-alt', event = 'mt-mechanic:client:XenonsActions', args = { Action = 'ChangeRGBColor' } },
                { title = Lang.ChangeColor, icon = 'exchange-alt', event = 'mt-mechanic:client:XenonsActions', args = { Action = 'ChangeColor' } },
            }
        })
        lib.showContext('mechanic_active_xeons_menu')
    else
        lib.registerContext({
            id = 'mechanic_disabled_xenons_menu',
            title = Lang.NeonsMenuHeader, 
            menu = 'mechanic_main_neons_menu',
            options = {
                { title = Lang.EnableXenons, icon = 'power-off', event = 'mt-mechanic:client:XenonsActions', args = { Action = 'EnableXenons' } },
            }
        })
        lib.showContext('mechanic_disabled_xenons_menu')
    end
end)

RegisterNetEvent('mt-mechanic:client:XenonsActions', function(data)
    if data.Action == 'EnableXenons' then
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 22, true)
        saveVehicle()
        TriggerEvent('mt-mechanic:client:OpenXenonsMenu')
    elseif data.Action == 'DisableXenons' then
        ToggleVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 22, false)
        saveVehicle()
        TriggerEvent('mt-mechanic:client:OpenXenonsMenu')
    elseif data.Action == 'ChangeRGBColor' then
        local RGBColorInput = lib.inputDialog(Lang.RGBColorInput, {
            {type = 'color', format = 'rgb', label = Lang.RGBColorInput},
        })

        if RGBColorInput ~= nil then
            local r, g, b = string.match(RGBColorInput[1], "rgb%((%d+), (%d+), (%d+)%)")
            SetVehicleXenonLightsCustomColor(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(r), tonumber(g), tonumber(b))
            saveVehicle()
            TriggerEvent('mt-mechanic:client:OpenXenonsMenu')
        end
    elseif data.Action == 'ChangeColor' then
        Menu = {
            title = Lang.NeonsMenuHeader,
            id = 'xenons_controller_colours',
            options = {}
        }
        for _, v in pairs(Config.NeonColours) do
            Menu.options[#Menu.options+1] = {
                title = v.Label,
                event = 'mt-mechanic:client:XenonsActions',
                args = {
                    Action = 'SetXenonColor',
                    RColor = v.RGBCode.R,
                    GColor = v.RGBCode.G,
                    BColor = v.RGBCode.B,
                },
            }
        end
        lib.registerContext(Menu)
        lib.showContext('xenons_controller_colours')
    elseif data.Action == 'SetXenonColor' then
        SetVehicleXenonLightsCustomColor(GetVehiclePedIsIn(PlayerPedId(), false), data.RColor, data.GColor, data.BColor)
        saveVehicle()
        args = { Action = 'ChangeColor' }
        TriggerEvent('mt-mechanic:client:XenonsActions', args)
    end
end)