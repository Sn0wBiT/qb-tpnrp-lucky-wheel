fx_version 'cerulean'
game 'gta5'

description 'QB TPNRP Lucky Wheel by thientd.dev'
author 'Leopold@thientd.dev'
version '1.0.2'

client_scripts {
    'client/main.lua',
    'client/wheel.lua',
    'client/map.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/functions.lua'
}

shared_scripts {
    'config.lua'
}

lua54 'yes'

dependency 'oxmysql'