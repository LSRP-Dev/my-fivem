Config = Config or {}

Config.QBCoreName = 'qbx-core' -- This is your Core Name (qb-core or qbx-core)
Config.QBInventoryName = 'ox_inventory' -- This is your QB Inventory name (don't need to be qb-inventory just need to be a QBCore compatible inventory)
Config.QBTargetName = 'ox_target' -- This is your QB Target resource name
Config.QBVehicleKeysName = 'qbx-vehiclekeys' -- This is your QB Vehicle Keys resource name
Config.UsingVehicleKeys = true -- If you're not using qbx-vehiclekeys or qb-vehiclekyes just turn this to false
Config.QBRadialMenuName = 'ox_lib' -- This is you QB Radial Menu resource name
Config.LegacyFuelName = 'LegacyFuel' -- This is you fuel system resource name
Config.DebugPoly = false -- If true all polyzones debug will be active
Config.RepairPercentage = 5 -- This is the vehicle percentage price for repair
Config.ToolBoxProp = `prop_tool_box_04`
Config.PaymentRadius = 20 -- How distance register get players
Config.QBManagementName = 'qbx-management'
Config.ComissionBill = 2 -- This is the percentage that the biller will receive when billing a player
Config.DiagnosticOnlyAtWorkshop = false -- With this at true you only can use the target at vehicle if inside the workshop zone
Config.NeededHealthToRepair = 990.0 -- This is how much vehicle health you need to be under to be able to repair it
Config.UseItemsMultiplier = true -- This is the repair items multiplier, if true the items needed amount will variable on the engine health
Config.ImagesDirectory = "nui://ox_inventory/web/images/"

Config.NitrousKey = 36 -- Key that you need to press to active nitrousS
Config.NitoursCooldown = 5000 -- Cooldown that you'll get after use nitrous
Config.NitrousBoost = 20.0 -- The speed boost percentage that nitrous will grow the vehicle speed
Config.NitrousMxSpeed = 350.0 -- Max speed that the vehicle will get with nitrous installed
Config.NitrousParticlesSize = 2.0 -- Size of nitrous particles
Config.UpdateNitrousLevel = 0.5 -- Nitrous update level is the speed that the hud will update the nitrous

Config.ToolBoxStashWeight = 15000 -- This is the weight of stash in toolbox
Config.ToolBoxStashSlots = 10 -- This is the amount of slots of stash in toolbox

Config.AuthorizedDiagnostic = { -- This are the jobs with access to remove and repair options in vehicle
    [1] = 'mechanic',
    [2] = 'ottos',
}

Config.InstallModsAuthorized = { -- This are the jobs with access to install vehicle parts
    [1] = 'mechanic',
    [2] = 'ottos',
}

Config.ShopsLocations = {
    [1] = { AuthorizedJob = 'mechanic', Coords = vector3(837.18, -808.27, 26.33), Lenght = 1.8, Width = 1 }, -- AuthorizedJob is the job that can access that location and the coords is the coordinates for that location
}

Config.CraftingLocations = {
    [1] = { AuthorizedJob = 'mechanic', Coords = vector3(837.05, -819.4, 26.33), Lenght = 2, Width = 1 }, -- AuthorizedJob is the job that can access that location and the coords is the coordinates for that location
}

Config.WorkshopZones = {
    [1] = { -- This is the ID that need to be unique
        Job = 'mechanic', -- Authorized Job
        Coords = vector3(831.99, -813.0, 26.33), -- Locations
        Length = 18.2, -- The location Length
        Width = 8.8, -- The location Width
        Heading = 0, -- The location Heading
    },
}

Config.StationsZones = { -- This are the locations to preview and repair zones
    [1] = { -- This is the ID that need to be unique
        Job = 'mechanic', -- Authorized Job if "all" everyone can access
        Coords = vector3(831.99, -813.0, 26.33), -- Locations
        Length = 18.2, -- The location Length
        Width = 8.8, -- The location Width
        Heading = 0, -- The location Heading
        Options = {
            Preview = true, -- If true will have access to preview
            Repair = true, -- If true will have access to repair
        },
    },
    [2] = {
        Job = 'all',
        Coords = vector3(803.01, -811.11, 26.21),
        Length = 13.8,
        Width = 14.6,
        Heading = 0,
        Options = {
            Preview = true,
            Repair = false,
        },
    },
    [3] = {
        Job = 'all',
        Coords = vector3(832.25, -790.0, 26.28),
        Length = 19.4,
        Width = 9.4,
        Heading = 20,
        Options = {
            Preview = false,
            Repair = true,
        },
    },
}

Config.JobLocations = { -- This are the jobs locations 
    GaragesLocations = { -- This is the locations to garage
        [1] = { -- The station ID (need to be unique)
            Vehicles = { -- The list of vehicle
                [1] = { -- Vehicle ID (need to be unique)
                    VehicleDescription = 'This is a good tow truck to your work.', -- The descript that will show at garage menu
                    VehicleName = 'Tow Truck', -- The name of the vehicle that will show at menu
                    VehicleSpawnName = 'towtruck', -- The vehicle spawn name
                },
                [2] = {
                    VehicleDescription = 'This is a good vehicle to chill.',
                    VehicleName = 'Karin Sultan',
                    VehicleSpawnName = 'sultan',
                },
            },
            Location = { x = 830.9, y = -800.27, z = 26.28, h = 355.03 }, -- The prop location
            SpawnLocation = vector4(834.41, -791.98, 26.29, 119.95), -- The vehicle spawn location
            Job = 'mechanic', -- The job that will have access to the garage
        },
    },
    Stashes = { -- This is the stashes locations
        [1] = {
            Job = 'mechanic', -- This is the authorized job to access this stash
            Name = 'main_stash', -- This is the name of the stash (need to be unique!)
            Weigth = 400000, -- This is the weigth od the stash
            Slots = 300, -- This are the slots that stash will have
            Coords = vector3(837.21, -813.65, 26.33), -- This is the coords of the stash
            Length = 1.2, -- This the length for polyzone
            Width = 1, -- This is the width for the polyzone
        },
    },
    Duty = { -- This is the toggle duty & registers location
        mechanic = {
            Job = 'mechanic',
            Coords = vector3(835.1, -827.43, 26.33), -- This is the location to duty
            Length = 0.6, -- This the length for polyzone
            Width = 0.4, -- This is the width for the polyzone 
        },
    },
    Blips = {
        [1] = { blipvariantid = OttosBlip, blipcolour = 5, blipsprite = 72, blipdisplay = 2, blipscale = 0.5, blipcoords = vector3(817.14, -811.11, 26.18), blipname = "Otto's Auto" },
    },
}

Config.ShopItems = { -- This are the items that will show at shop
    [1] = { ItemName = 'mechanic_washing_kit', ItemPrice = 100 }, -- ItemName is the item spawn name and the ItemPrice is the item price
    [2] = { ItemName = 'mechanic_engine_lvl1', ItemPrice = 10000 },
    [3] = { ItemName = 'mechanic_engine_lvl2', ItemPrice = 20000 },
    [4] = { ItemName = 'mechanic_engine_lvl3', ItemPrice = 30000 },
    [5] = { ItemName = 'mechanic_engine_lvl4', ItemPrice = 40000 },
    [6] = { ItemName = 'mechanic_transmission_lvl1', ItemPrice = 15000 },
    [7] = { ItemName = 'mechanic_transmission_lvl2', ItemPrice = 25000 },
    [8] = { ItemName = 'mechanic_transmission_lvl3', ItemPrice = 35000 },
    [9] = { ItemName = 'mechanic_suspension_lvl1', ItemPrice = 5000 },
    [10] = { ItemName = 'mechanic_suspension_lvl2', ItemPrice = 10000 },
    [11] = { ItemName = 'mechanic_suspension_lvl3', ItemPrice = 15000 },
    [12] = { ItemName = 'mechanic_suspension_lvl4', ItemPrice = 20000 },
    [13] = { ItemName = 'mechanic_turbo', ItemPrice = 20000 },
    [14] = { ItemName = 'mechanic_tools', ItemPrice = 100 },
    [15] = { ItemName = 'mechanic_toolbox', ItemPrice = 1000 },
    [16] = { ItemName = 'mechanic_armor', ItemPrice = 10000 },
    [17] = { ItemName = 'mechanic_neons_controller', ItemPrice = 5000 },
    [18] = { ItemName = 'mechanic_brakes_lvl1', ItemPrice = 15000 },
    [19] = { ItemName = 'mechanic_brakes_lvl2', ItemPrice = 25000 },
    [20] = { ItemName = 'mechanic_brakes_lvl3', ItemPrice = 30000 },
    [21] = { ItemName = 'mechanic_plate', ItemPrice = 1000 },
    [22] = { ItemName = 'mechanic_window_tint', ItemPrice = 1000 },
    [23] = { ItemName = 'mechanic_livery', ItemPrice = 1000 },
    [24] = { ItemName = 'mechanic_drift_tyres', ItemPrice = 5000 },
    [25] = { ItemName = 'mechanic_wheels', ItemPrice = 15000 },
    [26] = { ItemName = 'mechanic_bumpers', ItemPrice = 15000 },
    [27] = { ItemName = 'mechanic_bonnet', ItemPrice = 15000 },
    [28] = { ItemName = 'mechanic_skirt', ItemPrice = 15000 },
    [29] = { ItemName = 'mechanic_spoiler', ItemPrice = 15000 },
    [30] = { ItemName = 'mechanic_exhaust', ItemPrice = 15000 },
    [31] = { ItemName = 'mechanic_grill', ItemPrice = 5000 },
    [32] = { ItemName = 'mechanic_horn', ItemPrice = 1000 },
    [33] = { ItemName = 'mechanic_nitrous', ItemPrice = 5000 },
    [34] = { ItemName = 'mechanic_roof', ItemPrice = 5000 },
    [35] = { ItemName = 'mechanic_extras', ItemPrice = 1000 },
    [36] = { ItemName = 'mechanic_interior', ItemPrice = 1000 },
    [37] = { ItemName = 'mechanic_exterior', ItemPrice = 1000 },
}

Config.RepairNeededItems = { -- This is the items that you need to repair the vehicle (The amount change with vehicle health level, if vehicle health < 99% then the amount will be the NeededAmount, if vehicle health < 700 then the amount will be the NeededAmount * 2 and if vehicle health < 30 then the amount will be the NeededAmount * 4)
    [1] = { ItemName = 'aluminum', NeededAmount = 2 },
    [2] = { ItemName = 'iron', NeededAmount = 2 },
    [3] = { ItemName = 'plastic', NeededAmount = 4 },
    [4] = { ItemName = 'rubber', NeededAmount = 2 },
}

Config.Crafting = { -- This are the items that will show at crafting menu
    [1] = { 
        ItemName = 'mechanic_paint_spray', -- ItemName is the item spawn name
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 5 }, -- Name is the item spawn name and Quantity is the amount that you need
            [2] = { Name = 'plastic', Quantity = 5 },
        },
    },
    [2] = { 
        ItemName = 'mechanic_engine_lvl1',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 5 },
            [2] = { Name = 'plastic', Quantity = 5 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 10 },
            [5] = { Name = 'rubber', Quantity = 2 },
        },
    },
    [3] = { 
        ItemName = 'mechanic_engine_lvl2',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 15 },
            [2] = { Name = 'plastic', Quantity = 15 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 20 },
            [5] = { Name = 'rubber', Quantity = 4 },
        },
    },
    [4] = { 
        ItemName = 'mechanic_engine_lvl3',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 25 },
            [2] = { Name = 'plastic', Quantity = 25 },
            [3] = { Name = 'iron', Quantity = 25 },
            [4] = { Name = 'steel', Quantity = 40 },
            [5] = { Name = 'rubber', Quantity = 20 },
        },
    },
    [5] = { 
        ItemName = 'mechanic_engine_lvl4',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [6] = { 
        ItemName = 'mechanic_transmission_lvl1',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 5 },
            [2] = { Name = 'plastic', Quantity = 5 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 10 },
        },
    },
    [7] = { 
        ItemName = 'mechanic_transmission_lvl2',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 15 },
            [2] = { Name = 'plastic', Quantity = 15 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 20 },
        },
    },
    [8] = { 
        ItemName = 'mechanic_transmission_lvl3',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 25 },
            [2] = { Name = 'plastic', Quantity = 25 },
            [3] = { Name = 'iron', Quantity = 25 },
            [4] = { Name = 'steel', Quantity = 40 },
        },
    },
    [9] = { 
        ItemName = 'mechanic_suspension_lvl1',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 5 },
            [2] = { Name = 'plastic', Quantity = 5 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 10 },
            [5] = { Name = 'rubber', Quantity = 2 },
        },
    },
    [10] = { 
        ItemName = 'mechanic_suspension_lvl2',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 15 },
            [2] = { Name = 'plastic', Quantity = 15 },
            [3] = { Name = 'iron', Quantity = 15 },
            [4] = { Name = 'steel', Quantity = 20 },
            [5] = { Name = 'rubber', Quantity = 4 },
        },
    },
    [11] = { 
        ItemName = 'mechanic_suspension_lvl3',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 25 },
            [2] = { Name = 'plastic', Quantity = 25 },
            [3] = { Name = 'iron', Quantity = 25 },
            [4] = { Name = 'steel', Quantity = 40 },
            [5] = { Name = 'rubber', Quantity = 20 },
        },
    },
    [12] = { 
        ItemName = 'mechanic_suspension_lvl4',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [13] = { 
        ItemName = 'mechanic_turbo',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [14] = { 
        ItemName = 'mechanic_armor',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [15] = { 
        ItemName = 'mechanic_brakes_lvl1',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [16] = { 
        ItemName = 'mechanic_brakes_lvl2',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [17] = { 
        ItemName = 'mechanic_brakes_lvl3',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'plastic', Quantity = 45 },
            [3] = { Name = 'iron', Quantity = 34 },
            [4] = { Name = 'steel', Quantity = 21 },
            [5] = { Name = 'rubber', Quantity = 10 },
        },
    },
    [18] = { 
        ItemName = 'mechanic_drift_tyres',
        NeededItems = { 
            [1] = { Name = 'rubber', Quantity = 20 },
        },
    },
    [19] = { 
        ItemName = 'mechanic_wheels',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'steel', Quantity = 21 },
        },
    },
    [20] = { 
        ItemName = 'mechanic_bumpers',
        NeededItems = { 
            [1] = { Name = 'plastic', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [21] = { 
        ItemName = 'mechanic_bonnet',
        NeededItems = { 
            [1] = { Name = 'plastic', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [22] = { 
        ItemName = 'mechanic_skirt',
        NeededItems = { 
            [1] = { Name = 'plastic', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [23] = { 
        ItemName = 'mechanic_spoiler',
        NeededItems = { 
            [1] = { Name = 'plastic', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [24] = { 
        ItemName = 'mechanic_exhaust',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'iron', Quantity = 21 },
        },
    },
    [25] = { 
        ItemName = 'mechanic_grill',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [26] = { 
        ItemName = 'mechanic_horn',
        NeededItems = { 
            [1] = { Name = 'aluminum', Quantity = 45 },
            [2] = { Name = 'rubber', Quantity = 21 },
        },
    },
    [27] = { 
        ItemName = 'mechanic_nitrous',
        NeededItems = { 
            [1] = { Name = 'mechanic_nitrous_empty', Quantity = 5 },
            [2] = { Name = 'rubber', Quantity = 2 },
            [3] = { Name = 'plastic', Quantity = 2 },
        },
    },
}

Config.Times = { -- This is the times for progressbars making anything
    RepairTime = 10000,
    PaintTime = 10000,
    WashTime = 5000,
    CraftingTime = 7500,
    EngineTime = 7500,
    CheckTuneTime = 10000,
    TransmissionTime = 7500,
    SuspensionTime = 7500,
    TurboTime = 7500,
    CheckHealthTime = 10000,
    RepairEngineTime = 10000,
    RepairBodyTime = 10000,
    ArmorTime = 7500,
    RemovingTuningTime = 10000,
    BrakesTime = 7500,
    PlateTime = 7500,
    WindowTintTime = 7500,
    DriftTyresTime = 7500,
    WheelsTime = 7500,
    NitrousTime = 7500,
    TyreSmokeTime = 7500,
    InstallingCosmeticTime = 5000,
} 

Config.NeonColours = { -- Available Neon and Xenon colours (Can add as many as you want)
    [1] = { Label = 'Red', RGBCode = { R = 255, G = 0, B = 0 } }, -- Label is the name that will show at menu, RGBCode is basicly the color rgb code, R to Red G to Green and B to Blue
    [2] = { Label = 'White', RGBCode = { R = 255, G = 255, B = 255 } },
    [3] = { Label = 'Blue', RGBCode = { R = 2, G = 21, B = 255 } },
    [4] = { Label = 'Electric Blue', RGBCode = { R = 3, G = 83, B = 255 } },
    [5] = { Label = 'Mint Green', RGBCode = { R = 0, G = 222, B = 140 } },
    [6] = { Label = 'Lime Green', RGBCode = { R = 94, G = 255, B = 1 } },
    [7] = { Label = 'Golden Shower', RGBCode = { R = 255, G = 62, B = 0 } },
    [8] = { Label = 'Orange', RGBCode = { R = 255, G = 62, B = 0 } },
    [9] = { Label = 'Pony Pink', RGBCode = { R = 255, G = 50, B = 100 } },
    [10] = { Label = 'Hot Pink', RGBCode = { R = 255, G = 5, B = 190 } },
    [11] = { Label = 'Purple', RGBCode = { R = 35, G = 1, B = 255 } },
    [12] = { Label = 'BlackLight', RGBCode = { R = 15, G = 3, B = 255 } },
    [13] = { Label = 'Yellow', RGBCode = { R = 255, G = 221, B = 0 } },
}

Config.WheelCategories = { -- Don't change the numbers, just translate the Label!!
    [1] = {Label = 'Sport'},
    [2] = {Label = 'Muscle'},
    [3] = {Label = 'Lowrider'},
    [4] = {Label = 'SUV'},
    [5] = {Label = 'OffRoad'},
    [6] = {Label = 'Tuner'},
    [7] = {Label = 'Bike'},
    [8] = {Label = 'High End'},
    [9] = {Label = "Benny's Orignal"},
    [10] = {Label = "Benny's Bespoke"},
    [11] = {Label = "Open Wheel"},
    [12] = {Label = 'Street'},
    [13] = {Label = 'Track'},
}

Config.Colours = {
    Metallic = {
        [1] = { Label = 'Black', Number = 0 }, -- Label is the name that shows up at menu and the Number is the color hash number from GTA
        [2] = { Label = 'Carbon Black', Number = 147 },
        [3] = { Label = 'Graphite', Number = 1 },
        [4] = { Label = 'Anhracite Black', Number = 11 },
        [5] = { Label = 'Black Steel', Number = 2 },
        [6] = { Label = 'Dark Steel', Number = 3 },
        [7] = { Label = 'Silver', Number = 4 },
        [8] = { Label = 'Bluish Silver', Number = 5 },
        [9] = { Label = 'Rolled Steel', Number = 6 },
        [10] = { Label = 'Shadow Silver', Number = 7 },
        [11] = { Label = 'Stone Silver', Number = 8 },
        [12] = { Label = 'Midnight Silver', Number = 9 },
        [13] = { Label = 'Cast Iron Silver', Number = 10 },
        [14] = { Label = 'Red', Number = 27 },
        [15] = { Label = 'Torino Red', Number = 28 },
        [16] = { Label = 'Formula Red', Number = 29 },
        [17] = { Label = 'Lava Red', Number = 150 },
        [18] = { Label = 'Blaze Red', Number = 30 },
        [19] = { Label = 'Grace Red', Number = 31 },
        [20] = { Label = 'Garnet Red', Number = 32 },
        [21] = { Label = 'Sunset Red', Number = 33 },
        [22] = { Label = 'Cabernet Red', Number = 34 },
        [23] = { Label = 'Wine Red', Number = 143 },
        [24] = { Label = 'Candy Red', Number = 35 },
        [25] = { Label = 'Hot Pink', Number = 135 },
        [26] = { Label = 'Pfsiter Pink', Number = 137 },
        [27] = { Label = 'Salmon Pink', Number = 136 },
        [28] = { Label = 'Sunrise Orange', Number = 36 },
        [29] = { Label = 'Orange', Number = 38 },
        [30] = { Label = 'Bright Orange', Number = 138 },
        [31] = { Label = 'Gold', Number = 99 },
        [32] = { Label = 'Bronze', Number = 90 },
        [33] = { Label = 'Yellow', Number = 88 },
        [34] = { Label = 'Race Yellow', Number = 89 },
        [35] = { Label = 'Dew Yellow', Number = 91 },
        [36] = { Label = 'Dark Green', Number = 49 },
        [37] = { Label = 'Racing Green', Number = 50 },
        [38] = { Label = 'Sea Green', Number = 51 },
        [39] = { Label = 'Olive Green', Number = 52 },
        [40] = { Label = 'Bright Green', Number = 53 },
        [41] = { Label = 'Gasoline Green', Number = 54 },
        [42] = { Label = 'Lime Green', Number = 92 },
        [43] = { Label = 'Midnight Blue', Number = 141 },
        [44] = { Label = 'Galaxy Blue', Number = 61 },
        [45] = { Label = 'Dark Blue', Number = 62 },
        [46] = { Label = 'Saxon Blue', Number = 63 },
        [47] = { Label = 'Blue', Number = 64 },
        [48] = { Label = 'Mariner Blue', Number = 65 },
        [49] = { Label = 'Harbor Blue', Number = 66 },
        [50] = { Label = 'Diamond Blue', Number = 67 },
        [51] = { Label = 'Surf Blue', Number = 68 },
        [52] = { Label = 'Nautical Blue', Number = 69 },
        [53] = { Label = 'Racing Blue', Number = 73 },
        [54] = { Label = 'Ultra Blue', Number = 70 },
        [55] = { Label = 'Light Blue', Number = 74 },
        [56] = { Label = 'Chocolate Brown', Number = 96 },
        [57] = { Label = 'Bison Brown', Number = 101 },
        [58] = { Label = 'Creeen Brown', Number = 95 },
        [59] = { Label = 'Feltzer Brown', Number = 94 },
        [60] = { Label = 'Maple Brown', Number = 97 },
        [61] = { Label = 'Beechwood Brown', Number = 103 },
        [62] = { Label = 'Sienna Brown', Number = 104 },
        [63] = { Label = 'Saddle Brown', Number = 98 },
        [64] = { Label = 'Moss Brown', Number = 100 },
        [65] = { Label = 'Woodbeech Brown', Number = 102 },
        [66] = { Label = 'Straw Brown', Number = 99 },
        [67] = { Label = 'Sandy Brown', Number = 105 },
        [68] = { Label = 'Bleached Brown', Number = 106 },
        [69] = { Label = 'Schafter Purple', Number = 71 },
        [70] = { Label = 'Spinnaker Purple', Number = 72 },
        [71] = { Label = 'Midnight Purple', Number = 142 },
        [72] = { Label = 'Bright Purple', Number = 145 },
        [73] = { Label = 'Cream', Number = 107 },
        [74] = { Label = 'Ice White', Number = 111 },
        [75] = { Label = 'Frost White', Number = 112 },
    },
    Matte = {
        [1] = { Label = 'Black', Number = 12 },  
        [2] = { Label = 'Gray', Number = 13 },  
        [3] = { Label = 'Light Gray', Number = 14 }, 
        [4] = { Label = 'Ice White', Number = 131 },
        [5] = { Label = 'Blue', Number = 83 }, 
        [6] = { Label = 'Dark Blue', Number = 82 },
        [7] = { Label = 'Midnight Blue', Number = 84 },
        [8] = { Label = 'Midnight Purple', Number = 149 },
        [9] = { Label = 'Schafter Purple', Number = 148 },
        [10] = { Label = 'Red', Number = 39 },
        [11] = { Label = 'Dark Red', Number = 40 },
        [12] = { Label = 'Orange', Number = 41 },
        [13] = { Label = 'Yellow', Number = 42 },
        [14] = { Label = 'Lime Green', Number = 55 },
        [15] = { Label = 'Green', Number = 128 },
        [16] = { Label = 'Forest Green', Number = 151 },
        [17] = { Label = 'Foliage Green', Number = 155 },
        [18] = { Label = 'Olive Darb', Number = 152 },
        [19] = { Label = 'Dark Earth', Number = 153 },
        [20] = { Label = 'Desert Tan', Number = 154 },
    },
    Metals = {
        [1] = { Label = 'Brushed Steel', Number = 117 },
        [2] = { Label = 'Brushed Black Steel', Number = 118 },
        [3] = { Label = 'Brushed Aluminum', Number = 119 },
        [4] = { Label = 'Pure Gold', Number = 158 },
        [5] = { Label = 'Brushed Gold', Number = 159 },
    },
    Chameleon = { -- (Colors Credits to https://www.gta5-mods.com/misc/chameleon-paint-add-on)
        [1] = { Label = 'Anod Red', Number = 161 },
        [2] = { Label = 'Anod Wine', Number = 162 },
        [3] = { Label = 'Anod Purple', Number = 163 },
        [4] = { Label = 'Anod Blue', Number = 164 },
        [5] = { Label = 'Anod Green', Number = 165 },
        [6] = { Label = 'Anod Lime', Number = 166 },
        [7] = { Label = 'Anod Copper', Number = 167 },
        [8] = { Label = 'Anod Bronze', Number = 168 },
        [9] = { Label = 'Anod Champagne', Number = 169 },
        [10] = { Label = 'Anod Gold', Number = 170 },
        [11] = { Label = 'Green Blue Flip', Number = 171 },
        [12] = { Label = 'Green Red Flip', Number = 172 },
        [13] = { Label = 'Green Brow Flip', Number = 173 },
        [14] = { Label = 'Green Turq Flip', Number = 174 },
        [15] = { Label = 'Green Purp Flip', Number = 175 },
        [16] = { Label = 'Teal Red Flip', Number = 176 },
        [17] = { Label = 'Turq Red Flip', Number = 177 },
        [18] = { Label = 'Turq Purp Flip', Number = 178 },
        [19] = { Label = 'Cyan Puro Flip', Number = 179 },
        [20] = { Label = 'Blue Pink Flip', Number = 180 },
        [21] = { Label = 'Blue Green Flip', Number = 181 },
        [22] = { Label = 'Purp Red Flip', Number = 182 },
        [23] = { Label = 'Purp Green Flip', Number = 183 },
        [24] = { Label = 'Magen Gree Flip', Number = 184 },
        [25] = { Label = 'Magen Yell Flip', Number = 185 },
        [26] = { Label = 'Burg Green Flip', Number = 186 },
        [27] = { Label = 'Magen Cyan Flip', Number = 187 },
        [28] = { Label = 'Coppe Purp Flip', Number = 188 },
        [29] = { Label = 'Magen Orange Flip', Number = 189 },
        [30] = { Label = 'Red Orange Flip', Number = 190 },
        [31] = { Label = 'Orange Purp Flip', Number = 191 },
        [32] = { Label = 'Orange Blue Flip', Number = 192 },
        [33] = { Label = 'White Purp Flip', Number = 193 },
        [34] = { Label = 'Red Rainbow Flip', Number = 194 },
        [35] = { Label = 'Blue Rainbow Flip', Number = 195 },
        [36] = { Label = 'Dark Green Pearl', Number = 196 },
        [37] = { Label = 'Dark Teal Pearl', Number = 197 },
        [38] = { Label = 'Dark Blue Pearl', Number = 198 },
        [39] = { Label = 'Dar Purple Pearl', Number = 199 },
        [40] = { Label = 'Oil Slick Pearl', Number = 200 },
        [41] = { Label = 'Lit Green Pearl', Number = 201 },
        [42] = { Label = 'Lit Blue Pearl', Number = 202 },
        [43] = { Label = 'Lit Purp Pearl', Number = 203 },
        [44] = { Label = 'Lit Pink Pearl', Number = 204 },
        [45] = { Label = 'Offwhite Prisma', Number = 205 },
        [46] = { Label = 'Pink Pearl', Number = 206 },
        [47] = { Label = 'Yellow Pearl', Number = 207 },
        [48] = { Label = 'Green Pearl', Number = 208 },
        [49] = { Label = 'Blue Pearl', Number = 209 },
        [50] = { Label = 'Cream Pearl', Number = 210 },
        [51] = { Label = 'White Prisma', Number = 211 },
        [52] = { Label = 'Graphite Prisma', Number = 212 },
        [53] = { Label = 'Dark Blue Prisma', Number = 213 },
        [54] = { Label = 'Dark Purple Prisma', Number = 214 },
        [55] = { Label = 'Hot Pink Prisma', Number = 215 },
        [56] = { Label = 'Red Prisma', Number = 216 },
        [57] = { Label = 'Green Prisma', Number = 217 },
        [58] = { Label = 'Black Prisma', Number = 218 },
        [59] = { Label = 'Oil Slic Prisma', Number = 219 },
        [60] = { Label = 'Rainbow Prisma', Number = 220 },
        [61] = { Label = 'Black Holo', Number = 221 },
        [62] = { Label = 'White Holo', Number = 222 },
    },
}