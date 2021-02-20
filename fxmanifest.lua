fx_version 'adamant'

game 'gta5'

description 'Bandi Is Fivem Best Anticheat'

version '1.0'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server_config.lua',
	'commands.lua',
	'vpn.lua',
	'server.lua',
}

client_scripts {
	'client_config.lua',
	'client.lua',
	'enumerates.lua',
	'qkseldltmqptmxm.lua',
}

client_script "@Badger-Anticheat-master/acloader.lua"

client_script 'gate.lua'