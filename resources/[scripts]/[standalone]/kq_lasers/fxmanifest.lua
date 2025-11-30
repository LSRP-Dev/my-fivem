fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

name 'kq_security'
author 'KuzQuality | Kuzkay'
description 'Lasers by KuzQuality.com'
version '1.0.0'

--
-- Server
--

server_scripts {
    'config.lua',

    'components/public/dispatch/server.lua',
}

--
-- Client
--

client_scripts {
    'config.lua',

    'main/client/functions.lua',
    'main/client/cache.lua',
    'main/client/debug.lua',

    'main/client/editable/client.lua',
    'main/client/editable/esx.lua',
    'main/client/editable/qb.lua',

    'components/protected/laser/classes/laser.lua',
    'components/protected/laser/client.lua',

    'components/public/dispatch/client.lua',
}

escrow_ignore {
    'config.lua',
    'main/client/editable/*.lua',
    'components/public/**/*.lua',
}

dependency '/assetpacks'