local QBCore = exports[Config.CoreName]:GetCoreObject()

local currentJobName = nil

local function refreshCurrentJob()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData or not playerData.job then
        currentJobName = 'unemployed'
        return
    end

    currentJobName = playerData.job.name
end

CreateThread(function()
    refreshCurrentJob()
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    refreshCurrentJob()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    currentJobName = 'unemployed'
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(jobData)
    if not jobData then return end

    currentJobName = jobData.name

    SendNUIMessage({
        action = 'jobcenter:updateJob',
        payload = {
            job = {
                name = jobData.name,
                label = jobData.label
            }
        }
    })
end)

RegisterNUICallback('jobcenter:fetch', function(_, cb)
    QBCore.Functions.TriggerCallback('jpr-phone:jobcenter:getJobs', function(response)
        cb(response)
    end)
end)

RegisterNUICallback('jobcenter:apply', function(data, cb)
    local jobId = data and data.jobId
    if not jobId then
        cb({ success = false, error = 'invalid_job' })
        return
    end

    TriggerServerEvent('jpr-phone:jobcenter:apply', jobId)
    cb({ success = true })
end)

RegisterNetEvent('jpr-phone:jobcenter:result', function(payload)
    if not payload then return end

    if payload.coords and payload.coords.x and payload.coords.y then
        SetNewWaypoint(payload.coords.x + 0.0, payload.coords.y + 0.0)
    end

    if payload.job and payload.job.name then
        currentJobName = payload.job.name
    end

    SendNUIMessage({
        action = 'jobcenter:result',
        payload = payload
    })
end)

