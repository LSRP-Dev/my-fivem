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
        description = "Leave the workforce and live on your own terms.",
        gps = { x = -266.55, y = -960.97, z = 31.22 },
    },
    {
        label = "Trucker Depot",
        id = "trucker",
        description = "Clock in at the South Docks depot to start running freight routes.",
        gps = { x = 839.24, y = -2923.90, z = 5.89 },
    },
    {
        label = "Prospect Mining Co.",
        id = "miner",
        description = "Visit the quarry to mine ore and refine valuable materials.",
        gps = { x = -596.74, y = 2090.99, z = 131.41 },
    },
}

ShowHelpNotification = function(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, false, true, -1)
end
