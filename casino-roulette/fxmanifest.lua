version '1.0.2'
author 'freamee'
decription 'Aquiver rulett'

shared_scripts { 
	'@qb-core/import.lua'
}

client_scripts {
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'client/cl_main.lua'
}

server_scripts {
    'config.lua',
    'translations.lua',
    'shared/shared_utils.lua',
    'server/sv_main.lua'
}

-- ui_page 'html/index.html'

-- files {
--     'html/index.html',
--     'html/js/*.js',
--     'html/DEP/*.js',
--     'html/img/**',
--     'html/ProximaNova.woff'
-- }

game 'gta5'
fx_version 'adamant'
