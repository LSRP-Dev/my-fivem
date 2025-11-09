local QBCore = exports[Config.QBCoreName]:GetCoreObject()
local NitrousActivated = false local VehicleNitrous = {} local IsCooldown = false local Fxs = {}

local function trim(value)
	if not value then return nil end
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('mt-mechanic:GetNosLoadedVehs', function(vehs)
        VehicleNitrous = vehs
    end)
end)

local nosupdated = false

CreateThread(function()
    while true do
        local IsInVehicle = IsPedInAnyVehicle(PlayerPedId())
        local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
        if IsInVehicle then
            local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
            if VehicleNitrous[Plate] ~= nil then
                if VehicleNitrous[Plate].hasnitro then
                    if IsControlJustPressed(0, Config.NitrousKey) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() and IsCooldown == false then
                        SetVehicleEnginePowerMultiplier(CurrentVehicle, Config.NitrousBoost)
                        SetVehicleEngineTorqueMultiplier(CurrentVehicle, Config.NitrousBoost)
                        SetEntityMaxSpeed(CurrentVehicle, Config.NitrousMxSpeed)
                        NitrousActivated = true
                        IsCooldown = true

                        CreateThread(function()
                            while NitrousActivated do
                                if VehicleNitrous[Plate].level - 1 ~= 0 then
                                    TriggerServerEvent('mt-mechanic:server:UpdateNitroLevel', Plate, (VehicleNitrous[Plate].level - Config.UpdateNitrousLevel))
                                    TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, true)
                                else
                                    TriggerServerEvent('mt-mechanic:server:UnloadNitrous', Plate)
                                    NitrousActivated = false
                                    SetVehicleBoostActive(CurrentVehicle, 0)
                                    SetVehicleEnginePowerMultiplier(CurrentVehicle, LastEngineMultiplier)
                                    SetVehicleEngineTorqueMultiplier(CurrentVehicle, 1.0)
                                    StopScreenEffect("RaceTurbo")
                                    for index,_ in pairs(Fxs) do
                                        StopParticleFxLooped(Fxs[index], 1)
                                        TriggerServerEvent('mt-mechanic:server:StopSync', trim(GetVehicleNumberPlateText(CurrentVehicle)))
                                        Fxs[index] = nil
                                    end
                                end
                                Wait(100)
                            end
                        end)
                    end

                    if IsControlJustReleased(0, Config.NitrousKey) and GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
                        if NitrousActivated then
                            local veh = GetVehiclePedIsIn(PlayerPedId())
                            SetVehicleBoostActive(veh, 0)
                            SetVehicleEnginePowerMultiplier(veh, LastEngineMultiplier)
                            SetVehicleEngineTorqueMultiplier(veh, 1.0)
                            for index,_ in pairs(Fxs) do
                                StopParticleFxLooped(Fxs[index], 1)
                                TriggerServerEvent('mt-mechanic:server:StopSync', trim(GetVehicleNumberPlateText(veh)))
                                Fxs[index] = nil
                            end
                            StopScreenEffect("RaceTurbo")
                            TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
                            NitrousActivated = false
                            Wait(Config.NitoursCooldown)
                            IsCooldown = false
                        end
                    end
                end
            else
                if not nosupdated then
                    TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
                    nosupdated = true
                end
                StopScreenEffect("RaceTurbo")
            end
        else
            if nosupdated then
                nosupdated = false
            end
            StopScreenEffect("RaceTurbo")
            Wait(1500)
        end
        Wait(3)
    end
end)

p_flame_location = { "exhaust", "exhaust_2", "exhaust_3", "exhaust_4", "exhaust_5", "exhaust_6", "exhaust_7", "exhaust_8", "exhaust_9", "exhaust_10", "exhaust_11", "exhaust_12", "exhaust_13", "exhaust_14", "exhaust_15", "exhaust_16" }
ParticleDict = "veh_xs_vehicle_mods"
ParticleFx = "veh_nitrous"
ParticleSize = Config.NitrousParticlesSize

CreateThread(function()
    while true do
        if NitrousActivated then
            local veh = GetVehiclePedIsIn(PlayerPedId())
            if veh ~= 0 then
                TriggerServerEvent('mt-mechanic:server:SyncFlames', VehToNet(veh))
                SetVehicleBoostActive(veh, 1)

                for _,bones in pairs(p_flame_location) do
                    if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                        if Fxs[bones] == nil then
                            RequestNamedPtfxAsset(ParticleDict)
                            while not HasNamedPtfxAssetLoaded(ParticleDict) do
                                Wait(0)
                            end
                            SetPtfxAssetNextCall(ParticleDict)
                            UseParticleFxAssetNextCall(ParticleDict)
                            Fxs[bones] = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.02, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                        end
                    end
                end
            end
        end
        Wait(0)
    end
end)

