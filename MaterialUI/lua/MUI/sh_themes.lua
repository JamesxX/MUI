--[[-------------------------------------
	MUI\sh_themes.lua
	Made by James Swift
--]]-------------------------------------

MUI.ThemeLoader = {};
local ThemeLoader = MUI.ThemeLoader;
SetGlobalString( "MUI.ThemeLoader.Selected", MUI.Config.ThemeDefault );

function ThemeLoader.BuildThemeTable( )
	if not ThemeLoader.Themes then
		ThemeLoader.Themes = {};
		return false;
	end
	return true;
end

function ThemeLoader.SetSelected( sThemeName )
	MUI.Errors.CheckArguments( "ThemeLoader.SetSelected( sThemeName )", { sThemeName, "string" } );
	sThemeName = tostring( sThemeName );
	
	if ( ThemeLoader.GetSelected() == sThemeName ) then
		return true;
	end
	
	if not ThemeLoader.Themes[ sThemeName ] then
		MUI.Errors.Post( "MUI\\sh_themes.lua", "Attempted to select theme that wasn't loaded (%s)!", sThemeName );
		return false;
	end

	local bCanChange = true;
	
	if ( MUI.Config.CallHooks ) then
		bCanChange = bCanChange and hook.Call( MUI.Config.ThemeChangeHook, nil, sThemeName );
	end
	
	if ( bCanChange ) then
		ThemeLoader.Selected = sThemeName;
		SetGlobalString( "MUI.ThemeLoader.Selected", sThemeName );
		return true;
	end
	
	return false;
end

function ThemeLoader.GetSelected( )

	return GetGlobalString( "MUI.ThemeLoader.Selected", MUI.Config.ThemeDefault );

end

function ThemeLoader.LoadThemes( )

	ThemeLoader.BuildThemeTable( );
	
	local Themes = file.Find( MUI.Config.ThemeFolder .. "*.lua" , "LUA"  );
	
	if ( table.Count( Themes ) == 0 ) then
		MUI.Errors.Post( "MUI\\sh_themes.lua", "No themes to load!");
	end
	
	for _, sFilename in pairs( Themes ) do
		ThemeLoader.LoadTheme( sFilename );
	end
end

function ThemeLoader.LoadTheme( sFilename )
	MUI.Errors.CheckArguments( "ThemeLoader.LoadTheme( sFilename )", { sFilename, "string" } );
	ThemeLoader.BuildThemeTable( );
	
	Theme = {};
	include( MUI.Config.ThemeFolder .. sFilename );
	local Loaded = ThemeLoader.RegisterTable( Theme, sFilename );
	Theme = nil;

	return Loaded;

end

function ThemeLoader.RegisterTable( tThemeTable, sFilename )

	MUI.Errors.CheckArguments( "ThemeLoader.RegisterTable( tThemeTable, sFilename )", { tThemeTable, "table" }, { sFilename, "string" } );

	if ( not tThemeTable.Name ) then
		MUI.Errors.Post( MUI.Config.ThemeFolder .. sFilename, "Failed to load theme!");
		return false;
	end
	
	local sThemeName = tThemeTable.Name;
	
	ThemeLoader.Themes[ sThemeName ] = table.Copy( tThemeTable );
	
	if ( ThemeLoader.Themes[ sThemeName ].Base ) then
		if ( ThemeLoader.Themes[ ThemeLoader.Themes[ sThemeName ].Base ] ) then
			local NewBaseTable = table.Copy( ThemeLoader.Themes[ ThemeLoader.Themes[ sThemeName ].Base ] );
			local NewThemeTable = table.Copy( ThemeLoader.Themes[ ThemeLoader.Themes[ sThemeName ].Base ] );
			table.Merge( NewBaseTable, NewThemeTable );
			ThemeLoader.Themes[ sThemeName ] = NewBaseTable;
		end
	end
	
	if ( ThemeLoader.Themes[ sThemeName ].Initialize ) then
		ThemeLoader.Themes[ sThemeName ]:Initialize();
	end
	
	if ( MUI.Config.CallHooks ) then
		hook.Call( MUI.Config.ThemeLoadHook, nil, sFilename, sThemeName, ThemeLoader.Themes[ sThemeName ] );
	end

	if ( SERVER ) then
		AddCSLuaFile( MUI.Config.ThemeFolder .. sFilename );
	end
	
	MUI.Output( "The %s theme was loaded!", sThemeName );
	
	return true;
end

function ThemeLoader.GetTheme( sThemeName )
	MUI.Errors.CheckArguments( "ThemeLoader.GetTheme( sThemeName )", { sThemeName, "string" } );
	if ( not ThemeLoader.BuildThemeTable( ) ) then return false; end
	return ThemeLoader.Themes[ sThemeName ] or false;
end

function ThemeLoader.GetThemes( )
	if ( not ThemeLoader.BuildThemeTable( ) ) then return false; end
	return ThemeLoader.Themes;
end

function ThemeLoader.GetThemeCount( )
	if ( not ThemeLoader.BuildThemeTable( ) ) then return 0; end
	return table.Count( ThemeLoader.Themes );
end