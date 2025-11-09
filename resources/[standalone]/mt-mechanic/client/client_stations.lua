local QBCore = exports[Config.QBCoreName]:GetCoreObject()
local MenuRadial = nil local MenuRadial2 = nil local Type = nil local OriginalPrimaryColor = nil local OriginalSecundaryColour = nil local OriginalInteirorColour = nil local OriginalWheelsColour = nil local OriginalDashboardColour = nil local OriginalPearlescentColour = nil local ORPColor, OGPColor, OBPColor = nil local ORSColor, OGSColor, OSPColor = nil local OriginalMods = {} local Active = false

CreateThread(function()
    while true do
        if Active then
            if not IsPedInAnyVehicle(PlayerPedId()) then
                Wait(500)
                local CPColor, CSColor = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), true)) local CPRColor, CWColor = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), true)) local DSHColor = GetVehicleDashboardColor(GetVehiclePedIsIn(PlayerPedId(), true)) local INColor = GetVehicleInteriorColor(GetVehiclePedIsIn(PlayerPedId(), true)) RPColor, GPColor, BPColor = GetVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), true)) RSColor, GSColor, BSColor = GetVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), true))
                TriggerServerEvent('mt-mechanic:server:AddReceipt', GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), true)), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 23, OriginalMods[1])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 48, OriginalMods[2])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 4, OriginalMods[3])),  GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 1, OriginalMods[4])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 2, OriginalMods[5])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 0, OriginalMods[6])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 3, OriginalMods[7])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 7, OriginalMods[8])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 6, OriginalMods[9])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 14, OriginalMods[10])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 10, OriginalMods[11])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 27, OriginalMods[12])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 28, OriginalMods[13])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 29, OriginalMods[14])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 30, OriginalMods[15])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 31, OriginalMods[16])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 32, OriginalMods[17])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 33, OriginalMods[18])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 37, OriginalMods[19])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 38, OriginalMods[20])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 39, OriginalMods[21])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 40, OriginalMods[22])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 41, OriginalMods[23])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 5, OriginalMods[24])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 43, OriginalMods[25])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 44, OriginalMods[26])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 45, OriginalMods[27])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 42, OriginalMods[28])), OriginalPrimaryColor, OriginalSecundaryColour, OriginalInteirorColour, OriginalDashboardColour, OriginalWheelsColour, OriginalPearlescentColour, GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 23, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 23))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 48, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 48))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 4, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 4))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 1, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 1))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 2, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 2))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 0, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 0))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 3, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 3))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 7, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 7))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 6, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 6))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 10, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 10))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 14, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 14))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 27, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 27))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 28, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 28))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 29, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 29))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 30, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 30))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 31, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 31))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 32, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 32))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 33, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 33))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 37, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 37))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 38, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 38))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 39, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 39))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 40, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 40))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 41, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 41))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 5, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 5))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 43, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 43))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 44, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 44))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 45, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 45))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 42, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 42))), CPColor, CSColor, INColor, DSHColor, CWColor, CPRColor, RPColor, GPColor, BPColor, RSColor, GSColor, BSColor, ORPColor, OGPColor, OBPColor, ORSColor, OGSColor, OBSColor, GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 8, OriginalMods[29])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 9, OriginalMods[30])), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 8, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 8))), GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), true), 9, GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 9))), GetLabelText(GetLiveryName(GetVehiclePedIsIn(PlayerPedId(), true), OriginalMods[31])), GetLabelText(GetLiveryName(GetVehiclePedIsIn(PlayerPedId(), true), GetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), true)))))
                Wait(500) FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), false) SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), true), 4) ClearVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), true)) ClearVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), true)) SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), true), ORPColor, OGPColor, OBPColor) SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), true), ORSColor, OGSColor, OBSColor) SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), true), OriginalPrimaryColor, OriginalSecundaryColour) SetVehicleInteriorColor(GetVehiclePedIsIn(PlayerPedId(), true), OriginalInteirorColour) SetVehicleDashboardColor(GetVehiclePedIsIn(PlayerPedId(), true), OriginalDashboardColour) SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), true), 0, OriginalWheelsColour) SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), true), OriginalPearlescentColour, 0) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 23, OriginalMods[1], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 48, OriginalMods[2], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 4, OriginalMods[3], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 1, OriginalMods[4], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 2, OriginalMods[5], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 0, OriginalMods[6], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 3, OriginalMods[7], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 7, OriginalMods[8], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 6, OriginalMods[9], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 14, OriginalMods[10], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 10, OriginalMods[11], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 27, OriginalMods[12], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 28, OriginalMods[13], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 29, OriginalMods[14], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 30, OriginalMods[15], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 31, OriginalMods[16], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 32, OriginalMods[17], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 33, OriginalMods[18], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 37, OriginalMods[19], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 38, OriginalMods[20], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 39, OriginalMods[21], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 40, OriginalMods[22], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 41, OriginalMods[23], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 42, OriginalMods[24], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 43, OriginalMods[25], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 44, OriginalMods[26], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 45, OriginalMods[27], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 5, OriginalMods[28], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 8, OriginalMods[29], false) SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), true), 9, OriginalMods[30], false) SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), true), OriginalMods[30]) updateProperties()
                OriginalMods = {}
                Active = false
            end
        end
        Wait(1)
    end
