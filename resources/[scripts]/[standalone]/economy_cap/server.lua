local hourlyEarnings = {}

-- Cleanup thread to reset hourly earnings
CreateThread(function()
    while true do
        Wait(60000) -- Check every minute
        local currentTime = os.time()
        
        for identifier, data in pairs(hourlyEarnings) do
            if data.resetTime <= currentTime then
                if Config.Debug then
                    print(string.format("[economy_cap] Resetting earnings for %s (was $%d)", identifier, data.total))
                end
                hourlyEarnings[identifier] = nil
            end
        end
    end
end)

--- Check and add earnings with hourly cap
--- @param source number Player server ID
--- @param amount number Amount to add
--- @param activityType string Type of activity (for logging)
--- @return boolean success, number cappedAmount, string message
function CheckAndAddEarnings(source, amount, activityType)
    if not source or not amount or amount <= 0 then
        return false, 0, "Invalid parameters"
    end

    local Player = exports.qbx_core:GetPlayer(source)
    if not Player then
        return false, 0, "Player not found"
    end

    local identifier = Player.PlayerData.citizenid
    if not identifier then
        return false, 0, "Player identifier not found"
    end

    local currentTime = os.time()

    -- Initialize or get existing hourly earnings
    if not hourlyEarnings[identifier] then
        hourlyEarnings[identifier] = {
            total = 0,
            resetTime = currentTime + Config.ResetInterval
        }
    end

    -- Check if reset needed
    if hourlyEarnings[identifier].resetTime <= currentTime then
        hourlyEarnings[identifier] = {
            total = 0,
            resetTime = currentTime + Config.ResetInterval
        }
    end

    -- Check if limit already reached
    if hourlyEarnings[identifier].total >= Config.MaxHourlyEarnings then
        if Config.Debug then
            print(string.format("[economy_cap] %s hit hourly limit ($%d/%d) - %s", identifier, hourlyEarnings[identifier].total, Config.MaxHourlyEarnings, activityType or "unknown"))
        end
        return false, 0, "Hourly earnings limit reached"
    end

    -- Calculate capped amount
    local remaining = Config.MaxHourlyEarnings - hourlyEarnings[identifier].total
    local toAdd = math.min(amount, remaining)

    -- Update tracking
    hourlyEarnings[identifier].total = hourlyEarnings[identifier].total + toAdd

    if Config.Debug then
        print(string.format("[economy_cap] %s earned $%d (capped from $%d) - Total: $%d/%d - %s", identifier, toAdd, amount, hourlyEarnings[identifier].total, Config.MaxHourlyEarnings, activityType or "unknown"))
    end

    -- Return success, capped amount, and message if capped
    local message = nil
    if toAdd < amount then
        message = string.format("Earnings capped at $%d (hourly limit: $%d)", toAdd, Config.MaxHourlyEarnings)
    end

    return true, toAdd, message
end

--- Get current hourly earnings for a player
--- @param source number Player server ID
--- @return number total, number remaining
function GetHourlyEarnings(source)
    local Player = exports.qbx_core:GetPlayer(source)
    if not Player then return 0, Config.MaxHourlyEarnings end

    local identifier = Player.PlayerData.citizenid
    if not identifier or not hourlyEarnings[identifier] then
        return 0, Config.MaxHourlyEarnings
    end

    local currentTime = os.time()
    if hourlyEarnings[identifier].resetTime <= currentTime then
        return 0, Config.MaxHourlyEarnings
    end

    local total = hourlyEarnings[identifier].total
    local remaining = math.max(0, Config.MaxHourlyEarnings - total)
    return total, remaining
end

--- Reset hourly earnings for a player (admin function)
--- @param source number Player server ID
--- @return boolean success
function ResetHourlyEarnings(source)
    local Player = exports.qbx_core:GetPlayer(source)
    if not Player then return false end

    local identifier = Player.PlayerData.citizenid
    if identifier and hourlyEarnings[identifier] then
        hourlyEarnings[identifier] = nil
        return true
    end
    return false
end

-- Export functions
exports('CheckAndAddEarnings', CheckAndAddEarnings)
exports('GetHourlyEarnings', GetHourlyEarnings)
exports('ResetHourlyEarnings', ResetHourlyEarnings)

