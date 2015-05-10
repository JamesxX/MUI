--[[-------------------------------------
	MUI\sh_config.lua
	Made by James Swift
--]]-------------------------------------


MUI.Config 				= {};

MUI.Config.Version 			= "1.00";
MUI.Config.Creator 			= "James Swift";
MUI.Config.CallHooks 			= true;

MUI.Config.ThemeFolder 			= "MUI/Themes/";
MUI.Config.ThemeFolderLocal 		= "Themes/";
MUI.Config.ThemeDefault			= "Default";
MUI.Config.ThemeLoadHook		= "MUI.ThemeLoaded";
MUI.Config.ThemeChangeHook		= "MUI.ThemeLoaded";

MUI.Config.PrintErrors			= true;
MUI.Config.ErrorStart 			= "[MUI] ";
MUI.Config.ErrorColor 			= Color( 155, 90, 255 );
MUI.Config.ColorWhite 			= Color( 255, 255, 255 );
MUI.Config.ErrorHook 			= "MUI.Error";
