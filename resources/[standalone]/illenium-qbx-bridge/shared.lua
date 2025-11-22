-- Shared bridge configuration
Bridge = {}

-- Detect which core is available
function Bridge.GetCoreType()
    if GetResourceState('qbx_core') == 'started' then
        return 'qbx'
    elseif GetResourceState('qb-core') == 'started' then
        return 'qb'
    end
    return nil
end

-- Check if bridge is needed
function Bridge.IsBridgeNeeded()
    return Bridge.GetCoreType() == 'qbx'
end
