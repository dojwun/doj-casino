fx_version 'cerulean'
games      { 'gta5' }

lua54 'yes'

shared_scripts {
	'config/*.lua',
	'@ox_lib/init.lua',
    '@qbx_core/modules/lib.lua',
    '@qbx_core/shared/locale.lua',
}


client_scripts{
	'@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
	'client/*.lua'
} 

server_scripts{
	'server/*.lua'
} 
