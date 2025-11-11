local function makePlaceholder()
    local function notReady(method)
        return function()
            error(('[JPR Casino] Attempted to use QBX.Functions.%s before qbx_core finished starting. Ensure qbx_core starts before jpr-casinosystem.'):format(method))
        end
    end

    local placeholderFunctions = setmetatable({}, {
        __index = function(_, method)
            return notReady(method)
        end
    })

    return { Functions = placeholderFunctions }
end

if not _G.QBX or not _G.QBX.Functions then
    _G.QBX = makePlaceholder()
end
if not _G.QBCore or not _G.QBCore.Functions then
    _G.QBCore = makePlaceholder()
end

QBX = _G.QBX
QBCore = _G.QBCore

local Core
local maxAttempts = 600 -- wait up to ~60 seconds
local attempt = 0

if IsDuplicityVersion() then
    while attempt < maxAttempts do
        attempt += 1
        local success, coreObj = pcall(function()
            if GetResourceState('qbx_core') == 'started' then
                if exports['qbx_core'] and exports['qbx_core'].GetCoreObject then
                    return exports['qbx_core']:GetCoreObject()
                elseif exports['qb-core'] and exports['qb-core'].GetCoreObject then
                    return exports['qb-core']:GetCoreObject()
                end
            end
            return nil
        end)

        if success and coreObj and coreObj.Functions then
            Core = coreObj
            _G.QBX = coreObj
            _G.QBCore = coreObj
            QBX = coreObj
            QBCore = coreObj
            print('^2[JPR Casino] Core export acquired from qbx_core^0')
            break
        end

        Wait(100)
    end

    if not Core then
        error('[JPR Casino] Failed to acquire core export from qbx_core / qb-core before timeout. Check resource order.')
    end
else
    while attempt < maxAttempts do
        attempt += 1
        if _G.QBX and _G.QBX.Functions and _G.QBX.Functions.CreateCallback ~= nil then
            Core = _G.QBX
            break
        end
        if _G.QBCore and _G.QBCore.Functions and _G.QBCore.Functions.CreateCallback ~= nil then
            Core = _G.QBCore
            break
        end
        Wait(100)
    end

    if not Core then
        error('[JPR Casino] Client failed to detect QBX/QBCore within timeout; ensure qbx_core loads before jpr-casinosystem.')
    end
end

return Core
