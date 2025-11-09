local QBCore = exports[Config.QBCoreName]:GetCoreObject()

-- Check Repair Items

lib.callback.register('mt-mechanic:server:CheckRepairItems', function(source, items, multiplier)
    for _, v in pairs(items) do
        if Config.QBInventoryName == 'ox_inventory' then
            if multiplier <= 0 then
                if exports.ox_inventory:GetItem(source, v.ItemName, nil, true) >= v.NeededAmount and exports.ox_inventory:GetItem(source, 'mechanic_tools', nil, true) then    
                    return(true)
                else
                    return(false)
                end
            else
                if exports.ox_inventory:GetItem(source, v.ItemName, nil, true) >= v.NeededAmount*multiplier and exports.ox_inventory:GetItem(source, 'mechanic_tools', nil, true) then    
                    return(true)
                else
                    return(false)
                end
            end
        else
            if multiplier <= 0 then
                if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.ItemName) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.ItemName) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.ItemName).amount >= v.NeededAmount then    
                    return(true)
                else
                    return(false)
                end
            else
                if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.ItemName) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.ItemName).amount >= v.NeededAmount*multiplier then    
                    return(true)
                else
                    return(false)
                end
            end
        end
    end
end)

RegisterNetEvent('mt-mechanic:server:RemoveItemRepair', function(items,  multiplier)
    for _, v in pairs(items) do
        if multiplier <= 0 then
            QBCore.Functions.GetPlayer(source).Functions.RemoveItem(v.ItemName, v.NeededAmount)
            if Config.QBInventoryName ~= 'ox_inventory' then
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.ItemName], "remove", v.NeededAmount)
            end
        else
            QBCore.Functions.GetPlayer(source).Functions.RemoveItem(v.ItemName, v.NeededAmount*multiplier)
            if Config.QBInventoryName ~= 'ox_inventory' then
                TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.ItemName], "remove", v.NeededAmount)
            end
        end
    end
end)

-- End Check Repair Items