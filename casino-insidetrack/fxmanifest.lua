fx_version 'cerulean'

game 'gta5'
description 'Rexhack Gaming : Inside-Track'
lua54 'yes'


client_scripts {
    'client/utils.lua',
    'client/client.lua',
}

server_script 'server/server.lua'


shared_scripts {
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}
