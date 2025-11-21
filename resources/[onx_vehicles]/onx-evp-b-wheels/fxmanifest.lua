fx_version 'cerulean'
game 'gta5'
author 'ONX'
description 'WiseGuy Emergency Vehicles Pack'
version '1.1.0'
lua54 'yes'

data_file 'CARCOLS_FILE' 'data/carcols.meta'

files {
  'data/*.meta'
}

client_script 'data/vehicle_names.lua'

escrow_ignore {
  'data/*.lua',
}

server_scripts {
  'version.lua',
}

dependency '/assetpacks'