local NOSPFX = {}

RegisterNetEvent('mt-mechanic:client:SyncFlames', function(netid, nosid)
    local veh = NetToVeh(netid)
    if veh ~= 0 then
        local myid = GetPlayerServerId(PlayerId())
        if NOSPFX[trim(GetVehicleNumberPlateText(veh))] == nil then
            NOSPFX[trim(GetVehicleNumberPlateText(veh))] = {}
        end
        if myid ~= nosid then
            for _,bones in pairs(p_flame_location) do
                if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] == nil then
                    NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones] = {}
                end
                if GetEntityBoneIndexByName(veh, bones) ~= -1 then
                    if NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx == nil then
                        RequestNamedPtfxAsset(ParticleDict)
                        while not HasNamedPtfxAssetLoaded(ParticleDict) do
                            Wait(0)
                        end
                        SetPtfxAssetNextCall(ParticleDict)
                        UseParticleFxAssetNextCall(ParticleDict)
                        NOSPFX[trim(GetVehicleNumberPlateText(veh))][bones].pfx = StartParticleFxLoopedOnEntityBone(ParticleFx, veh, 0.0, -0.05, 0.0, 0.0, 0.0, 0.0, GetEntityBoneIndexByName(veh, bones), ParticleSize, 0.0, 0.0, 0.0)
                    end
                end
            end
        end
    end
end)

RegisterNetEvent('mt-mechanic:client:StopSync', function(plate)
    for k, v in pairs(NOSPFX[plate]) do
        StopParticleFxLooped(v.pfx, 1)
        NOSPFX[plate][k].pfx = nil
    end
end)

RegisterNetEvent('mt-mechanic:client:UpdateNitroLevel', function(Plate, level)
    VehicleNitrous[Plate].level = level
end)

RegisterNetEvent('mt-mechanic:client:LoadNitrous', function(Plate)
    VehicleNitrous[Plate] = {
        hasnitro = true,
        level = 100,
    }
    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        TriggerEvent('hud:client:UpdateNitrous', VehicleNitrous[Plate].hasnitro,  VehicleNitrous[Plate].level, false)
    end
end)

RegisterNetEvent('mt-mechanic:client:UnloadNitrous', function(Plate)
    VehicleNitrous[Plate] = nil
    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
    local CPlate = trim(GetVehicleNumberPlateText(CurrentVehicle))
    if CPlate == Plate then
        NitrousActivated = false
        IsCooldown = false
        TriggerEvent('hud:client:UpdateNitrous', false, nil, false)
        if GetPedInVehicleSeat(CurrentVehicle, -1) == PlayerPedId() then
            TriggerServerEvent('mt-mechanic:server:AddItem', 'mechanic_nitrous_empty', 1)
        end
    end
end)

RegisterNetEvent('mt-mechanic:client:ApplyNOS', function(data)
    if IsPedInAnyVehicle(PlayerPedId()) then
        if GetIsVehicleEngineRunning(GetVehiclePedIsIn(PlayerPedId(), false)) == false then
            if IsToggleModOn(GetVehiclePedIsIn(PlayerPedId(), false), 18) then 
                playAnim('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', Config.Times['NitrousTime'], 16)
                QBCore.Functions.Progressbar('name_here', Lang.InstallingNitrous, Config.Times['NitrousTime'], false, true, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, }, {}, {}, {}, function()
                    ClearPedTasks(PlayerPedId())
                    TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_nitrous', 1, nil)
                    local CurrentVehicle = GetVehiclePedIsIn(PlayerPedId())
                    local Plate = trim(GetVehicleNumberPlateText(CurrentVehicle))
                    TriggerServerEvent('mt-mechanic:server:LoadNitrous', Plate)
                    local LogData = {
                        User = GetPlayerName(PlayerId()),
                        Action = Logs.Translations.InstalledNitrous,
                        Plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId(), false)),
                    }
                    TriggerServerEvent('mt-mechanic:server:CreateLog', LogData)
                end, function()
                    ClearPedTasks(PlayerPedId())
                end)
            else
                QBCore.Functions.Notify(Lang.YouNeedTurbo, 'error', 7500)
            end
        else
            QBCore.Functions.Notify(Lang.NeedStopVehicle, 'error', 7500)
        end
    else
        QBCore.Functions.Notify(Lang.NotInVehicle, 'error', 7500)
    end
end)