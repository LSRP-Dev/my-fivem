local QBCore = exports[Config.QBCoreName]:GetCoreObject()

local function CraftItems(item)
    local playername = GetPlayerName(PlayerId()) local playerid = GetPlayerServerId(PlayerPedId())
    QBCore.Functions.Progressbar('crafting', Lang.Crafting, Config.Times['CraftingTime'], false, false, { disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true }, { animDict = "mini@repair", anim = "fixing_a_ped" }, {}, {}, function()
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('mt-mechanic:server:CraftItems', item)
    end, function()
        ClearPedTasks(PlayerPedId())
    end)
end

RegisterNetEvent('mt-mechanic:client:OpenCraftingMenu', function(data)
    registeredMenu = {
        id = 'crafting_menu',
        title = Lang.CraftingMenuHeader,
        options = {}
    }
    for k, v in pairs(Config.Crafting) do
        local text = ""
        local icon = ""
        for k, v in pairs(Config.Crafting[k].NeededItems) do
            if Config.QBInventoryName == 'ox_inventory' then
                text = text .. "• " .. itemNames[v.Name].label .. ": " .. v.Quantity .. "x \n"
            else
                text = text .. "• " .. QBCore.Shared.Items[v.Name].label .. ": " .. v.Quantity .. "x \n"
            end
        end
        if Config.QBInventoryName == 'ox_inventory' then
            registeredMenu.options[#registeredMenu.options + 1] = { icon = tostring(Config.ImagesDirectory..itemNames[v.ItemName].name..'.png'), title = itemNames[v.ItemName].label, description = text, event = 'mt-mechanic:client:CraftItems', args = { type = k } }
        else
            registeredMenu.options[#registeredMenu.options + 1] = { icon = tostring(Config.ImagesDirectory..QBCore.Shared.Items[v.ItemName].name..'.png'), title = QBCore.Shared.Items[v.ItemName].label, description = text, event = 'mt-mechanic:client:CraftItems', args = { type = k } }
        end    
    end
    lib.registerContext(registeredMenu)
    lib.showContext('crafting_menu')
end)

RegisterNetEvent('mt-mechanic:client:CraftItems', function(data)
    lib.callback("mt-mechanic:server:CheckCraftingItems", source, function(hasItems)
        if (hasItems) then
            CraftItems(data.type)
        else
            QBCore.Functions.Notify(Lang.ErrorRightItems, "error") return
        end
    end, Config.Crafting[data.type].NeededItems)
end)
