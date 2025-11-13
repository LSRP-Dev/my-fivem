local useTargetConvar = GetConvar('UseTarget', 'false')
local targetDetected = GetResourceState('ox_target') == 'started' or GetResourceState('qb-target') == 'started'

return {
    useTarget = useTargetConvar == 'true' or targetDetected,
    successChance = 65,
    robberyChance = 15,
    minimumDrugSalePolice = 2,
    deliveryLocations = {
        {
            label = 'Little Seoul Apartments',
            coords = vec3(-713.43, -853.76, 23.82),
        },
        {
            label = 'Popular Street',
            coords = vec3(938.27, -1803.65, 31.24),
        },
        {
            label = 'Mirror Park',
            coords = vec3(1031.11, -774.38, 57.2),
        },
        {
            label = 'Weazel News',
            coords = vec3(-580.45, -928.21, 23.88),
        },
        {
            label = 'Sisyphus Theater',
            coords = vec3(683.92, 571.53, 129.43),
        },
        {
            label = 'Grapeseed Barn',
            coords = vec3(2540.13, 4675.28, 33.9),
        },
    }
}
