fx_version "adamant"
game "gta5"

name "RocketCAD Integration"
description "RocketCAD Integration resource for FiveM Servers"
author "Modern Solutions"
version "1.5.0"

server_script {
    "sv_integration.lua",
    "sv_version.lua"
}

client_script {
    "cl_integration.lua",
    "config.lua"
}
