local QBCore = exports[Config.QBCoreName]:GetCoreObject()

RegisterNetEvent('mt-mechanic:client:SpawnToolBox', function(data)
    if IsPedInAnyVehicle(PlayerPedId()) then
        QBCore.Functions.Notify(Lang.CantDoIt, 'error', 7500)
    else
        ToolBox = makeProp({ prop = `prop_toolchest_05`, coords = vector4(GetPedBoneCoords(PlayerPedId()).x, GetPedBoneCoords(PlayerPedId()).y-1, GetPedBoneCoords(PlayerPedId()).z, GetEntityHeading(PlayerPedId()))}, 0, 1)
        FreezeEntityPosition(ToolBox, true)
        TriggerServerEvent('mt-mechanic:server:RemoveItem', 'mechanic_toolbox', 1)
        IsSpawned = true
        if Config.QBTargetName == 'ox_target' then
            local options = {
                {
                    icon = 'fas fa-hand-paper',
                    label = Lang.OpenStash,
                    targeticon = 'fas fa-tools',
                    onSelect = function()
                        local cid = QBCore.Functions.GetPlayerData().citizenid
                        if Config.QBInventoryName == 'ox_inventory' then
                            TriggerServerEvent('mt-mechanic:server:RegisterStash', tostring('MechanicToolBox_'..cid), tostring('Mechanic ToolBox '..cid), Config.ToolBoxStashSlots, Config.ToolBoxStashWeight)
                            exports.ox_inventory:openInventory('stash', tostring('MechanicToolBox_'..cid))
                        else
                            TriggerEvent("inventory:client:SetCurrentStash", tostring('MechanicToolBox_'..cid))
                            TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring('MechanicToolBox_'..cid), { maxweight = Config.ToolBoxStashWeight, slots = Config.ToolBoxStashSlots })
                        end
                    end,
                    canInteract = function()
                        if IsSpawned then return true end
                    end,
                },
                {
                    icon = 'fas fa-hand-paper',
                    label = Lang.PickToolBox,
                    targeticon = 'fas fa-tools',
                    onSelect = function()
                        DeleteEntity(ToolBox)
                        TriggerServerEvent('mt-mechanic:server:AddItem', 'mechanic_toolbox', 1)
                        IsSpawned = false
                    end,
                    canInteract = function()
                        if IsSpawned then return true end
                    end,
                },
            }
            exports.ox_target:addLocalEntity(ToolBox, options)
        else
            exports[Config.QBTargetName]:AddTargetEntity(ToolBox, {
                options = { 
                    {
                        icon = 'fas fa-hand-paper',
                        label = Lang.OpenStash,
                        targeticon = 'fas fa-tools',
                        action = function()
                            local cid = QBCore.Functions.GetPlayerData().citizenid
                            if Config.QBInventoryName == 'ox_inventory' then
                                TriggerServerEvent('mt-mechanic:server:RegisterStash', tostring('MechanicToolBox_'..cid), tostring('Mechanic ToolBox '..cid), Config.ToolBoxStashSlots, Config.ToolBoxStashWeight)
                                exports.ox_inventory:openInventory('stash', tostring('MechanicToolBox_'..cid))
                            else
                                TriggerEvent("inventory:client:SetCurrentStash", tostring('MechanicToolBox_'..cid))
                                TriggerServerEvent("inventory:server:OpenInventory", "stash", tostring('MechanicToolBox_'..cid), { maxweight = Config.ToolBoxStashWeight, slots = Config.ToolBoxStashSlots })
                            end
                        end,
                        canInteract = function()
                            if IsSpawned then return true end
                        end,
                    },
                    {
                        icon = 'fas fa-hand-paper',
                        label = Lang.PickToolBox,
                        targeticon = 'fas fa-tools',
                        action = function()
                            DeleteEntity(ToolBox)
                            TriggerServerEvent('mt-mechanic:server:AddItem', 'mechanic_toolbox', 1)
                            IsSpawned = false
                        end,
                        canInteract = function()
                            if IsSpawned then return true end
                        end,
                    },
                },
                distance = 2.5,
            })
        end
    end
end)