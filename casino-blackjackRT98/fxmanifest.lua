fx_version 'adamant'

game "gta5"

description "DiamondBlackjack created by Robbster"

client_scripts {
	"cl_blackjack.lua",
}

server_script "sv_blackjack.lua"

shared_scripts {
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
}

lua54 'yes'
