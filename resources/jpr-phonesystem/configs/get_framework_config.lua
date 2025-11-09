-- Framework detection bridge for Qbox and QB-Core

local Framework = nil

if GetResourceState('qbx_core') == 'started' then
    -- Use Qbox's global core (does not need export)
    Framework = exports['qbx_core'] and exports['qbx_core']:GetCoreObject and exports['qbx_core']:GetCoreObject() or QBX
elseif GetResourceState('qb-core') == 'started' then
    Framework = exports['qb-core']:GetCoreObject()
else
    print('^1[JPR Phone] No valid framework found (qbx_core or qb-core). Using fallback mode.^0')
    Framework = {}
end

return Framework