end)

function inside(self)
    if IsPedInAnyVehicle(PlayerPedId()) then
        exports[Config.QBCoreName]:DrawText(Lang.RadialMenuStation, 'left')
    else
        exports[Config.QBCoreName]:HideText()
    end
end

function onEnter(self)
    local PlayerData = QBCore.Functions.GetPlayerData()
    if self.spot.Job == 'all' or PlayerData.job.name == self.spot.Job then
        if self.spot.Options.Preview then
            if Config.QBRadialMenuName == 'ox_lib' then
                MenuRadial = lib.addRadialItem({ id = self.radialID, icon = 'car', label = Lang.OpenPreview, onSelect = function() TriggerEvent('mt-mechanic:client:PreviewStationMenu') end })
            else
                MenuRadial = exports[Config.QBRadialMenuName]:AddOption({ id = self.radialID, title = Lang.OpenPreview, icon = 'car', type = 'client', event = 'mt-mechanic:client:PreviewStationMenu', shouldClose = true, })
            end
        end
        if self.spot.Options.Repair then
            if Config.QBRadialMenuName == 'ox_lib' then
                MenuRadial2 = lib.addRadialItem({ id = self.radialID2, icon = 'car', label = Lang.OpenRepair, onSelect = function() TriggerEvent('mt-mechanic:client:RepairStationMenu') end })
            else
                MenuRadial2 = exports[Config.QBRadialMenuName]:AddOption({ id = self.radialID2, title = Lang.OpenRepair, icon = 'car', type = 'client', event = 'mt-mechanic:client:RepairStationMenu', shouldClose = true, })
            end
        end
    end
end

function onExit(self)
    exports[Config.QBCoreName]:HideText()
    if Config.QBRadialMenuName == 'ox_lib' then
        lib.removeRadialItem(self.radialID)
    elseif MenuRadial ~= nil then
        exports[Config.QBRadialMenuName]:RemoveOption(MenuRadial)
    end
    MenuRadial = nil
    if Config.QBRadialMenuName == 'ox_lib' then
        lib.removeRadialItem(self.radialID2)
    elseif MenuRadial2 ~= nil then
        exports[Config.QBRadialMenuName]:RemoveOption(MenuRadial2)
    end
    MenuRadial2 = nil
end

CreateThread(function()
    local newSpot = {}
    for i, spot in pairs(Config.StationsZones) do
        local _name = tostring(spot.Job..'-MecStation-'..i)
        local _name2 = tostring(_name.."-repair")
        newSpot[i] = lib.zones.box({
            coords = spot.Coords,
            size = vec3(spot.Width, spot.Length, 20),
            rotation = spot.Heading,
            debug = Config.DebugPoly,
            inside = inside,
            spot = spot,
            radialID = _name,
            radialID2 = _name2,
            onEnter = onEnter,
            onExit = onExit
        })
    end
end)

