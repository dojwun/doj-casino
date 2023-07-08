fx_version 'adamant'

description 'Casino and Cayo Perico IPL loader by Kromstar Gaming#8228'

version '1.0'

game 'gta5'

this_is_a_map 'yes'



client_scripts {
    'client/client.lua',
	'client/mph4_gtxd.meta',
	'client/water.lua',
}

data_file 'GTXD_PARENTING_DATA' 'client/mph4_gtxd.meta'


--IMPORTANT For this DLC Loader to render correctly please ensure your game build is set to the latest version in your server.cfg. sv_enforceGameBuild 2189 and ensure that you are running Canary on all clients connecting--
