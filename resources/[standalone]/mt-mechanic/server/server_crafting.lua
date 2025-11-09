local QBCore = exports[Config.QBCoreName]:GetCoreObject()

-- Crafting Events

lib.callback.register('mt-mechanic:server:CheckCraftingItems', function(source, items)
    local src = source local hasItems = false local number = 0
    for k, v in pairs(items) do
        if Config.QBInventoryName == 'ox_inventory' then
            if exports.ox_inventory:GetItem(source, v.Name, nil, true) >= v.Quantity then
                number = number + 1
                if number == #items then
                    return(true)
                end
            else
                return(false)
            end
        else
            if QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.Name) and QBCore.Functions.GetPlayer(source).Functions.GetItemByName(v.Name).amount >= v.Quantity then
                number = number + 1
                if number == #items then
                    return(true)
                end
            else
                return(false)
            end
        end
    end
end)

RegisterNetEvent('mt-mechanic:server:RemoveCraftItems', function(item)
    for k, v in pairs(Config.Crafting[item].NeededItems) do
        QBCore.Functions.GetPlayer(source).Functions.RemoveItem(v.Name, v.Quantity)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.Name], "remove", v.Quantity)
    end
end)

RegisterNetEvent('mt-mechanic:server:CraftItems', function(item)
    if QBCore.Functions.GetPlayer(source).Functions.AddItem(Config.Crafting[item].ItemName, 1) then
        for k, v in pairs(Config.Crafting[item].NeededItems) do
            QBCore.Functions.GetPlayer(source).Functions.RemoveItem(v.Name, v.Quantity)
            TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[v.Name], "remove", v.Quantity)
        end
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.Crafting[item].ItemName], "add", 1)
    end
end)

RegisterNetEvent('mt-mechanic:server:GivePaintSpray', function(Number, Type, Type2, Name)
    local info = {}
    info.paintNumber = Number info.paintType = Type info.paintType2 = Type2 info.paintName = Name

    if QBCore.Functions.GetPlayer(source).Functions.AddItem('mechanic_paint_spray', 1, nil, info) then
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mechanic_paint_spray'], "add", 1)
    end
end)

-- End Craft Events