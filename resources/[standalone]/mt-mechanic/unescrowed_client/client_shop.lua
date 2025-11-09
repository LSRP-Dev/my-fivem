local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:OpenShop', function(data)
    registeredMenu = {
        id = 'shop_menu',
        title = Lang.ShopHeader,
        options = {}
    }
    for k, v in pairs(Config.ShopItems) do
        if Config.QBInventoryName == 'ox_inventory' then
            registeredMenu.options[#registeredMenu.options + 1] = { icon = tostring(Config.ImagesDirectory..itemNames[v.ItemName].name..'.png'), title = itemNames[v.ItemName].label, description = itemNames[v.ItemName].description .. ' \n ' .. Lang.Price .. v.ItemPrice .. '$.', event = 'mt-mechanic:client:BuyShopItem', args = { Item = v.ItemName, Price = v.ItemPrice }, }
        else
            registeredMenu.options[#registeredMenu.options + 1] = { icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items[v.ItemName].name..'.png'), title = QBCore.Shared.Items[v.ItemName].label, description = QBCore.Shared.Items[v.ItemName].description .. ' \n ' .. Lang.Price .. v.ItemPrice .. '$.', event = 'mt-mechanic:client:BuyShopItem', args = { Item = v.ItemName, Price = v.ItemPrice }, }
        end
    end
    lib.registerContext(registeredMenu)
    lib.showContext('shop_menu')
end)

RegisterNetEvent('mt-mechanic:client:BuyShopItem', function(data)
    local AmountDialog = lib.inputDialog(Lang.BuyItemsInputHeader, {
        {type = 'number', label = Lang.ItemsAmountText, required = true},
        {
            label = Lang.MoneyTypeText,
            type = 'select',
            required = true,
            options = {
                { value = "cash", label = "Cash" },
                { value = "bank", label = "Bank" },
                { value = "society", label = "Society" },
            },
        }
    })

    if AmountDialog ~= nil then
        TriggerServerEvent('mt-mechanic:server:BuyShopItem', data.Item, data.Price, AmountDialog[1], AmountDialog[2])
    end
end)
