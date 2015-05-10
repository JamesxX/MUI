--[[-------------------------------------
	autorun\MUI.lua
	Made by James Swift
--]]-------------------------------------

if ( SERVER ) then
	AddCSLuaFile( "MUI/sh_init.lua" );
end

include( "MUI/sh_init.lua" );

MUI.Initialize( );
