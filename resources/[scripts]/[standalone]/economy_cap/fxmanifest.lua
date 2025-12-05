fx_version 'cerulean'
game 'gta5'

author 'Economy Cap System'
description 'Global hourly earnings cap system - $10k/hour maximum'
version '1.0.0'

shared_script 'config.lua'

server_scripts {
    'server.lua'
}

server_exports {
    'CheckAndAddEarnings',
    'GetHourlyEarnings',
    'ResetHourlyEarnings'
}

