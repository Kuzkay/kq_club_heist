fx_version 'cerulean'
games { 'gta5' }
lua54 'yes'

author 'KuzQuality | Kuzkay'
description 'Club heist'
version '1.0.0'

client_scripts {
    'locale.lua',
    'client/base.lua',
    'config.lua',
    'settings.lua',
    'client/functions.lua',
    'client/client.lua',
}

server_scripts {
    'config.lua',
    'locale.lua',
    'settings.lua',
    'server/editable/esx.lua',
    'server/editable/qb.lua',
    'server/loot.lua',
    'server/server.lua',
    'server/starter.lua',
}

escrow_ignore {
    'config.lua',
    'locale.lua',
    'settings.lua',
    'client/base.lua',
    'client/functions.lua',
    'client/client.lua',
    'server/server.lua',
    'server/starter.lua',
    'server/editable/*.lua',
}