RegisterNetEvent('mt-mechanic:client:RepairStationMenu', function(data)
    local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
    local VehicleDamage = math.ceil((GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false))/10))
    local health = math.ceil(VehicleDamage/2)+math.ceil(VehicleDamage/2) 
    local Price = 0
    local VehicleModel = nil 
    local VehiclePrice = nil
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if tonumber(v.hash) == GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) or GetHashKey(v.hash) == GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) then
            local percent = (Config.RepairPercentage / 100)
            Price = math.ceil((QBCore.Shared.Vehicles[k].price * percent) - math.ceil((health/100) * (QBCore.Shared.Vehicles[k].price * percent)))
            VehicleModel = QBCore.Shared.Vehicles[k].name
            VehiclePrice = QBCore.Shared.Vehicles[k].price
        end
    end

    if IsPedInAnyVehicle(PlayerPedId()) then
        lib.registerContext({
            id = 'repair_vehicle_menu',
            title = Lang.RepairStationMenuHeader,
            options = {
                {
                    title = Lang.VehicleHealth .. tonumber(VehicleDamage) .. '%' .. '\n' .. Lang.PriceToRepair .. Price .. '$' .. '\n' .. Lang.VehicleModel .. VehicleModel .. '\n' .. Lang.VehiclePrice .. VehiclePrice .. '$',
                    disabled = true,
                    icon = 'tools',
                },
                {
                    title = Lang.Repair .. ' - ' .. Price .. '$',
                    icon = 'check',
                    event = 'mt-mechanic:client:RepairVehicle',
                    args = {
                        Price = Price,
                    }
                }, 
            }
        })
        lib.showContext('repair_vehicle_menu')
    else
        QBCore.Functions.Notify(Lang.NotInVehicle, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:RepairVehicle', function(data)
    if GetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false)) < 1000.0 or GetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false)) < 1000.0 then
        lib.callback('mt-mechanic:server:VerifyMoney', source, function(HasMoney)
            if HasMoney then
                SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), false, true, false)
                QBCore.Functions.Progressbar('name_here', Lang.RepairingVehicle, Config.Times['RepairTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, {}, {}, {}, function()
                    SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId(), false))
                    SetVehicleEngineHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
                    SetVehicleBodyHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
                    SetVehiclePetrolTankHealth(GetVehiclePedIsIn(PlayerPedId(), false), 1000.0)
                    for i = 0, 4 do
                        SetVehicleTyreFixed(GetVehiclePedIsIn(PlayerPedId(), false), i)
                    end
                    TriggerServerEvent('mt-mechanic:server:RemoveMoney', 'cash', data.Price)
                    Price = 0
                end, function()
                    SetVehicleEngineOn(GetVehiclePedIsIn(PlayerPedId(), false), true, true, false)
                end)
            else
                QBCore.Functions.Notify(Lang.NoMoney, 'error', 7500)
            end
        end, 'cash', data.Price)
    else
        QBCore.Functions.Notify(Lang.VehicleAlreadyRepaired, 'error', 7500)
    end
end)

