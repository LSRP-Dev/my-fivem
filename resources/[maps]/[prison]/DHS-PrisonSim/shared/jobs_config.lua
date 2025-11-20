JobsConfig = {}

JobsConfig.MetalShop = {
    coords = vec3(1590.85, 2560.75, 46.0),
    size = vec3(14.85, 8.5, 4.0),
    rotation = 0.0,
    ProgressBarSettings = {
        CuttingMetal = {
            duration = 3000,
        },
        LicensePlateEngraving = {
            duration = 10000,
        }
    },
    AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
    AmountofMoneyGivenPerPlate = 2,
}

JobsConfig.WoodShop = {
    coords = vec3(1575.0, 2548.0, 46.0),
	size = vec3(19.0, 6.0, 4.0),
	rotation = 0.0,
    ProgressBarSettings = {
        CuttingWood = {
            duration = 3000,
        },
        CraftingWoodenChair = {
            duration = 10000,
        },
        CraftingWoodenTable = {
            duration = 10000,
        },
        CraftingWoodenStorage = {
            duration = 10000,
        }
    },
    AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
    AmountofMoneyGivenPerFurniture = 2,
}

JobsConfig.Laundry = {
    coords = vec3(1593.0, 2542.0, 46.0),
	size = vec3(10.0, 16.0, 4.0),
	rotation = 0.0,
    ProgressBarSettings = {
        UsingLaundryWasher = {
            duration = 10000,
        },
        UsingLaundryDryer = {
            duration = 10000,
        },
        UsingLaundryFolding = {
            duration = 10000,
        },
    },
    AmountOfTimeTakenOffSentence = 1, -- This is based off the time metric in config.lua
    AmountofMoneyGivenPerFurniture = 2,
}