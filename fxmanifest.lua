fx_version 'cerulean'
game 'gta5'

name "jhn_interactions"
description "Ped interaction"
author "JHN"
version "1.0.0"

lua54 'yes'
dependecies {
	'ox_target'
}
shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}
ui_page 'web/index.html'
files {
	'web/index.html',
	'web/style.css',
	'web/script.js',
}