ClothingConfig = {}

--Read This For More Info https://docs.fivem.net/natives/?_0x262B14F48D29DE80
ClothingConfig.ClothingSettings = {
    removeClothingAnimations = {
        -- Top
        [11] = {
            anim = "michael_tux_fidget",
            dict = "missmic4",
        },
        [4] = {
            anim = "out_of_breath",
            dict = "re@construction",
        },
        -- Gloves
        [3] = {
            anim = "cs_nigel_dual-10",
            dict = "nmt_3_rcm-10",
        },
        -- Shoes
        [6] = {
            anim = "pickup_low",
            dict = "random@domestic",
        },
        -- Neck
        [7] = {
            anim = "try_tie_positive_a",
            dict = "clothingtie",
        },
        -- Vest
        [9] = {
            anim = "try_tie_negative_a",
            dict = "clothingtie",
        },
        -- Bag
        [5] = {
            anim = "intro",
            dict = "anim@heists@ornate_bank@grab_cash",
        },
        -- Mask
        [10] = {
            anim = "put_on_mask",
            dict = "mp_masks@standard_car@ds@",
        },

    },
    shower = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Hair
                { componentid = 3,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 21, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Bags & Parachutes
                { componentid = 6,  drawableid = 34, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 },    -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Decals,
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 100 }, -- Hair
                { componentid = 3,  drawableid = 15, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 17, textureid = 0, paletteid = 0, waitTime = 1000 }, -- Lower
                { componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Bags & Parachutes
                { componentid = 6,  drawableid = 35, textureid = 0, paletteid = 0, waitTime = 0 },    -- Feet
                { componentid = 7, drawableid = 45, textureid = 0, paletteid = 0, waitTime = 100 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 },    -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 },    -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        }
    },
    min = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 544, textureid = 0,  paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 11,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 202, textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 112, textureid = 14, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 588, textureid = 0,  paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                { componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 14,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 217, textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 117, textureid = 14, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = 14, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        }
    },
    med = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 544, textureid = 1, paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 11,  textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 202, textureid = 1, paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 112, textureid = 9, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 588, textureid = 1,  paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 15,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 217, textureid = 1,  paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 117, textureid = 9, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = 14, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        }
    },
    max = {
        male = {
            clothing = {
                { componentid = 11, drawableid = 544, textureid = 2, paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 11,  textureid = 0, paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 202, textureid = 2, paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 112, textureid = 8, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        },
        female = {
            clothing = {
                { componentid = 11, drawableid = 588, textureid = 2,  paletteid = 0, waitTime = 0 }, -- Jacket
                --{ componentid = 0, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Head
                --{ componentid = 1, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Beard
                --{ componentid = 2, drawableid = 0, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hair
                { componentid = 3,  drawableid = 14,  textureid = 0,  paletteid = 0, waitTime = 1000 }, -- Upper / Arms
                { componentid = 4,  drawableid = 217, textureid = 2,  paletteid = 0, waitTime = 1000 }, -- Lower
                --{ componentid = 5,  drawableid = 0,  textureid = 0, paletteid = 0 }, -- Bags & Parachutes
                { componentid = 6,  drawableid = 117, textureid = 8, paletteid = 0, waitTime = 0 },    -- Feet
                --{ componentid = 7, drawableid = 15, textureid = 0, paletteid = 0, waitTime = 0 }, -- Scarfs and Chains
                { componentid = 8,  drawableid = 14, textureid = 0, paletteid = 0, waitTime = 0 }, -- Undershirt
                { componentid = 9,  drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Body Armor
                { componentid = 10, drawableid = 0,  textureid = 0, paletteid = 0, waitTime = 0 }, -- Decals
            },
            props = {
                { componentid = 0, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Hat
                --{ componentid = 1, drawableid = -1, textureid = 0, paletteid = 0, waitTime = 0 }, -- Glasses
            }
        }
    },
}
