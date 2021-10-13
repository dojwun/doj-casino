fx_version 'cerulean'

game 'gta5'

description 'Rexhack Gaming : Inside-Track'

version '1.0.1'

shared_scripts { 
    '@qb-core/import.lua',
    'config.lua'
}


client_scripts {
    'client/utils.lua',
    'client/client.lua',
    'client/screens/*.lua',
}

server_script 'server/server.lua' 
