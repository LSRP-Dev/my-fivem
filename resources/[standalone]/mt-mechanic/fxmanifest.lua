fx_version 'cerulean'
author 'Marttins#8421'
description 'Mechanics script by MT Scripts'
game 'gta5'

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
    '@ox_lib/init.lua',
    "client/*.lua",
    "unescrowed_client/*.lua",
}

server_scripts {
    '@ox_lib/init.lua',
    '@oxmysql/lib/MySQL.lua',
    "server/*.lua",
    "escrowed_server/*.lua",
}

shared_scripts {
    "shared/*.lua",
}

files {
    "meta/carcols_gen9.meta", -- (Credits to https://www.gta5-mods.com/misc/chameleon-paint-add-on)
    "meta/carmodcols_gen9.meta" -- (Credits to https://www.gta5-mods.com/misc/chameleon-paint-add-on)
}

data_file "CARCOLS_GEN9_FILE" "carcols_gen9.meta" -- (Credits to https://www.gta5-mods.com/misc/chameleon-paint-add-on)
data_file "CARMODCOLS_GEN9_FILE" "carmodcols_gen9.meta" -- (Credits to https://www.gta5-mods.com/misc/chameleon-paint-add-on)

dependicies {
    'ox_lib',
}

lua54 "yes"
dependency '/assetpacks'