local QBCore = nil

if GetResourceState('qbx_core') == 'started' then
    QBCore = QBX           -- ✅ Global variable (Qbox)
    print('^2[JPR Casino] Linked to QBOX Core via global QBX^0')
elseif GetResourceState('qb-core') == 'started' then
    QBCore = exports['qb-core']:GetCoreObject()
    print('^2[JPR Casino] Linked to QB-Core^0')
else
    print('^1[JPR Casino] No core framework detected (qbx_core or qb-core)^0')
    QBCore = {}
end

return QBCore
