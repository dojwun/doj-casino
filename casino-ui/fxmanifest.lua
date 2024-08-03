fx_version 'bodacious'
game 'gta5'

author 'Codesign#2715'
description 'Draw screen UI replacment for 3D text'
version '1.0'

ui_page {
    'html/index.html',
}

files {
	'html/index.html',
	'html/js/script.js', 
	'html/css/stylesheet.css',
}

client_scripts {
	'client/main.lua' 
}

exports {
	'DrawCasinoUi',
	'HideCasinoUi',
} 