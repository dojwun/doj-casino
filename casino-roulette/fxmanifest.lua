version '1.0.2'
author 'freamee'
decription 'Aquiver rulett'


client_scripts {
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    'client/cl_main.lua'
} 

server_scripts {
    
    'server/sv_main.lua'
}

game 'gta5'
fx_version 'adamant'


shared_scripts {
    'config.lua',
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

lua54 'yes'
