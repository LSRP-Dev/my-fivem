local Core = nil

-- Function to initialize core from qbx_core
local function initQBXCore()
    if GetResourceState('qbx_core') == 'started' then
        local success, coreObj = pcall(function()
            return exports['qbx_core']:GetCoreObject()
        end)
        
        if success and coreObj then
            Core = coreObj
            QBX = coreObj  -- Set global QBX
            _G.QBCore = coreObj  -- ✅ backward-compatibility alias (explicit global)
            QBCore = coreObj     -- Also set without _G for compatibility
            print('^2[JPR Casino] Linked to QBOX Core via exports^0')
            return true
        else
            print('^3[JPR Casino] Warning: qbx_core export not ready yet, will retry...^0')
            return false
        end
    end
    return false
end

-- Function to initialize core from qb-core
local function initQBCore()
    if GetResourceState('qb-core') == 'started' then
        local success, coreObj = pcall(function()
            return exports['qb-core']:GetCoreObject()
        end)
        
        if success and coreObj then
            Core = coreObj
            _G.QBCore = coreObj
            QBCore = coreObj
            print('^2[JPR Casino] Linked to QB-Core^0')
            return true
        end
    end
    return false
end

-- Try to initialize immediately
if not initQBXCore() and not initQBCore() then
    -- If initialization failed, set up retry mechanism
    if GetResourceState('qbx_core') == 'starting' or GetResourceState('qbx_core') == 'started' then
        CreateThread(function()
            local attempts = 0
            local maxAttempts = 20  -- Try for up to 10 seconds (20 * 500ms)
            
            while attempts < maxAttempts do
                Wait(500)
                attempts = attempts + 1
                
                if initQBXCore() then
                    return  -- Successfully initialized
                end
            end
            
            -- If we still haven't initialized, set empty tables to prevent nil errors
            if not Core then
                print('^1[JPR Casino] ERROR: Failed to initialize QBOX Core after retries^0')
                Core, QBX, _G.QBCore, QBCore = {}, {}, {}, {}
            end
        end)
    else
        print('^1[JPR Casino] No core framework detected (qbx_core or qb-core)^0')
        Core, QBX, _G.QBCore, QBCore = {}, {}, {}, {}
    end
end

return Core
