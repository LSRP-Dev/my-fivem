if Shared.Framework == "esx" then 
    local success, result = pcall(function()
        return exports[Shared.FrameworkNames.esx]:getSharedObject()
    end)
    if success then
        ESX = result
    else
        print("^1[qt-crafting-v2] ERROR: Failed to load ESX framework^0")
    end
elseif Shared.Framework == "qb" then 
    local success, result = pcall(function()
        return exports[Shared.FrameworkNames.qb]:GetCoreObject()
    end)
    if success then
        QBCore = result
    else
        print("^1[qt-crafting-v2] ERROR: Failed to load QB/QBX framework. Make sure qbx_core is started.^0")
    end
end

