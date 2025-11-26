fx_version 'cerulean'
name 'brz-fishing'
author 'brz.gg'
lua54 'yes'
game 'gta5'

shared_scripts {
    'settings.js',
    '@ox_lib/init.lua',
}

ox_libs {
    'interface',
}

server_script 'dist/server/**/*.js'
server_script 'server/fishmarket.lua'
server_script 'server/fishing-rarity.lua'

client_script 'dist/client/**/*.js'
client_script 'client/fishmarket.lua'
client_script 'client/fishingspots.lua'

ui_page 'nui/fishing.html'

files {
    'settings.js',
    'nui/*.html',
    'nui/dist/fishing.js',
    'nui/dist/dom/renderer.js'
}