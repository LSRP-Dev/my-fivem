--[[
    Chris Locks System
    Author: Chris Hepburn
    Description: Advanced player and business lock system for FiveM (Qbox / QB / OX compatible)
    Version: 1.0.0
]]

local Framework = {}

local state = {
    qbox = GetResourceState('qbx_core') == 'started',
    qb = GetResourceState('qb-core') == 'started',
}

if state.qbox then
    Framework.core = exports.qbx_core
    print('[chris_locks] Linked to QBOX Core via exports.qbx_core')
elseif state.qb then
    Framework.core = exports['qb-core']:GetCoreObject()
    print('[chris_locks] Linked to QB-Core via exports["qb-core"]:GetCoreObject()')
else
    Framework.core = nil
    print('[chris_locks] Running in standalone mode (no framework detected)')
end

local function getPlayerObject(src)
    if state.qbox then
        return exports.qbx_core:GetPlayer(src)
    elseif state.qb and Framework.core then
        return Framework.core.Functions.GetPlayer(src)
    end
    return nil
end

function Framework.getPlayer(src)
    return getPlayerObject(src)
end

function Framework.getIdentifier(src)
    local player = getPlayerObject(src)
    if player and player.PlayerData then
        return player.PlayerData.citizenid or player.PlayerData.license
    end
    for _, v in pairs(GetPlayerIdentifiers(src)) do
        if v:find('license:') then return v end
    end
    return nil
end

function Framework.hasItem(src, item)
    if not item or item == '' then return false end
    if GetResourceState('ox_inventory') == 'started' then
        return exports.ox_inventory:Search(src, 'count', item) > 0
    end
    local player = getPlayerObject(src)
    if player and player.Functions and player.Functions.GetItemByName then
        return player.Functions.GetItemByName(item) ~= nil
    end
    return false
end

function Framework.hasJob(src, allowed)
    local list = type(allowed) == 'table' and allowed or { allowed }
    if not list or #list == 0 then return false end
    local player = getPlayerObject(src)
    if not player or not player.PlayerData then return false end
    local job = player.PlayerData.job and player.PlayerData.job.name
    if not job then return false end
    job = job:lower()
    for _, entry in ipairs(list) do
        if job == entry:lower() then return true end
    end
    return false
end

function Framework.hasGang(src, allowed)
    local list = type(allowed) == 'table' and allowed or { allowed }
    if not list or #list == 0 then return false end
    local player = getPlayerObject(src)
    if not player or not player.PlayerData then return false end
    local gang = player.PlayerData.gang and player.PlayerData.gang.name
    if not gang then return false end
    gang = gang:lower()
    for _, entry in ipairs(list) do
        if gang == entry:lower() then return true end
    end
    return false
end

function Framework.setDoorStateAll(doorId, locked)
    if not doorId then return end
    if GetResourceState('ox_doorlock') == 'started' then
        TriggerClientEvent('ox_doorlock:client:setState', -1, doorId, locked)
    elseif GetResourceState('qb-doorlock') == 'started' then
        TriggerEvent('qb-doorlock:server:updateState', doorId, locked, true)
    elseif state.qbox and Framework.core then
        TriggerClientEvent('qbx_core:client:setDoorState', -1, doorId, locked)
    end
end

return Framework
