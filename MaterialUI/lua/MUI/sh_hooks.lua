--[[-------------------------------------
	MUI\sh_hooks.lua
	Made by James Swift
--]]-------------------------------------

hook.Add( MUI.Config.ThemeChangeHook, "Default", function( sThemeName )
	-- Return false to disallow changing theme
	return true
end)

hook.Add( MUI.Config.ThemeLoadHook, "Default", function( sFilename, sThemeName, tThemeTable )
	-- Called when a theme is added to the theme table
end)

hook.Add( MUI.Config.ErrorHook, "Default", function( sFilename, sNature )
	-- Called when something soft errors.
end)