--[[-------------------------------------
	MUI\sh_themes.lua
	Made by James Swift
--]]-------------------------------------

MUI.ThemeLoader = {};
local ThemeLoader = MUI.ThemeLoader;
SetGlobalString( "MUI.ThemeLoader.Selected", "" );

function ThemeLoader.SetSelected( sThemeName )
	sThemeName = tostring( sThemeName );
	
	if ( ThemeLoader.GetSelected() == sThemeName ) then
		return true;
	end
	
	if not ThemeLoader.Themes[ sThemeName ] then
		MUI.Errors.Post( "MUI\\sh_themes.lua", "Attempted to select theme that wasn't loaded (%s)!", sThemeName );
		return false;
	end

	local bCanChange = true
	
	if ( MUI.Config.CallHooks ) then
		bCanChange = hook.Call( MUI.Config.ThemeChangeHook, nil, sThemeName );
	end
	
	if ( bCanChange ) then
		ThemeLoader.Selected = sThemeName;
		SetGlobalString( "MUI.ThemeLoader.Selected", sThemeName );
		return true;
	end
	
	return false;
end

function ThemeLoader.GetSelected( )

	return GetGlobalString( "MUI.ThemeLoader.Selected" );

end

function ThemeLoader.LoadThemes( )
	if not ThemeLoader.Themes then ThemeLoader.Themes = {}; end
	
	local Themes = file.Find( MUI.Config.ThemeFolder .. "*.lua" , "LUA"  );
	
	if ( table.Count( Themes ) == 0 ) then
		MUI.Errors.Post( "MUI\\sh_themes.lua", "No themes to load!");
	end
	
	for _, sFileName in pairs( Themes ) do
		ThemeLoader.LoadTheme( sFilename );
	end
end

function ThemeLoader.LoadTheme( sFilename )
	
	if not ThemeLoader.Themes then ThemeLoader.Themes = {}; end
	
	if ( CLIENT ) then
		Theme = {};
		include( MUI.Config.ThemeFolderLocal .. sFilename );
		
		if ( not Theme.Name ) then
			MUI.Errors.Post( MUI.Config.ThemeFolderLocal .. sFilename, "Failed to load theme!");
			return false;
		end
		
		local sThemeName = Theme.Name;
		
		ThemeLoader.Themes[ sThemeName ] = table.Copy( Theme );
		Theme = nil;
		
		if ( MUI.Config.CallHooks ) then
			hook.Call( MUI.Config.ThemeLoadHook, nil, sFilename, sThemeName, ThemeLoader.Themes[ sThemeName ] );
		end
	else
		AddCSLuaFile( MUI.Config.ThemeFolderLocal .. sFilename );
	end
	
	return true

end