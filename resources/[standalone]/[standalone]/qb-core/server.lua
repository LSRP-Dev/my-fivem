CreateThread(function()
    -- Wait until qbx_core has fully started
    while GetResourceState('qbx_core') ~= 'started' do
        Wait(200)
    end

    local QBCore
    local success, err = pcall(function()
        QBCore = exports['qbx_core']:GetCoreObject()
    end)

    if not success or not QBCore then
        print('^1[qb-core bridge]^7 ERROR: Failed to fetch Qbox core -> ' .. tostring(err))
        return
    end

    -- === EXPORTS FOR LEGACY QBCORE SCRIPTS ===
    exports('GetCoreObject', function()
        return QBCore
    end)

    exports('GetPlayers', function()
        return QBCore.Functions.GetPlayers()
    end)

    exports('GetQBPlayers', function()
        return QBCore.Functions.GetQBPlayers()
    end)

    exports('GetPlayer', function(source)
        return QBCore.Functions.GetPlayer(source)
    end)

    exports('GetPlayerByCitizenId', function(citizenId)
        return QBCore.Functions.GetPlayerByCitizenId(citizenId)
    end)

    exports('GetPlayerByPhone', function(phone)
        return QBCore.Functions.GetPlayerByPhone(phone)
    end)

    -- === EXTRA SAFETY: RE-EXPORT TO QBOX NAMESPACE ===
    AddEventHandler('onResourceStart', function(resName)
        if resName == 'qbx_core' then
            Wait(500)
            QBCore = exports['qbx_core']:GetCoreObject()
            print('^2[qb-core bridge]^7 rebound QBCore after qbx_core restart.')
        end
    end)

    print('^2[qb-core bridge]^7 initialized — legacy QBCore exports are now active.')
end)
