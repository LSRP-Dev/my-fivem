fx_version 'cerulean'
game 'gta5'

author 'Chris'
description 'Custom EUP Streaming for QBOX + Illenium Appearance'
version '1.0.0'

files {
    'eup.meta'
}

data_file 'EUP_METADATA_FILE' 'eup.meta'

shared_script '@ox_lib/init.lua'

files {
    'stream/*.ytd',
    'stream/*.ydd',
    'stream/*.ymt',
    'stream/*.yft'
}

lua54 'yes'
