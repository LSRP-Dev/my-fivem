fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Bebik(digitalranger)'
description 'Loadingscreen script by BebikDEV - Discord: https://discord.gg/4VwXy4aDBd'
version '1.1.1'

loadscreen 'index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'yes'

client_script 'client.lua'
server_script 'server.lua'

files {
    'index.html',
    'css/style.css',
    'script/main.js',
    'logo/logo.png',
    'song/*',
    'img/*'
}
