--[[-------------------------------------
	MUI\sh_init.lua
	Made by James Swift
--]]-------------------------------------


MUI = {}

if ( SERVER ) then

	AddCSLuaFile( "sh_config.lua" );
	AddCSLuaFile( "sh_errors.lua" );
	AddCSLuaFile( "sh_themes.lua" );
	AddCSLuaFile( "sh_hooks.lua" );

end

include( "sh_config.lua" );
include( "sh_errors.lua" );
include( "sh_themes.lua" );
include( "sh_hooks.lua" );

function MUI.Initialize( )

	MUI.ThemeLoader.LoadThemes( );
	MUI.ThemeLoader.SetSelected( MUI.Config.ThemeDefault )

end