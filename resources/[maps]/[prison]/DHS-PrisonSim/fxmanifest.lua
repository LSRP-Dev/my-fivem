

fx_version 'cerulean'
game 'gta5'

description 'DHS-PrisonSim'
version '1.1.7'

use_experimental_fxv2_oal 'yes'
bridge 'DHS-Bridge'

ui_page 'html/index.html'

files {
    'html/*',
    'html/index.html',
    'html/styles.css',
    'html/responsive.css',
    'html/app.js',
    'html/images/*.png',
    'html/sounds/*.mp3'
}

shared_scripts {
    '@DHS-Bridge/bridge.lua',
    "shared/*.lua",
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

client_scripts {
    'client/*.lua',
}

escrow_ignore {
    "shared/*.lua",
    "client/editablefunctions_cl.lua",
    "server/editablefunctions_sv.lua"
}

file {
    "sounds/dlc_stinger/stinger.awc",
    "sounds/data/stinger.dat54.rel"
}

data_file "AUDIO_WAVEPACK" "sounds/dlc_stinger"
data_file "AUDIO_SOUNDDATA" "sounds/data/stinger.dat"

lua54 'yes'

dependency '/assetpacks'