local jobloc = 'fishnchips'

Jobs['fishnchips'] = {
    CateringEnabled = true,
    closedShopsEnabled = true,
    automaticJobDuty = true,
    polyzone = {
        vec3(-1279.82, -1198.74, 4.87),
        vec3(-1264.25, -1190.82, 5.71),
        vec3(-1262.50, -1195.24, 5.61),
        vec3(-1258.15, -1194.26, 6.88),
        vec3(-1254.40, -1218.48, 5.38),
        vec3(-1265.22, -1221.41, 4.91)
    },
    Blip = {
        { sprite = 280, color = 5, scale = 0.6, label = 'Fish & Chips', loc = vector3(-1271.22, -1200.75, 5.37) },
    },
    closedShops = {
        { ped = 'mp_m_freemode_01', loc = vec4(-1264.61, -1210.34, 5.13, 25), label = 'Fish & Chips Shop' }
    },
    closedShopItems = {
        fishchips = { name = 'fishchips', price = 15 },
        cs_fish_meal = { name = 'cs_fish_meal', price = 20 },
        cs_battered_cod = { name = 'cs_battered_cod', price = 12 },
        cs_chips = { name = 'cs_chips', price = 5 },
        cs_battered_sausage = { name = 'cs_battered_sausage', price = 8 },
        cs_pie = { name = 'cs_pie', price = 10 },
        cs_sausage_meal = { name = 'cs_sausage_meal', price = 15 },
        cs_savaloy = { name = 'cs_savaloy', price = 7 },
        cs_savaloy_meal = { name = 'cs_savaloy_meal', price = 14 },
        cs_pie_meal = { name = 'cs_pie_meal', price = 17 },
        sprunk = { name = 'sprunk', price = 3 },
        ecola = { name = 'ecola', price = 3 },
        coffee = { name = 'coffee', price = 4 },
    },
    craftingStations = {
        cuttingboard = {
            { anim = 'uncuff', give = { potato = 1 }, take = { raw_chips = 1 }, progtext = 'Cutting Potatoes' },
            { anim = 'uncuff', give = { fish = 1 }, take = { fish_fillet = 1 }, progtext = 'Filleting Fish' },
        },
        fryer = {
            { anim = 'uncuff', give = { raw_chips = 1, cooking_oil = 1 }, take = { cs_chips = 1 }, progtext = 'Frying Chips' },
            { anim = 'uncuff', give = { fish_fillet = 1, batter_mix = 1, cooking_oil = 1 }, take = { cs_battered_cod = 1 }, progtext = 'Battering & Frying Fish' },
            { anim = 'uncuff', give = { fish_fillet = 1, batter_mix = 1, cooking_oil = 1 }, take = { seafood_batter_fish = 1 }, progtext = 'Battering & Frying Fish' },
        },
        grill = {
            { anim = 'uncuff', give = { fish = 1 }, take = { cooked_fish = 1 }, progtext = 'Grilling Fish' },
            { anim = 'uncuff', give = { fish = 1 }, take = { grilled_fish = 1 }, progtext = 'Grilling Fish' },
        },
        assembly = {
            { anim = 'uncuff', give = { cs_battered_cod = 1, cs_chips = 1 }, take = { fishchips = 1 }, progtext = 'Assembling' },
            { anim = 'uncuff', give = { fishchips = 1, sprunk = 1 }, take = { cs_fish_meal = 1 }, progtext = 'Assembling Meal' },
            { anim = 'uncuff', give = { fishchips = 1, ecola = 1 }, take = { cs_fish_meal = 1 }, progtext = 'Assembling Meal' },
        },
        drinks = {
            { anim = 'uncuff', give = {}, take = { sprunk = 1 }, progtext = 'Pouring' },
            { anim = 'uncuff', give = {}, take = { ecola = 1 }, progtext = 'Pouring' },
            { anim = 'uncuff', give = {}, take = { coffee = 1 }, progtext = 'Pouring' },
        }
    },
    catering = {
        commission = 0.75,
        items = {
            { name = 'fishchips', minPrice = 15, maxPrice = 25, maxAmount = 30 },
            { name = 'cs_fish_meal', minPrice = 20, maxPrice = 35, maxAmount = 20 },
            { name = 'cs_battered_cod', minPrice = 12, maxPrice = 20, maxAmount = 30 },
            { name = 'cs_chips', minPrice = 5, maxPrice = 10, maxAmount = 40 },
            { name = 'cs_battered_sausage', minPrice = 8, maxPrice = 15, maxAmount = 30 },
            { name = 'cs_pie', minPrice = 10, maxPrice = 18, maxAmount = 25 },
            { name = 'sprunk', minPrice = 3, maxPrice = 6, maxAmount = 30 },
            { name = 'ecola', minPrice = 3, maxPrice = 6, maxAmount = 30 },
        },
        Van = {
            fishnchips = { model = 'burrito', label = 'Burrito', plate = 'FNCater', livery = 3, loc = vec4(-1270.49, -1222.46, 4.54, 69) },
        }
    },
    shops = {
        ingredients = {
            { name = 'fish', price = 4, amount = 50 },
            { name = 'potato', price = 2, amount = 50 },
            { name = 'batter_mix', price = 3, amount = 50 },
            { name = 'cooking_oil', price = 5, amount = 50 },
            { name = 'flour', price = 2, amount = 50 },
            { name = 'salt', price = 1, amount = 50 },
            { name = 'vinegar', price = 2, amount = 50 },
            { name = 'lemon', price = 1, amount = 50 },
            { name = 'cs_paper', price = 1, amount = 50 },
        },
    },
    locations = {
        Crafter = {
            {
                CraftData = { type = 'cuttingboard', targetLabel = 'Cutting Board', menuLabel = 'Cutting Board' },
                loc = vector3(-1261.58, -1215.20, 5.12),
                l = 0.8,
                w = 0.8,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
            {
                CraftData = { type = 'fryer', targetLabel = 'Fryer', menuLabel = 'Fryer' },
                loc = vector3(-1257.36, -1213.46, 5.13),
                l = 0.8,
                w = 0.8,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
            {
                CraftData = { type = 'grill', targetLabel = 'Grill', menuLabel = 'Grill' },
                loc = vector3(-1259.20, -1215.60, 5.13),
                l = 0.8,
                w = 0.8,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
            {
                CraftData = { type = 'assembly', targetLabel = 'Assembly', menuLabel = 'Assembly' },
                loc = vector3(-1263.16, -1212.60, 5.13),
                l = 0.8,
                w = 0.8,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
            {
                CraftData = { type = 'drinks', targetLabel = 'Drinks Station', menuLabel = 'Drinks Station' },
                loc = vector3(-1265.75, -1212.07, 5.13),
                l = 0.8,
                w = 0.8,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
        },
        Stores = {
            {
                StoreData = { type = 'ingredients', targetLabel = 'Ingredient Shop', menuLabel = 'Ingredient Shop' },
                loc = vector3(-1260.82, -1218.55, 5.13),
                l = 1.0,
                w = 1.0,
                lwr = 0.5,
                upr = 0.5,
                r = 25,
                job = jobloc
            },
        },
        Tills = {
            { loc = vector3(-1264.77, -1210.29, 5.13), l = 1.0, w = 1.0, lwr = 0.5, upr = 0.5, r = 25, commission = 0.2, job = jobloc },
        },
        trays = {
            { label = 'Grab Food', loc = vector3(-1262.93, -1209.69, 5.13), l = 1.0, w = 1.0, lwr = 0.5, upr = 0.5, r = 25, slots = 10, weight = 50000, job = jobloc },
        },
        stash = {
            { label = 'Store Products', loc = vector3(-1260.82, -1218.55, 5.13), l = 1.0, w = 1.0, lwr = 0.5, upr = 0.5, r = 25, slots = 50, weight = 500000, job = jobloc },
        },
    },
    consumables = {
        fishchips = { anim = 'eat', label = 'Eating', add = { hunger = 28 } },
        cs_fish_meal = { anim = 'eat', label = 'Eating', add = { hunger = 30, thirst = 12 } },
        cs_battered_cod = { anim = 'eat', label = 'Eating', add = { hunger = 15 } },
        cs_chips = { anim = 'eat', label = 'Eating', add = { hunger = 10 } },
        cs_battered_sausage = { anim = 'eat', label = 'Eating', add = { hunger = 12 } },
        cs_pie = { anim = 'eat', label = 'Eating', add = { hunger = 18 } },
        cs_sausage_meal = { anim = 'eat', label = 'Eating', add = { hunger = 22, thirst = 10 } },
        cs_savaloy = { anim = 'eat', label = 'Eating', add = { hunger = 10 } },
        cs_savaloy_meal = { anim = 'eat', label = 'Eating', add = { hunger = 20, thirst = 10 } },
        cs_pie_meal = { anim = 'eat', label = 'Eating', add = { hunger = 25, thirst = 10 } },
        seafood_batter_fish = { anim = 'eat', label = 'Eating', add = { hunger = 15 } },
        cooked_fish = { anim = 'eat', label = 'Eating', add = { hunger = 12 } },
        grilled_fish = { anim = 'eat', label = 'Eating', add = { hunger = 12 } },
        sprunk = { anim = 'drink', label = 'Drinking', add = { thirst = 12 } },
        ecola = { anim = 'drink', label = 'Drinking', add = { thirst = 12 } },
        coffee = { anim = 'drink', label = 'Drinking', add = { thirst = 10 } },
    },
}

