fx_version 'cerulean'
game 'gta5'

author '919 / Chris — bridge for qb-admin on Qbox/qb-core'
description 'Small server/client shim so qb-admin can spawn vehicles and give items regardless of qbx_core vs qb-core.'

-- load AFTER core; BEFORE qb-admin
server_scripts {
  'server.lua',
}
client_scripts {
  'client.lua',
}

lua54 'yes'