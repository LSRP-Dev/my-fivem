-- Fish Market Client Script
-- Handles interactions at fish market locations

local FishMarketZones = {
    { coords = vec3(-1847.98, -1193.15, 14.30), radius = 3.0 },
    { coords = vec3(-1598.84, 5200.18, 4.31), radius = 3.0 },
}

local FishPrices = {
    ['fish'] = 75,
    ['dolphin'] = 300,
    ['hammershark'] = 300,
    ['tigershark'] = 650,
    ['stingray'] = 650,
    ['killerwhale'] = 1750,
    ['humpback'] = 4000,
}

local function isPlayerAtFishMarket()
    local playerCoords = GetEntityCoords(cache.ped)
    
    for _, zone in ipairs(FishMarketZones) do
        local distance = #(playerCoords - zone.coords)
        if distance <= zone.radius then
            return true
        end
    end
    
    return false
end

-- Create target zones for fish market
CreateThread(function()
    for _, zone in ipairs(FishMarketZones) do
        exports.ox_target:addSphereZone({
            coords = zone.coords,
            radius = zone.radius,
            debug = false,
            options = {
                {
                    name = 'fishmarket_sell',
                    icon = 'fas fa-fish',
                    label = 'Sell Fish',
                    onSelect = function()
                        openFishMarketMenu()
                    end,
                    canInteract = function()
                        return isPlayerAtFishMarket()
                    end
                }
            }
        })
    end
end)

function openFishMarketMenu()
    if not isPlayerAtFishMarket() then
        lib.notify({
            title = 'Fish Market',
            description = 'You must be at a fish market',
            type = 'error'
        })
        return
    end
    
    local inventory = exports.ox_inventory:GetPlayerItems()
    if not inventory then return end
    
    local fishItems = {}
    local items = exports.ox_inventory:Items()
    
    for _, item in pairs(inventory) do
        if FishPrices[item.name] then
            table.insert(fishItems, {
                title = items[item.name].label,
                description = string.format('Price: $%d each | You have: %d', FishPrices[item.name], item.count),
                metadata = {
                    { label = 'Price per fish', value = '$' .. FishPrices[item.name] },
                    { label = 'You have', value = item.count },
                    { label = 'Total value', value = '$' .. (FishPrices[item.name] * item.count) }
                },
                onSelect = function()
                    sellFishDialog(item.name, item.count, FishPrices[item.name])
                end
            })
        end
    end
    
    if #fishItems == 0 then
        lib.notify({
            title = 'Fish Market',
            description = 'You don\'t have any fish to sell',
            type = 'inform'
        })
        return
    end
    
    lib.registerContext({
        id = 'fishmarket_menu',
        title = 'Fish Market',
        options = fishItems
    })
    
    lib.showContext('fishmarket_menu')
end

function sellFishDialog(itemName, maxCount, pricePerFish)
    local input = lib.inputDialog('Sell Fish', {
        {
            type = 'number',
            label = 'Amount to sell',
            description = string.format('Price: $%d each | Max: %d', pricePerFish, maxCount),
            required = true,
            default = maxCount,
            min = 1,
            max = maxCount
        }
    })
    
    if not input or not input[1] then return end
    
    local count = math.floor(input[1])
    if count < 1 or count > maxCount then
        lib.notify({
            title = 'Fish Market',
            description = 'Invalid amount',
            type = 'error'
        })
        return
    end
    
    TriggerServerEvent('brz-fishing:sellFish', itemName, count)
end

-- Command to open fish market menu
RegisterCommand('fishmarket', function()
    if isPlayerAtFishMarket() then
        openFishMarketMenu()
    else
        lib.notify({
            title = 'Fish Market',
            description = 'You must be at a fish market to sell fish',
            type = 'error'
        })
    end
end, false)

