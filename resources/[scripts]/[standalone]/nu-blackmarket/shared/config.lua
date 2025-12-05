-- Nu-Blackmarket Configuration
Config = {}

-- Debug mode (set to false for production)
Config.Debug = true

-- Ped Configuration
Config.Ped = {
    model = `g_m_m_chigoon_01`, -- Black market dealer ped model
    coords = vector4(1400.3207, 3641.8157, 27.9513, 225.4040), -- Default location (can be changed)
    scenario = "WORLD_HUMAN_SMOKING", -- Ped animation/scenario
    freeze = true, -- Should the ped be frozen in place
    invincible = true, -- Should the ped be invincible
    blockevents = true -- Should the ped ignore events
}

-- ox_target Configuration
Config.Target = {
    icon = "fas fa-shopping-cart",
    label = "Browse Black Market",
    distance = 2.5, -- Interaction distance
    debug = false -- ox_target debug mode
}

-- Currency Configuration
Config.Currency = {
    type = "black_money", -- Use dirty money item in ox_inventory
    removeType = "removeItem" -- Not currently used but kept for clarity
}

-- UI Configuration
Config.UI = {
    title = "Black Market",
    subtitle = "Illegal goods and services",
    maxCartItems = 10, -- Maximum items in cart
    showPrices = true,
    enableSounds = true
}

-- Black Market Items Configuration
Config.Items = {
    {
        category = "weapons",
        categoryLabel = "Premium Firearms",
        categoryIcon = "fas fa-crosshairs",
        items = {
            {
                name = "weapon_switchblade",
                label = "Switchblade",
                description = "Spring-assisted blade for quick close encounters.",
                price = 3000,
                image = "WEAPON_SWITCHBLADE.png",
                stock = 8,
                maxQuantity = 1
            },
            {
                name = "weapon_knife",
                label = "Tactical Knife",
                description = "Balanced combat knife with coated edge.",
                price = 2800,
                image = "WEAPON_KNIFE.png",
                stock = 8,
                maxQuantity = 1
            },
            {
                name = "extended_clip",
                label = "Extended Magazine",
                description = "High-capacity magazine for select SMGs and pistols.",
                price = 5000,
                image = "at_clip_extended.png",
                stock = 10,
                maxQuantity = 2
            },
            {
                name = "suppressor",
                label = "Threaded Suppressor",
                description = "Reduces muzzle flash and report on compatible weapons.",
                price = 8500,
                image = "at_suppressor.png",
                stock = 8,
                maxQuantity = 2
            },
            {
                name = "flashlight_attachment",
                label = "Weapon Flashlight",
                description = "Rail-mounted tactical light for low-light pushes.",
                price = 1000,
                image = "flashlight_attachment.png",
                stock = 15,
                maxQuantity = 3
            }
        }
    },
    {
        category = "tools",
        categoryLabel = "Lockbreaking Tools",
        categoryIcon = "fas fa-user-secret",
        items = {
            {
                name = "lockpick",
                label = "Lockpick",
                description = "Disposable pick kit for basic doors and gloveboxes.",
                price = 250,
                image = "lockpick.png",
                stock = 60,
                maxQuantity = 5
            },
            {
                name = "advancedlockpick",
                label = "Advanced Lockpick",
                description = "Precision kit with hardened bits for tougher locks.",
                price = 1200,
                image = "advancedlockpick.png",
                stock = 25,
                maxQuantity = 3
            },
            {
                name = "door_override_chip",
                label = "Door Override Chip",
                description = "Single-use implant that forces smart locks to cycle open.",
                price = 22000,
                image = "tunerchip.png",
                stock = 3,
                maxQuantity = 1
            }
        }
    },
    {
        category = "gadgets",
        categoryLabel = "Explosives & Gadgets",
        categoryIcon = "fas fa-bolt",
        items = {
            {
                name = "handcuff_keys",
                label = "Handcuff Keys",
                description = "Universal keys for standard-issue cuffs.",
                price = 5000,
                image = "WEAPON_HANDCUFFS.PNG",
                stock = 8,
                maxQuantity = 2
            }
        }
    },
    {
        category = "rare",
        categoryLabel = "Underworld Exclusives",
        categoryIcon = "fas fa-gem",
        items = {
            {
                name = "blackmarket_pass",
                label = "Blackmarket Credential",
                description = "Proof you belong in the underground network.",
                price = 35000,
                image = "certificate.png",
                stock = 2,
                maxQuantity = 1
            },
            {
                name = "forged_license",
                label = "Forged Business License",
                description = "Used to front sham companies or laundering fronts.",
                price = 9000,
                image = "driver_license.png",
                stock = 5,
                maxQuantity = 1
            },
            {
                name = "goldbar",
                label = "Gold Bar",
                description = "High-value bullion for off-book trades.",
                price = 15000,
                image = "goldbar.png",
                stock = 8,
                maxQuantity = 2
            },
            {
                name = "stolen_art",
                label = "Stolen Artwork",
                description = "Priceless art piece destined for a private collection.",
                price = 55000,
                image = "painting.png",
                stock = 1,
                maxQuantity = 1
            },
            {
                name = "mystery_package",
                label = "Mystery Package",
                description = "Sealed crate containing a random illicit good.",
                price = 8000,
                image = "antiquevase.png",
                stock = 4,
                maxQuantity = 2
            }
        }
    },
    {
        category = "supplies",
        categoryLabel = "Chemicals & Packaging",
        categoryIcon = "fas fa-flask",
        items = {
            {
                name = "empty_weed_bag",
                label = "Empty Baggies",
                description = "Packaging to portion street-ready product.",
                price = 65,
                image = "weed_baggy_empty.png",
                stock = 200,
                maxQuantity = 50
            },
            {
                name = "acetone",
                label = "Industrial Acetone",
                description = "Solvent used for cooking high-grade product.",
                price = 140,
                image = "acetone.png",
                stock = 80,
                maxQuantity = 10
            },
            {
                name = "ephedrine",
                label = "Ephedrine Powder",
                description = "Key precursor for crystal meth production.",
                price = 260,
                image = "ephedrine.png",
                stock = 60,
                maxQuantity = 8
            }
        }
    }
}

-- Job Restrictions (optional - leave empty table {} to allow all players)
Config.JobRestrictions = {
    -- Example: only allow certain jobs to access the black market
    -- "police", -- This would BLOCK police from accessing
    -- Add job names to block them from accessing the black market
}

-- Time Restrictions (optional)
Config.TimeRestrictions = {
    enabled = false, -- Set to true to enable time restrictions
    startHour = 22, -- 10 PM
    endHour = 6 -- 6 AM
}

-- Webhook Configuration (for logging purchases)
Config.Webhook = {
    enabled = true, -- Set to true to enable Discord logging
    url = "https://discord.com/api/webhooks/1436077269373161483/dq6lK1VBQi1dRpqQVE499rhdZZ5szTyyhDum1GYbhrsW_mDG86A4ySXDof3TOSNwgpr9", -- Your Discord webhook URL
    color = 16711680, -- Red color
    title = "Black Market Purchase",
    footer = "Nu-Blackmarket System"
}

-- Stock Refresh Configuration
Config.StockRefresh = {
    enabled = true, -- Should stock refresh automatically
    interval = 60, -- Minutes between stock refresh
    percentage = 0.5 -- Percentage of max stock to restore (0.5 = 50%)
} 