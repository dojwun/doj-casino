fx_version 'cerulean'
game 'gta5'

author 'Disabled Coding'
description 'A casino resource for which you do not have to sell a kidney for'
version '1.0.0'
repository 'https://github.com/Disabled-Coding/dc-casino'

shared_scripts {
    '@ox_lib/init.lua',
    'configs/*.lua'
}
client_scripts {
    'client/slots.lua',
}
server_scripts {
    'server/slots.lua',
}

lua54 'yes'
use_experimental_fxv2_oal 'yes'
