

client_scripts {
    'locales/*.lua',
    'client/*.lua',
}

server_scripts {
    -- 'config.lua',
    'locales/*.lua',
    'server/sv_main.lua'
}

shared_scripts {
	'config.lua',
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

game 'gta5'
fx_version 'adamant'
lua54 'yes'
