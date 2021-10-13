fx_version 'adamant'
game "gta5"

name 'kgv-blackjack'
description 'Playable Blackjack at the casino, similar to GTAOnline.'
author 'Xinerki - https://github.com/Xinerki/'
url 'https://github.com/Xinerki/kgv-blackjack'

shared_scripts {
	'coords.lua',
	'@qb-core/import.lua'
}

client_scripts{
	'client/*.lua'
} 

server_scripts{
	'server/*.lua'
} 

