local QBCore = nil

if GetResourceState('qbx_core') == 'started' then
    QBCore = exports['qbx_core']:GetCore()
    print('[JPR Casino] Linked to QBOX Core ✅')
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    print('[JPR Casino] Linked to QB-Core ✅')
else
    print('[JPR Casino] ⚠️ No core framework detected (qbx_core / qb-core)')
    QBCore = {}
end

return QBCore
