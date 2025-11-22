-- PATCHED: client/framework/qb/main.lua
-- This file should replace: resources/[standalone]/illenium-appearance/client/framework/qb/main.lua

if not Framework.QBCore() then return end

local client = client

-- Try to use QBX Bridge first, then fall back to qb-core
local QBCore = nil
local usingBridge = false

-- Check for bridge immediately (it should be ready since it loads before this)
if GetResourceState('illenium-qbx-bridge') == 'started' then
    -- Try to access bridge exports
    local success, bridgeIsReady = pcall(function()
        return exports['illenium-qbx-bridge']:IsReady()
    end)
    
    if success and bridgeIsReady then
        local success2, qbxCore = pcall(function()
            return exports['illenium-qbx-bridge']:GetQBXCore()
        end)
        
        if success2 and qbxCore then
            -- Create QB Core compatible object using bridge
            QBCore = {
                Functions = {
                    GetPlayerData = function()
                        local success3, playerData = pcall(function()
                            return exports['illenium-qbx-bridge']:GetPlayerData()
                        end)
                        return success3 and playerData or nil
                    end
                },
                Shared = qbxCore.Shared or {}
            }
            usingBridge = true
            print("^2[illenium-appearance] Using QBX Bridge for QBX Core compatibility^7")
        end
    end
end

-- Fallback to regular qb-core if bridge not available
if not QBCore then
    if GetResourceState('qb-core') == 'started' then
        QBCore = exports["qb-core"]:GetCoreObject()
        print("^2[illenium-appearance] Using standard qb-core^7")
    else
        print("^1[illenium-appearance] No compatible framework found!^7")
        return
    end
end

local PlayerData = QBCore.Functions.GetPlayerData() or {}

local function getRankInputValues(rankList)
    local rankValues = {}
    for k, v in pairs(rankList) do
        rankValues[#rankValues + 1] = {
            label = v.name,
            value = k
        }
    end
    return rankValues
end

local function setClientParams()
    if PlayerData and PlayerData.job then
        client.job = PlayerData.job
    end
    if PlayerData and PlayerData.gang then
        client.gang = PlayerData.gang
    end
    if PlayerData and PlayerData.citizenid then
        client.citizenid = PlayerData.citizenid
    end
end

function Framework.GetPlayerGender()
    if PlayerData and PlayerData.charinfo and PlayerData.charinfo.gender == 1 then
        return "Female"
    end
    return "Male"
end

function Framework.UpdatePlayerData()
    if QBCore and QBCore.Functions then
        PlayerData = QBCore.Functions.GetPlayerData() or {}
    end
    setClientParams()
end

function Framework.HasTracker()
    if PlayerData and PlayerData.metadata then
        return PlayerData.metadata["tracker"] or false
    end
    return false
end

function Framework.CheckPlayerMeta()
    if PlayerData and PlayerData.metadata then
        return PlayerData.metadata["isdead"] or PlayerData.metadata["inlaststand"] or PlayerData.metadata["ishandcuffed"]
    end
    return false
end

function Framework.IsPlayerAllowed(citizenid)
    if PlayerData and PlayerData.citizenid then
        return citizenid == PlayerData.citizenid
    end
    return false
end

function Framework.GetRankInputValues(type)
    if not QBCore or not QBCore.Shared then return {} end
    
    local grades = {}
    if client.job and QBCore.Shared.Jobs and QBCore.Shared.Jobs[client.job.name] then
        grades = QBCore.Shared.Jobs[client.job.name].grades
    end
    
    if type == "gang" and client.gang and QBCore.Shared.Gangs and QBCore.Shared.Gangs[client.gang.name] then
        grades = QBCore.Shared.Gangs[client.gang.name].grades
    end
    
    return getRankInputValues(grades)
end

function Framework.GetJobGrade()
    if client.job and client.job.grade then
        return client.job.grade.level
    end
    return 0
end

function Framework.GetGangGrade()
    if client.gang and client.gang.grade then
        return client.gang.grade.level
    end
    return 0
end

RegisterNetEvent("QBCore:Client:OnJobUpdate", function(JobInfo)
    if PlayerData then
        PlayerData.job = JobInfo
    end
    client.job = JobInfo
    ResetBlips()
end)

RegisterNetEvent("QBCore:Client:OnGangUpdate", function(GangInfo)
    if PlayerData then
        PlayerData.gang = GangInfo
    end
    client.gang = GangInfo
    ResetBlips()
end)

RegisterNetEvent("QBCore:Client:SetDuty", function(duty)
    if PlayerData and PlayerData.job then
        PlayerData.job.onduty = duty
        client.job = PlayerData.job
    end
end)

RegisterNetEvent("QBCore:Client:OnPlayerLoaded", function()
    InitAppearance()
end)

RegisterNetEvent("qb-clothes:client:CreateFirstCharacter", function()
    if QBCore and QBCore.Functions then
        local pd = QBCore.Functions.GetPlayerData()
        if pd then
            PlayerData = pd
            setClientParams()
            InitializeCharacter(Framework.GetGender(true), function()
                TriggerEvent('qbx_core:client:appearanceCompleted')
            end, function()
                TriggerEvent('qbx_core:client:appearanceCancelled')
            end)
        end
    end
end)

function Framework.CachePed()
    return nil
end

function Framework.RestorePlayerArmour()
    Framework.UpdatePlayerData()
    if PlayerData and PlayerData.metadata then
        Wait(1000)
        SetPedArmour(cache.ped, PlayerData.metadata["armor"] or 0)
    end
end
