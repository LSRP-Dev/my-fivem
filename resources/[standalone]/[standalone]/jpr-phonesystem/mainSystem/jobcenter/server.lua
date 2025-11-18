local QBCore = exports[Config.CoreName]:GetCoreObject()

local jobCenterConfig = JobCenterConfig or { jobs = {} }

local jobLookup = {}
for _, entry in ipairs(jobCenterConfig.jobs or {}) do
    jobLookup[entry.id] = entry
end

local function coordsToTable(coords)
    if not coords then return nil end

    if type(coords) == 'vector3' then
        return { x = coords.x + 0.0, y = coords.y + 0.0, z = coords.z + 0.0 }
    end

    if type(coords) == 'vector4' then
        return { x = coords.x + 0.0, y = coords.y + 0.0, z = coords.z + 0.0, w = coords.w + 0.0 }
    end

    if type(coords) == 'table' then
        local x = coords.x or coords[1]
        local y = coords.y or coords[2]
        local z = coords.z or coords[3]
        local w = coords.w or coords[4]

        if not x or not y then
            return nil
        end

        return {
            x = x + 0.0,
            y = y + 0.0,
            z = (z or 0.0) + 0.0,
            w = w and (w + 0.0) or nil
        }
    end

    return nil
end

local function buildJobList(currentJobName)
    local jobs = {}

    for _, entry in ipairs(jobCenterConfig.jobs or {}) do
        local coords = coordsToTable(entry.coords)
        local jobName = entry.job
        local jobData = jobName and QBCore.Shared.Jobs[jobName] or nil
        local jobLabel = jobData and jobData.label or entry.label

        jobs[#jobs + 1] = {
            id = entry.id,
            type = entry.type or 'job',
            label = entry.label,
            description = entry.description,
            icon = entry.icon,
            coords = coords,
            job = jobName,
            jobLabel = jobLabel,
            grade = entry.grade or 0,
            isCurrent = jobName and currentJobName and jobName == currentJobName or false,
        }
    end

    return jobs
end

QBCore.Functions.CreateCallback('jpr-phone:jobcenter:getJobs', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then
        cb({
            jobs = {},
            currentJob = {
                name = 'unemployed',
                label = 'Civilian',
                grade = 0,
            }
        })
        return
    end

    local jobData = player.PlayerData and player.PlayerData.job or {}
    local currentJobName = jobData.name or 'unemployed'
    local sharedJob = QBCore.Shared.Jobs[currentJobName]
    local currentJobLabel = jobData.label or (sharedJob and sharedJob.label) or currentJobName

    cb({
        jobs = buildJobList(currentJobName),
        currentJob = {
            name = currentJobName,
            label = currentJobLabel,
            grade = jobData.grade or 0
        }
    })
end)

RegisterNetEvent('jpr-phone:jobcenter:apply', function(jobId)
    local src = source
    local entry = jobLookup[jobId]

    if not entry then
        TriggerClientEvent('jpr-phone:jobcenter:result', src, {
            status = 'error',
            message = 'That listing is no longer available.'
        })
        return
    end

    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    local coords = coordsToTable(entry.coords)
    local jobInfo = player.PlayerData.job or {}

    if (entry.type or 'job') == 'job' then
        local jobName = entry.job
        local sharedJob = jobName and QBCore.Shared.Jobs[jobName] or nil

        if not jobName or not sharedJob then
            TriggerClientEvent('jpr-phone:jobcenter:result', src, {
                status = 'error',
                message = 'That employer is not hiring at the moment.',
                coords = coords
            })
            return
        end

        if jobInfo.name == jobName then
            TriggerClientEvent('jpr-phone:jobcenter:result', src, {
                status = 'job',
                message = ('You are already assigned to %s.'):format(entry.label),
                coords = coords,
                job = {
                    name = jobName,
                    label = sharedJob.label or entry.label,
                    grade = jobInfo.grade or 0,
                }
            })
            return
        end

        local grade = entry.grade or 0
        if not sharedJob.grades[grade] then
            grade = 0
        end

        player.Functions.SetJob(jobName, grade)

        TriggerClientEvent('jpr-phone:jobcenter:result', src, {
            status = 'job',
            message = ('You are now employed at %s.'):format(entry.label),
            coords = coords,
            job = {
                name = jobName,
                label = sharedJob.label or entry.label,
                grade = grade,
            }
        })
        return
    end

    TriggerClientEvent('jpr-phone:jobcenter:result', src, {
        status = 'waypoint',
        message = ('GPS set to %s.'):format(entry.label),
        coords = coords,
    })
end)

