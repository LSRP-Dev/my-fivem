local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:OpenWheelsCategoryMenu', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if distance then
        updateProperties()
        local CategoryMenu = {
            title = Lang.WheelsMenu,
            id = 'wheels_first_menu',
            options = {}
        }
        for k, v in pairs(Config.WheelCategories) do
            CategoryMenu.options[#CategoryMenu.options + 1] = { title = v.Label, arrow = true, event = 'mt-mechanic:client:OpenWheelsMenu', args = { categorie = k } }
        end
        lib.registerContext(CategoryMenu)
        lib.showContext('wheels_first_menu')
    else
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenWheelsMenu', function(data)
    local vehicle, distance = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)
    if distance then
        local WheelsMenu = {
            title = Lang.WheelsMenu,
            menu = 'wheels_first_menu',
            id = 'wheels_secund_menu',
            options = {}
        }
        for i = -1, GetNumVehicleMods(vehicle, 23) do 
            if GetVehicleMod(vehicle, 23) == i and GetVehicleWheelType(vehicle) == (data.categorie-1) then
                if i+2 == 1 then
                    WheelsMenu.options[#WheelsMenu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                else
                    WheelsMenu.options[#WheelsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, 23, i)) .. ' ' .. Config.WheelCategories[data.categorie].Label, description = Lang.Applied, disabled = true }
                end
            else
                if i+2 == 1 then
                    WheelsMenu.options[#WheelsMenu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyWheel', args = { id = i, Type = data.categorie } }
                elseif GetLabelText(GetModTextLabel(vehicle, tonumber(23), tonumber(i))) ~= "NULL" then
                    WheelsMenu.options[#WheelsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(vehicle, 23, i)) .. ' ' .. Config.WheelCategories[data.categorie].Label, event = 'mt-mechanic:client:ApplyWheel', args = { id = i, Type = data.categorie } }
                end
            end
        end
        SetVehicleWheelType(vehicle, (data.categorie-1))
        lib.registerContext(WheelsMenu)
        lib.showContext('wheels_secund_menu')
    else
        QBCore.Functions.Notify(Lang.NoVehicleNearby, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyWheel', function(data)
    SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), false, false, false)
    repairBox = makeProp({ prop = Config.ToolBoxProp, coords = vector4(GetPedBoneCoords(PlayerPedId()).x+1.0, GetPedBoneCoords(PlayerPedId()).y, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
    QBCore.Functions.Progressbar('name_here', Lang.InstallingWheel, Config.Times['WheelsTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', anim = 'machinic_loop_mechandplayer' }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), true, false, false)
        DeleteEntity(repairBox)
        SetVehicleMod(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), 23, tonumber(data.id), false)
        saveVehicle()
        TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_wheels', 1, nil)
        LogData = { User = GetPlayerName(PlayerId()), Action = Logs.Translations.InstalledWheels, Plate = GetVehicleNumberPlateText(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true)) }
        TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
    end, function()
        ClearPedTasks(PlayerPedId())
        SetVehicleEngineOn(lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3.0, true), true, false, false)
        DeleteEntity(repairBox)
    end)
end)