-- Framework bridge for Qbox / QBCore compatibility

if GetResourceState('qbx_core') == 'started' then
    Framework = exports['qbx_core']:GetCoreObject()
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
else
    print("^1[JPR Phone] Could not find any active core framework (qbx_core or qb-core).")
    Framework = nil
end

return Framework