RegisterNetEvent('mt-mechanic:client:PreviewStationMenu', function(data)
    if IsPedInAnyVehicle(PlayerPedId()) then
        updateProperties()
        local VehicleModel = nil 
        local VehiclePrice = nil
        for k, v in pairs(QBCore.Shared.Vehicles) do
            if GetHashKey(v.hash) == GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) or tonumber(v.hash) == GetEntityModel(GetVehiclePedIsIn(PlayerPedId(), false)) then
                VehicleModel = QBCore.Shared.Vehicles[k].name
                VehiclePrice = QBCore.Shared.Vehicles[k].price
            end
        end
        if Active == false then
            OriginalPrimaryColor, OriginalSecundaryColour = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false)) OriginalMods[1] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 23) OriginalMods[2] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 48) OriginalMods[3] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 4) OriginalMods[4] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 1) OriginalMods[5] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 2) OriginalMods[6] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 0) OriginalMods[7] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 3) OriginalMods[8] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 7) OriginalMods[9] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 6) OriginalMods[10] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 10) OriginalMods[11] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 14) OriginalMods[12] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 27) OriginalMods[13] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 28) OriginalMods[14] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 29) OriginalMods[15] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 30) OriginalMods[16] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 31) OriginalMods[17] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 32) OriginalMods[18] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 33) OriginalMods[19] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 37) OriginalMods[20] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 38) OriginalMods[21] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 39) OriginalMods[22] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 40) OriginalMods[23] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 41) OriginalMods[24] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 42) OriginalMods[25] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 43) OriginalMods[26] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 44) OriginalMods[27] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 45) OriginalMods[28] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 5) OriginalInteirorColour = GetVehicleInteriorColor(GetVehiclePedIsIn(PlayerPedId(), false)) OriginalDashboardColour = GetVehicleDashboardColor(GetVehiclePedIsIn(PlayerPedId(), false)) ORPColor, OGPColor, OBPColor = GetVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), false)) ORSColor, OGSColor, OBSColor = GetVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), false)) OriginalPearlescentColour, OriginalWheelsColour = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false)) FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId(), true), true) OriginalMods[29] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 8) OriginalMods[30] = GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 9) OriginalMods[31] = GetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false)) Active = true
        end

        lib.registerContext({
            id = 'preview_main_menu',
            title = Lang.PreviewMenu,
            options = {
                { title = Lang.VehiclePrice .. VehiclePrice .. '$' .. '\n' .. Lang.VehicleModel .. VehicleModel, disabled = true, }, 
                { title = Lang.WheelsMenu, arrow = true, menu = 'preview_wheels_menu' },
                { title = Lang.InteriorsMenu, arrow = true, menu = 'preview_interiors_menu' },
                { title = Lang.ExteriorsMenu, arrow = true, menu = 'preview_exteriors_menu' },
                { title = Lang.PaintMenuHeader, arrow = true, menu = 'preview_paints_menu' },
                { title = Lang.LiveryMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 48, Header = Lang.LiveryMenu, lastMenu = 'preview_main_menu' } },
                { title = Lang.ExhaustsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 4, Header = Lang.ExhaustsMenu, lastMenu = 'preview_main_menu'} },
                { title = Lang.FrontBumper, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 1, Header = Lang.FrontBumper, lastMenu = 'preview_main_menu' } },
                { title = Lang.RearBumper, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 2, Header = Lang.RearBumper, lastMenu = 'preview_main_menu' } },
                { title = Lang.SpoilersMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 0, Header = Lang.SpoilersMenu, lastMenu = 'preview_main_menu' } },
                { title = Lang.SkirtsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 3, Header = Lang.SkirtsMenu, lastMenu = 'preview_main_menu' } },
                { title = Lang.BonnetsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 7, Header = Lang.BonnetsMenu, lastMenu = 'preview_main_menu' } },
                { title = Lang.GrillsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 6, Header = Lang.GrillsMenu, lastMenu = 'preview_main_menu' } },
                { title = Lang.HornsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 14, Header = Lang.HornsMenu, lastMenu = 'preview_main_menu' }  },
                { title = Lang.RoofsMenu, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 10, Header = Lang.RoofsMenu, lastMenu = 'preview_main_menu' } },
            }
        })
        lib.showContext('preview_main_menu')
        lib.registerContext({
            id = 'preview_paints_menu',
            title = Lang.PaintMenuHeader,
            icon = 'spray-can',
            menu = 'preview_main_menu',
            options = {
                { title = Lang.Primary, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'Primary' } },
                { title = Lang.Secundary, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'Secundary' } },
                { title = Lang.Pearlescent, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'Pearlescent' } },
                { title = Lang.WheelsColour, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'WheelsColour' } },
                { title = Lang.DashboardColour, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'DashboardColour' } },
                { title = Lang.InteriorColour, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 'firstPaintMenu', Header = Lang.PaintMenuHeader, lastMenu = 'preview_paints_menu', Type = 'InteriorColour' } },
            }
        })
        lib.registerContext({
            id = 'preview_interiors_menu',
            title = Lang.PreviewMenu,
            menu = 'preview_main_menu',
            options = {
                { title = Lang.Interior1, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 27, Header = Lang.Interior1, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Interior2, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 28, Header = Lang.Interior2, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Interior3, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 29, Header = Lang.Interior3, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Interior4, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 30, Header = Lang.Interior4, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Interior5, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 31, Header = Lang.Interior5, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Seats, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 32, Header = Lang.Seats, lastMenu = 'preview_interiors_menu' } },
                { title = Lang.Steering, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 33, Header = Lang.Steering, lastMenu = 'preview_interiors_menu' } },
            }
        })
        lib.registerContext({
            id = 'preview_exteriors_menu',
            title = Lang.PreviewMenu,
            menu = 'preview_main_menu',
            options = {
                { title = Lang.Trunk, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 37, Header = Lang.Trunk, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Hydro, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 38, Header = Lang.Hydro, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.EngineBay1, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 39, Header = Lang.EngineBay1, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.EngineBay2, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 40, Header = Lang.EngineBay2, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.EngineBay3, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 41, Header = Lang.EngineBay3, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Chassis1, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 5, Header = Lang.Chassis1, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Chassis2, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 42, Header = Lang.Chassis2, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Chassis3, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 43, Header = Lang.Chassis3, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Chassis4, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 44, Header = Lang.Chassis4, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.Chassis5, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 45, Header = Lang.Chassis5, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.LeftFender, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 8, Header = Lang.LeftFender, lastMenu = 'preview_exteriors_menu' } },
                { title = Lang.RightFender, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 9, Header = Lang.RightFender, lastMenu = 'preview_exteriors_menu' } },
            }
        })
        local WheelsMenu = { id = 'preview_wheels_menu', title = Lang.WheelsMenu, menu = 'preview_main_menu', options = {} }
        for k, v in pairs(Config.WheelCategories) do
            WheelsMenu.options[#WheelsMenu.options+1] = { title = v.Label, arrow = true, event = 'mt-mechanic:client:OpenModsMenu', args = { mod = 23, Header = Lang.WheelsMenu, categorie = k, lastMenu = 'preview_wheels_menu' } }
        end
        lib.registerContext(WheelsMenu)
    end
end)

