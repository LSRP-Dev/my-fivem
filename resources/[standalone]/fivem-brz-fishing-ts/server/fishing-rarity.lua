-- Fishing Rarity System
-- Overrides the default random fish selection with rarity-based system

local CATCH_RATES = {
    common = 60,
    uncommon = 25,
    rare = 10,
    epic = 4,
    legendary = 1,
}

local FISHES_BY_RARITY = {
    common = { 'fish' },
    uncommon = { 'dolphin', 'hammerShark' },
    rare = { 'tigerShark', 'stingray' },
    epic = { 'killerWhale' },
    legendary = { 'humpBack' },
}

-- Get player's fishing equipment bonuses
local function getEquipmentBonus(source)
    local playerInv = exports.ox_inventory:GetInventory(source, 'player')
    if not playerInv then return 0, 0 end
    
    local rodBonus = 0
    local baitBonus = 0
    
    -- Check for better rods
    for _, item in pairs(playerInv.items) do
        if item.name == 'fishingrod2' then
            rodBonus = 0.15 -- 15% bonus to rare catches
        elseif item.name == 'fishingrod3' then
            rodBonus = 0.30 -- 30% bonus to rare catches
        elseif item.name == 'premiumbait' then
            baitBonus = 0.20 -- 20% bonus to rare/epic
        elseif item.name == 'legendarybait' then
            baitBonus = 0.50 -- 50% bonus to legendary
        end
    end
    
    return rodBonus, baitBonus
end

-- Select fish based on rarity system
local function selectFishByRarity(source)
    local rodBonus, baitBonus = getEquipmentBonus(source)
    
    -- Adjust catch rates based on equipment
    local adjustedRates = {
        common = CATCH_RATES.common - (rodBonus * 20) - (baitBonus * 10),
        uncommon = CATCH_RATES.uncommon + (rodBonus * 10),
        rare = CATCH_RATES.rare + (rodBonus * 5) + (baitBonus * 5),
        epic = CATCH_RATES.epic + (rodBonus * 3) + (baitBonus * 3),
        legendary = CATCH_RATES.legendary + (rodBonus * 2) + (baitBonus * 2),
    }
    
    -- Normalize to ensure they add up to 100
    local total = adjustedRates.common + adjustedRates.uncommon + adjustedRates.rare + adjustedRates.epic + adjustedRates.legendary
    for k, v in pairs(adjustedRates) do
        adjustedRates[k] = (v / total) * 100
    end
    
    -- Roll for rarity
    local roll = math.random() * 100
    local selectedRarity = 'common'
    local cumulative = 0
    
    for rarity, rate in pairs(adjustedRates) do
        cumulative = cumulative + rate
        if roll <= cumulative then
            selectedRarity = rarity
            break
        end
    end
    
    -- Select random fish from that rarity
    local fishList = FISHES_BY_RARITY[selectedRarity]
    if not fishList or #fishList == 0 then
        fishList = FISHES_BY_RARITY.common -- Fallback
    end
    
    return fishList[math.random(1, #fishList)]
end

-- Store player fish assignments (override the TypeScript random selection)
local playerFishAssignments = {}

-- Hook into the fishing request to override with rarity system
AddEventHandler('brz-fishing:requestStartFishing', function(playerId)
    local src = playerId or source
    local selectedFish = selectFishByRarity(src)
    playerFishAssignments[src] = selectedFish
    
    -- Trigger the client event with our selected fish
    TriggerClientEvent('brz-fishing:startFishing', src, selectedFish)
end)

-- Override catch event to use our assigned fish
RegisterNetEvent('brz-fishing:catchFish', function()
    local src = source
    local fishId = playerFishAssignments[src]
    
    if fishId then
        -- Process the catch with our assigned fish
        TriggerEvent('brz-fishing:server:processCatch', src, fishId)
        playerFishAssignments[src] = nil -- Clear after catch
    end
end)

-- Export function
exports('SelectFishByRarity', selectFishByRarity)
exports('GetPlayerAssignedFish', function(playerId)
    return playerFishAssignments[playerId]
end)

