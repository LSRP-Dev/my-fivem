Config = Config or {}

Config.Debug = false

Config.Storage = {
    Mode = 'json', -- json or mysql
    JsonDirectory = 'configs/heists',
    MySQLTable = 'heistbuilder_heists'
}

Config.Reputation = {
    Enabled = true,
    Default = 0,
    Rewards = {
        success = 15,
        fail = -8,
        assist = 5
    }
}

Config.Evidence = {
    dnaChance = 35,
    printChance = 40,
    casingChance = 25,
    fibreChance = 20
}

Config.Dispatch = {
    resource = 'qbx_police',
    event = 'police:client:dispatch',
    lastKnownBlipTime = 30
}

Config.RewardPools = {
    cash = {
        min = 4500,
        max = 8000
    },
    items = {
        { item = 'markedbills', min = 1, max = 3 },
        { item = 'goldbar', min = 1, max = 2 }
    }
}

Config.Heists = {
    {
        id = 'fleeca_boulevard',
        label = 'Fleeca: Boulevar Del Perro',
        type = 'bank',
        tier = 2,
        minPlayers = 2,
        maxPlayers = 4,
        requiredPolice = 3,
        cooldownMinutes = 45,
        entryPoint = { x = -354.42, y = -55.17, z = 49.04 },
        escapeRadius = 50.0,
        reputationRequired = 200,
        steps = {
            { type = 'cut_power', label = 'Isolate Bank Feed', radius = 5.0, duration = 9.0 },
            { type = 'hack_panel', label = 'Hack Teller Panel', difficulty = 'hard', duration = 12.0 },
            { type = 'disable_alarm', label = 'Spoof Vault Alarm', duration = 8.0 },
            { type = 'thermal_charge', label = 'Breach Vault Door', duration = 14.0 },
            { type = 'drill_boxes', label = 'Drill Deposit Boxes', lockboxes = 6, duration = 18.0 },
            { type = 'grab_loot', label = 'Secure Cash Bags', lootType = 'cash', amount = 6 },
            { type = 'escape', label = 'Escape', radius = 60.0 }
        },
        guards = {
            { weapon = 'WEAPON_CARBINERIFLE', coords = { x = -353.41, y = -44.21, z = 49.04, w = 160.0 }, model = 's_m_m_security_01' }
        },
        rewards = {
            cash = { min = 120000, max = 180000 },
            items = {
                { item = 'goldbar', count = 2 },
                { item = 'markedbills', count = 5 }
            }
        },
        evidence = {
            dna = true,
            cctv = true,
            fibres = true
        }
    },
    {
        id = 'store_robbery_24_7',
        label = '24/7 Store Robbery',
        type = 'store',
        tier = 1,
        minPlayers = 1,
        maxPlayers = 4,
        requiredPolice = 0,
        cooldownMinutes = 15,
        entryPoint = { x = 24.47, y = -1346.62, z = 29.50 },
        escapeRadius = 50.0,
        reputationRequired = 0,
        guards = {
            { weapon = 'WEAPON_PISTOL', coords = { x = 28.20, y = -1339.25, z = 29.50, w = 180.0 }, model = 's_m_m_security_01' }
        },
        tellers = {
            { coords = { x = 25.80, y = -1346.62, z = 29.50, w = 270.0 }, model = 's_f_y_shop_low' },
            { coords = { x = 23.20, y = -1346.62, z = 29.50, w = 90.0 }, model = 's_f_y_shop_low' }
        },
        cashRegisters = {
            { coords = { x = 24.47, y = -1344.62, z = 29.50 }, model = `prop_till_01`, minCash = 500, maxCash = 1500 },
            { coords = { x = 24.47, y = -1348.62, z = 29.50 }, model = `prop_till_01`, minCash = 500, maxCash = 1500 }
        },
        rewards = {
            cash = { min = 1000, max = 3000 }
        }
    },
    {
        id = 'store_robbery_liquor',
        label = 'Liquor Store Robbery',
        type = 'store',
        tier = 1,
        minPlayers = 1,
        maxPlayers = 4,
        requiredPolice = 0,
        cooldownMinutes = 20,
        entryPoint = { x = 1134.27, y = -982.51, z = 46.42 },
        escapeRadius = 50.0,
        reputationRequired = 0,
        guards = {
            { weapon = 'WEAPON_PISTOL', coords = { x = 1128.50, y = -980.20, z = 46.42, w = 270.0 }, model = 's_m_m_security_01' }
        },
        tellers = {
            { coords = { x = 1135.20, y = -982.51, z = 46.42, w = 180.0 }, model = 's_m_y_shop_mask' }
        },
        cashRegisters = {
            { coords = { x = 1134.27, y = -981.50, z = 46.42 }, model = `prop_till_01`, minCash = 800, maxCash = 2000 },
            { coords = { x = 1134.27, y = -983.50, z = 46.42 }, model = `prop_till_01`, minCash = 800, maxCash = 2000 }
        },
        rewards = {
            cash = { min = 1600, max = 4000 }
        }
    }
}

return Config
