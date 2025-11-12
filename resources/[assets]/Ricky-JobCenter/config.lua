-- Job Center
-- Tech Development - https://discord.gg/tHAbhd94vS

Config = {}

Config.Framework = 'qbcore' -- esx/qbcore

Config.Coords = {
    vector3(-266.547, -960.9688, 30.22313)
}

Config.Language = "en"

Config.Lang = {
    ['it'] = {
        ['open_menu'] = "Premi ~INPUT_CONTEXT~ per accedere al ~b~Centro Lavori",
        ['select_favourite'] = "Scegli il tuo lavoro",
        ['job'] = "Preferito",
        ['job2'] = "CENTRO",
        ['center'] = "LAVORI",
        ['select'] = "Seleziona",
        ['selected'] = "Selezionato"
    },
    ['en'] = {
        ['open_menu'] = "Press ~INPUT_CONTEXT~ to access the ~b~Job Center",
        ['select_favourite'] = "Select your Favourite",
        ['job'] = "Job",
        ['job2'] = "JOB",
        ['center'] = "CENTER",
        ['select'] = "Select",
        ['selected'] = "Selected"
    },
    ['fr'] = {
        ['open_menu'] = "Appuyez sur ~INPUT_CONTEXT~ pour accéder au ~b~Centre d'emploi",
        ['select_favourite'] = "Sélectionnez votre favori",
        ['job'] = "Emploi",
        ['job2'] = "CENTRE",
        ['center'] = "EMPLOI",
        ['select'] = "Sélectionner",
        ['selected'] = "Sélectionné"
    },
}

Config.Jobs = {
    {
        label = "Civilian",
        id = "unemployed",
        description = "Leave the workforce and live off the land.",
        gps = nil,
    },
    {
        label = "Real Estate",
        id = "realestate",
        description = "Broker property deals and manage housing across the city.",
        gps = { x = -707.32, y = 270.03, z = 83.15 },
    },
    {
        label = "Taxi",
        id = "taxi",
        description = "Drive passengers safely to their destinations whenever needed.",
        gps = { x = 896.22, y = -177.72, z = 74.7 },
    },
    {
        label = "Bus",
        id = "bus",
        description = "Operate scheduled routes around the city as a bus driver.",
        gps = { x = 454.06, y = -622.56, z = 28.51 },
    },
    {
        label = "Vehicle Dealer",
        id = "cardealer",
        description = "Sell premium vehicles and handle finance agreements.",
        gps = { x = -45.67, y = -1098.34, z = 26.42 },
    },
    {
        label = "Mechanic",
        id = "mechanic",
        description = "Repair, upgrade, and customize vehicles in the workshop.",
        gps = { x = -211.55, y = -1324.55, z = 30.89 },
    },
    {
        label = "Law Firm",
        id = "lawyer",
        description = "Represent clients in court and handle legal paperwork.",
        gps = { x = -1905.71, y = -572.32, z = 19.09 },
    },
    {
        label = "Reporter",
        id = "reporter",
        description = "Capture the latest stories and keep the city informed.",
        gps = { x = -598.55, y = -929.75, z = 23.86 },
    },
    {
        label = "Trucker",
        id = "trucker",
        description = "Haul freight across San Andreas and keep businesses stocked.",
        gps = { x = -432.94, y = -2796.01, z = 6.0 },
    },
    {
        label = "Towing",
        id = "tow",
        description = "Recover stranded vehicles and keep traffic flowing smoothly.",
        gps = { x = -476.8, y = -1718.9, z = 19.69 },
    },
    {
        label = "Garbage",
        id = "garbage",
        description = "Collect the city's waste and maintain clean streets.",
        gps = { x = -319.23, y = -1545.41, z = 27.8 },
    },
    {
        label = "Vineyard",
        id = "vineyard",
        description = "Harvest grapes and produce quality wine.",
        gps = { x = -1885.82, y = 2048.0, z = 140.86 },
    },
    {
        label = "Hotdog",
        id = "hotdog",
        description = "Serve hot meals on the go to hungry citizens.",
        gps = { x = 36.09, y = -1003.27, z = 29.28 },
    },
    {
        label = "Miner",
        id = "miner",
        description = "Extract valuable minerals from the mines and supply the market.",
        gps = { x = 2947.43, y = 2793.18, z = 40.67 },
    },
}

ShowHelpNotification = function(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end
