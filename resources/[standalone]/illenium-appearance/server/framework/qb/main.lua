if not Framework.QBCore() then return end

-- Try to use QBX Bridge first, then fall back to qb-core
local QBCore = nil
local usingBridge = false

if GetResourceState('illenium-qbx-bridge') == 'started' then
    -- Use the bridge for QBX Core compatibility
    local bridge = exports['illenium-qbx-bridge']
    if bridge and bridge.IsReady() then
        local qbxCore = bridge.GetQBXCore()
        if qbxCore then
            -- Create QB Core compatible object using bridge
            QBCore = {
                Functions = {
                    GetPlayer = function(src)
                        return bridge.GetPlayer(src)
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

function Framework.GetPlayerID(src)
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        return Player.PlayerData.citizenid
    end
end

function Framework.HasMoney(src, type, money)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player.PlayerData.money[type] >= money
end

function Framework.RemoveMoney(src, type, money)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player.Functions.RemoveMoney(type, money)
end

function Framework.GetJob(src)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player.PlayerData.job
end

function Framework.GetGang(src)
    local Player = QBCore.Functions.GetPlayer(src)
    return Player.PlayerData.gang
end

function Framework.SaveAppearance(appearance, citizenID)
    Database.PlayerSkins.UpdateActiveField(citizenID, 0)
    Database.PlayerSkins.DeleteByModel(citizenID, appearance.model)
    Database.PlayerSkins.Add(citizenID, appearance.model, json.encode(appearance), 1)
end

function Framework.GetAppearance(citizenID, model)
    local result = Database.PlayerSkins.GetByCitizenID(citizenID, model)
    if result then
        return json.decode(result)
    end
end
