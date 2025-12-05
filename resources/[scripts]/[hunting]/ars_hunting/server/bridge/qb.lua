local QBCore = GetResourceState('qb-core'):find('start') and exports['qb-core']:GetCoreObject() or nil

if not QBCore then return end

framework = {}

function framework.addItems(data)
    local xPlayer = QBCore.Functions.GetPlayer(data.target)

    if type(data.items) == "table" then
        for _, item in pairs(data.items) do
            if item.item == "money" then
                -- Check hourly earnings cap for money rewards
                local success, cappedAmount, message = exports['economy_cap']:CheckAndAddEarnings(data.target, item.quantity, 'hunting-mission')
                if success and cappedAmount > 0 then
                    xPlayer.Functions.AddMoney('cash', cappedAmount)
                    if message then
                        TriggerClientEvent('QBCore:Notify', data.target, message, 'inform')
                    end
                elseif not success then
                    TriggerClientEvent('QBCore:Notify', data.target, message or 'You have reached your hourly earnings limit', 'error')
                end
            else
                xPlayer.Functions.AddItem(item.item, (item?.quantity or 1))
            end
        end
    else
        if data.items == "money" then
            -- Check hourly earnings cap for money rewards
            local success, cappedAmount, message = exports['economy_cap']:CheckAndAddEarnings(data.target, 1, 'hunting-mission')
            if success and cappedAmount > 0 then
                xPlayer.Functions.AddMoney('cash', cappedAmount)
                if message then
                    TriggerClientEvent('QBCore:Notify', data.target, message, 'inform')
                end
            elseif not success then
                TriggerClientEvent('QBCore:Notify', data.target, message or 'You have reached your hourly earnings limit', 'error')
            end
        else
            xPlayer.Functions.AddItem(data.items, 1)
        end
    end
end

function framework.hasMoney(target)
    local xPlayer = QBCore.Functions.GetPlayer(target)
    return xPlayer.PlayerData.money.cash
end

function framework.addMoney(data)
    local xPlayer = QBCore.Functions.GetPlayer(data.target)
    if xPlayer then
        -- Check hourly earnings cap
        local success, cappedAmount, message = exports['economy_cap']:CheckAndAddEarnings(data.target, data.amount, 'hunting')
        if success and cappedAmount > 0 then
            xPlayer.Functions.AddMoney('cash', cappedAmount)
            if message then
                TriggerClientEvent('QBCore:Notify', data.target, message, 'inform')
            end
        elseif not success then
            TriggerClientEvent('QBCore:Notify', data.target, message or 'You have reached your hourly earnings limit', 'error')
        end
    end
end

function framework.removeMoney(data)
    local xPlayer = QBCore.Functions.GetPlayer(data.target)
    xPlayer.Functions.RemoveMoney('cash', data.amount)
end

function framework.hasItems(data)
    local xPlayer = QBCore.Functions.GetPlayer(data.target)

    if type(data.items) == "table" then
        for _, item in pairs(data.items) do
            local hasItem = xPlayer.Functions.GetItemByName(item.item)
            if not hasItem then return false end

            if hasItem?.amount >= item.quantity then return true end
        end
    else
        return xPlayer.Functions.GetItemByName(data.items)?.amount > 0
    end
end

function framework.removeItem(data)
    local xPlayer = QBCore.Functions.GetPlayer(data.target)
    xPlayer.Functions.RemoveItem(data.item, data.count)
end

QBCore.Functions.CreateUseableItem(Config.TrackerItem, function(source, item)
    TriggerClientEvent("ars_hunting:trackAnimal", source)
end)

QBCore.Functions.CreateUseableItem(Config.BaitItem, function(source)
    framework.removeItem({ target = source, item = Config.BaitItem, count = 1 })
    TriggerClientEvent("ars_hunting:placeBait", source)
end)


if Config.Campfire.enable then
    QBCore.Functions.CreateUseableItem(Config.Campfire.campfireItem, function(source, item)
        framework.removeItem({ target = source, item = Config.Campfire.campfireItem, count = 1 })
        TriggerClientEvent("ars_hunting:useCampfire", source)
    end)
end
