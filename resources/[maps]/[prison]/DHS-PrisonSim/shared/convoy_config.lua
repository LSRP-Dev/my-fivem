ConvoyConfig = {}

ConvoyConfig.PrisonCoords = vector4(1673.45, 2602.86, 45.17, 90.3)
---fuck
ConvoyConfig.isEnabled = false                       -- Toggle This To False If You Do Not Want To Use The Convoy System At All (Will Skip Convoy Creation and Send to Prison)
ConvoyConfig.isAIConvoyEnabled = true               -- Toggle This To False If You Do Not Want To Use The AI Convoy System (Players Will Have To Drive Prisoners To The Prison)
ConvoyConfig.isConvoySkippableOptionEnabled = false -- Toggle This To False If You Do Not Want The Convoy To Be Skippable in Options (Can only be turned on if isAIConvoyEnabled is false)
ConvoyConfig.IllegalCallChance = 100                -- The Chance Of The Police Calling The Convoy (1-100)
ConvoyConfig.FreezePlayer = true -- If true, the script will handle stopping the player from leaving the convoy, if false you will have to handle it yourself in editablefunctions_cl.lua however this could allow you to let prisoners escape the convoy
ConvoyConfig.ConvoySpawnTimer = 2000 -- This should only be modified if your convoy is not spawning.

ConvoyConfig.ConvoySetupSettings = {
    pedEnabled = false, -- If Ped is Disabled use the export in the documentation to open the convoy menu
    convoyLeaderSpeed = 20.0,
    convoySpeed = 100.0,
    convoyTrafficFlags = 524348, -- change this here https://forge.plebmasters.de/vehicleflags?category=DrivingStyleFlags&value=787004
    pedModel = "s_m_y_cop_01",
    pedCoords = vector4(1822.800, 3695.541, 28.655, 153.7)
}

ConvoyConfig.Vehicles = {
    { model = "hard23charger", position = "ahead",   leader = true, offset = 0 },
    { model = "pbus",    position = "default", offset = 10 },
    { model = "hard23charger",    position = "behind", offset = 20 },
}

ConvoyConfig.Coordinates = {
    policeStationCoords = vector4(1801.814, 3655.216, 34.312, 210.1), -- Police Station Coords (Must Be Within 100M of the Ped If Using The Ped)
}

ConvoyConfig.Routes = {
    {
        name = "Route #1",
        coords = {
            [1] = {
                coords = vector4(1797.754, 3665.458, 33.919, 209.2),
                finalCoord = false,
                waitTime = 0
            },
            [2] = {
                coords = vector4(1910.272, 2609.058, 45.840, 75.84),
                finalCoord = false,
                waitTime = 1000
            },
            [3] = {
                coords = vector4(1880.407, 2609.065, 45.339, 82.39),
                finalCoord = false,
                unlockDoor = "FrontGate1",
                waitTime = 1000
            },
            [4] = {
                coords = vector4(1825.765, 2608.437, 45.590, 89.11),
                finalCoord = false,
                unlockDoor = "FrontGate2",
                waitTime = 1000
            },
            [5] = {
                coords = vector4(1697.464, 2604.929, 45.564, 87.97),
                finalCoord = true,
                waitTime = 0
            }
        }
    }

}
