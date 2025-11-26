-- Fish Market Selling Script
-- Players can sell fish at the fish market for money

local FishPrices = {
    ['fish'] = 75,          -- Common: $50-100 (using $75)
    ['dolphin'] = 300,      -- Uncommon: $200-400 (using $300)
    ['hammershark'] = 300,  -- Uncommon: $200-400 (using $300)
    ['tigershark'] = 650,   -- Rare: $500-800 (using $650)
    ['stingray'] = 650,     -- Rare: $500-800 (using $650)
    ['killerwhale'] = 1750, -- Epic: $1500-2000 (using $1750)
    ['humpback'] = 4000,    -- Legendary: $3000-5000 (using $4000)
}

local FishMarketZones = {
    { coords = vec3(-1847.98, -1193.15, 14.30), radius = 3.0 },
    { coords = vec3(-1598.84, 5200.18, 4.31), radius = 3.0 },
}

local function isPlayerAtFishMarket(source)
    local ped = GetPlayerPed(source)
    if not ped or ped == 0 then return false end
    
    local playerCoords = GetEntityCoords(ped)
    
    for _, zone in ipairs(FishMarketZones) do
        local distance = #(playerCoords - zone.coords)
        if distance <= zone.radius then
            return true
        end
    end
    
    return false
end

RegisterNetEvent('brz-fishing:sellFish', function(itemName, count)
    local src = source
    
    if not isPlayerAtFishMarket(src) then
        lib.notify(src, {
            title = 'Fish Market',
            description = 'You must be at a fish market to sell fish',
            type = 'error'
        })
        return
    end
    
    local price = FishPrices[itemName]
    if not price then
        lib.notify(src, {
            title = 'Fish Market',
            description = 'This item cannot be sold here',
            type = 'error'
        })
        return
    end
    
    local playerInv = exports.ox_inventory:GetInventory(src, 'player')
    if not playerInv then return end
    
    local hasItem = exports.ox_inventory:GetItem(src, itemName, nil, true)
    if not hasItem or hasItem < count then
        lib.notify(src, {
            title = 'Fish Market',
            description = 'You don\'t have enough of this fish',
            type = 'error'
        })
        return
    end
    
    local totalPrice = price * count
    
    if exports.ox_inventory:RemoveItem(src, itemName, count) then
        local Player = exports.qbx_core:GetPlayer(src)
        if Player then
            Player.Functions.AddMoney('cash', totalPrice)
            lib.notify(src, {
                title = 'Fish Market',
                description = string.format('Sold %dx %s for $%s', count, exports.ox_inventory:Items()[itemName].label, totalPrice),
                type = 'success'
            })
        end
    else
        lib.notify(src, {
            title = 'Fish Market',
            description = 'Failed to sell fish',
            type = 'error'
        })
    end
end)

-- Export for other scripts
exports('GetFishPrice', function(itemName)
    return FishPrices[itemName]
end)

exports('GetFishMarketZones', function()
    return FishMarketZones
end)

