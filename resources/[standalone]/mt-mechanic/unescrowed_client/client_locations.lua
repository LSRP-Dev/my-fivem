local QBCore = exports[Config.QBCoreName]:GetCoreObject()

CreateThread(function()
    for k, v in pairs(Config.ShopsLocations) do
        if Config.QBTargetName == 'ox_target' then
            exports.ox_target:addBoxZone({
                coords = v.Coords,
                size = vec3(v.Lenght, v.Width, 2.5),
                rotation = 0,
                debug = Config.DebugPoly,
                options = {
                    {
                        icon = "fas fa-hand-paper",
                        targeticon = "fas fa-shopping-basket",
                        label = Lang.OpenShop,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.AuthorizedJob then return true end
                        end,
                        onSelect = function()
                            TriggerEvent('mt-mechanic:client:OpenShop')
                        end
                    },
                }
            })
        else
            exports[Config.QBTargetName]:AddBoxZone('MechanicShop'..k, v.Coords, v.Lenght, v.Width, {
                name='MechanicShop'..k,
                heading=0,
                debugPoly = Config.DebugPoly,
            }, {
                options = {
                    {
                        icon = "fas fa-hand-paper",
                        targeticon = "fas fa-shopping-basket",
                        label = Lang.OpenShop,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.AuthorizedJob then return true end
                        end,
                        action = function()
                            TriggerEvent('mt-mechanic:client:OpenShop')
                        end
                    },
                },
                distance = 2.5
            })
        end
    end
    for k, v in pairs(Config.CraftingLocations) do
        if Config.QBTargetName == 'ox_target' then
            exports.ox_target:addBoxZone({
                coords = v.Coords,
                size = vec3(v.Lenght, v.Width, 2.5),
                rotation = 0,
                debug = Config.DebugPoly,
                options = {
                    {
                        icon = "fas fa-hand-paper",
                        targeticon = "fas fa-tools",
                        label = Lang.CraftThings,
                        canInteract = function()
                            if QBCore.Functions.GetPlayerData().job.name == v.AuthorizedJob then return true end
                        end,
                        onSelect = function()
                            TriggerEvent('mt-mechanic:client:OpenCraftingMenu')
                        end
                    },
                }
            })
        else
            exports[Config.QBTargetName]:AddBoxZone('MechanicCrafting'..k, v.Coords, v.Lenght, v.Width, {
                name='MechanicCrafting'..k,
                heading=0,
                debugPoly = Config.DebugPoly,
            }, {
                options = {
                    {
                        icon = "fas fa-hand-paper",
                        targeticon = "fas fa-tools",
                        label = Lang.CraftThings,
                        job = v.AuthorizedJob,
                        action = function()
                            TriggerEvent('mt-mechanic:client:OpenCraftingMenu')
                        end
                    },
                },
                distance = 2.5
            })
        end
    end
end)