RegisterNetEvent('mt-mechanic:client:OpenModsMenu', function(data)
    if data.mod == 39 or data.mod == 40 or data.mod == 41 then SetVehicleDoorOpen(GetVehiclePedIsIn(PlayerPedId(), false), 4) else SetVehicleDoorShut(GetVehiclePedIsIn(PlayerPedId(), false), 4) end
    if data.mod == 14 then
        local HornsMenu = { id = 'preview_horns_menu', title = Lang.HornsMenu, menu = data.lastMenu, options = {} }
        for i = -1, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), 14) do
            if GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), 14) == i then
                if i+2 == 1 then
                    HornsMenu.options[#HornsMenu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                else
                    HornsMenu.options[#HornsMenu.options + 1] = { title = Lang.Horn .. tonumber(i+1), description = Lang.Applied, disabled = true }
                end
            else
                if i+2 == 1 then
                    HornsMenu.options[#HornsMenu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, id = i, mod = 14, } }
                else
                    HornsMenu.options[#HornsMenu.options + 1] = { title = Lang.Horn .. tonumber(i+1), event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, id = i, mod = 14, } }
                end
            end
        end
        lib.registerContext(HornsMenu)
        lib.showContext('preview_horns_menu')
    elseif data.mod == 'firstPaintMenu' then
        if data.Type == 'Primary' or data.Type == 'Secundary' then
            lib.registerContext({
                id = 'preview_paints_categorie_menu',
                title = data.Header,
                menu = data.lastMenu,
                options = {
                    { title = Lang.Metallic, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Metallic', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Matte, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Matte', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Metals, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Metals', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Chameleon, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Chameleon', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.RGB, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'RGB', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                }
            })
        else
            lib.registerContext({
                id = 'preview_paints_categorie_menu',
                title = data.Header,
                menu = data.lastMenu,
                options = {
                    { title = Lang.Metallic, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Metallic', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Matte, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Matte', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Metals, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Metals', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                    { title = Lang.Chameleon, arrow = true, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { Type = data.Type, Type2 = 'Chameleon', mod = 'paint', Header = data.Header, lastMenu = 'preview_paints_categorie_menu' } },
                }
            })
        end
        lib.showContext('preview_paints_categorie_menu')
    elseif data.mod == 48 then
        ModsMenu = { id = 'preview_actual_mod_menu', title = data.Header, menu = data.lastMenu, options = {} }
        if GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), data.mod)-1 >= 0 then
            for i = -1, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), data.mod)-1 do
                if GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), data.mod) == i then
                    if i+2 == 1 then
                        ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                    else
                        ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.mod), tonumber(i))), description = Lang.Applied, disabled = true }
                    end
                else
                    if i+2 == 1 then
                        ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, id = i, mod = data.mod } }
                    else
                        ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.mod), tonumber(i))), event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, Header = data.Header, id = i, mod = data.mod } }
                    end
                end
            end
        else
            for i = -1, GetVehicleLiveryCount(GetVehiclePedIsIn(PlayerPedId(), false))-1 do
                if GetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false)) == i then
                    if i+2 == 1 then
                        ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                    else
                        ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetLiveryName(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(i))), description = Lang.Applied, disabled = true }
                    end
                else
                    if i+2 == 1 then
                        ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, id = i, mod = data.mod } }
                    else
                        ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetLiveryName(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(i))), event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, Header = data.Header, id = i, mod = data.mod } }
                    end
                end
            end
        end
        lib.registerContext(ModsMenu)
        lib.showContext('preview_actual_mod_menu')
    else
        if data.mod == 23 and data.categorie ~= nil then SetVehicleWheelType(GetVehiclePedIsIn(PlayerPedId(), false), (data.categorie-1)) end
        ModsMenu = { id = 'preview_actual_mod_menu', title = data.Header, menu = data.lastMenu, options = {} }
        for i = -1, GetNumVehicleMods(GetVehiclePedIsIn(PlayerPedId(), false), data.mod)-1 do
            if GetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), data.mod) == i then
                if i+2 == 1 then
                    ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, description = Lang.Applied, disabled = true }
                else
                    ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.mod), tonumber(i))), description = Lang.Applied, disabled = true }
                end
            else
                if i+2 == 1 then
                    ModsMenu.options[#ModsMenu.options + 1] = { title = Lang.Stock, event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, id = i, mod = data.mod } }
                else
                    ModsMenu.options[#ModsMenu.options + 1] = { title = GetLabelText(GetModTextLabel(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.mod), tonumber(i))), event = 'mt-mechanic:client:ApplyTemporaryMod', args = { lastMenu = data.lastMenu, Header = data.Header, id = i, mod = data.mod } }
                end
            end
        end
        lib.registerContext(ModsMenu)
        lib.showContext('preview_actual_mod_menu')
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyTemporaryMod', function(data)
    if data.mod == 'paint' then
        if data.Type2 == 'RGB' then
            local input = lib.inputDialog(Lang.RGBColorInput, {
                {type = 'color', format = 'rgb', label = Lang.RGBColorInput},
            })
            if input ~= nil then
                local r, g, b = string.match(input[1], "rgb%((%d+), (%d+), (%d+)%)")
                if data.Type == 'Primary' then
                    SetVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(r), tonumber(g), tonumber(b))
                elseif data.Type == 'Secundary' then
                    SetVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(r), tonumber(g), tonumber(b))
                end
            end
        else
            PaintsMenu = { id = 'preview_actual_paint_menu', title = data.Header, menu = data.lastMenu, options = {} }
            local PColor, SColor = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false))
            local PearlescentColour, WheelColour = GetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false))
            for k, v in pairs(Config.Colours[data.Type2]) do
                if data.Type == 'Primary' and PColor == v.Number or data.Type == 'Secundary' and SColor == v.Number or data.Type == 'WheelsColour' and WheelColour == v.Number or data.Type == 'DashboardColour' and GetVehicleDashboardColor(GetVehiclePedIsIn(PlayerPedId(), false)) == v.Number or data.Type == 'InteriorColour' and GetVehicleInteriorColor(GetVehiclePedIsIn(PlayerPedId(), false)) == v.Number or data.Type == 'Pearlescent' and PearlescentColour == v.Number then
                    PaintsMenu.options[#PaintsMenu.options + 1] = { title = v.Label, description = Lang.Applied, disabled = true }
                else
                    PaintsMenu.options[#PaintsMenu.options + 1] = { title = v.Label, event = 'mt-mechanic:client:ApplyTemporaryColour', args = { Number = v.Number, mod = 'paint', lastMenu = data.lastMenu, Header = data.Header, Type = data.Type, Type2 = data.Type2 } }
                end
            end
            lib.registerContext(PaintsMenu)
            lib.showContext('preview_actual_paint_menu')
        end
    else
        SetVehicleMod(GetVehiclePedIsIn(PlayerPedId(), false), data.mod, data.id, false)
        if data.mod == 48 then
            SetVehicleLivery(GetVehiclePedIsIn(PlayerPedId(), false), data.id)
        end
        TriggerEvent('mt-mechanic:client:OpenModsMenu', data)
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyTemporaryColour', function(data)
    local PColor, SColor = GetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false))
    if data.Type == 'Primary' then
        ClearVehicleCustomPrimaryColour(GetVehiclePedIsIn(PlayerPedId(), false))
        SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.Number), SColor)
    elseif data.Type == 'Secundary' then
        ClearVehicleCustomSecondaryColour(GetVehiclePedIsIn(PlayerPedId(), false))
        SetVehicleColours(GetVehiclePedIsIn(PlayerPedId(), false), PColor, tonumber(data.Number))
    elseif data.Type == 'Pearlescent' then
        SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.Number), 0)
    elseif data.Type == 'WheelsColour' then
        SetVehicleExtraColours(GetVehiclePedIsIn(PlayerPedId(), false), 0, tonumber(data.Number))
    elseif data.Type == 'DashboardColour' then
        SetVehicleDashboardColor(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.Number))
    elseif data.Type == 'InteriorColour' then
        SetVehicleInteriorColor(GetVehiclePedIsIn(PlayerPedId(), false), tonumber(data.Number))
    end
    TriggerEvent('mt-mechanic:client:ApplyTemporaryMod', data)
end)