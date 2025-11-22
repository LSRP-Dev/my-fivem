-- PATCHED: shared/framework/framework.lua
-- This file should replace: resources/[standalone]/illenium-appearance/shared/framework/framework.lua

Framework = {}

function Framework.ESX()
    return GetResourceState("es_extended") ~= "missing"
end

function Framework.QBCore()
    -- PATCHED: Detect both qb-core and qbx_core
    return GetResourceState("qb-core") ~= "missing" or GetResourceState("qbx_core") ~= "missing"
end

function Framework.Ox()
    return GetResourceState("ox_core") ~= "missing"
end
