

fx_version 'adamant'
game 'gta5'
description 'Lucky Wheel'
lua54 'yes'



server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}

client_scripts {	
	'@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
    'client.lua',
}

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    '@qbx_core/shared/locale.lua',
}


