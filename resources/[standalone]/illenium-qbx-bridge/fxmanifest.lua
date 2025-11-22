fx_version 'cerulean'
game 'gta5'

name 'illenium-appearance QBX Bridge'
author 'Auto-Generated Bridge'
description 'Bridge to make illenium-appearance work with QBX Core (QBox)'
version '1.0.0'

-- Load AFTER qbx_core, BEFORE illenium-appearance
server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

shared_scripts {
    'shared.lua'
}

lua54 'yes'

-- Dependencies
dependencies {
    'qbx_core'
}
