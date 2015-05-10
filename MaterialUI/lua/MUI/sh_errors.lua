--[[-------------------------------------
	MUI\sh_errors.lua
	Made by James Swift
--]]-------------------------------------


MUI.Errors = {};
local Errors = MUI.Errors;

function Errors.BuildMessage( sFilename, sNature )
	return "Error in file " .. sFilename .. " : " .. sNature;
end

function Errors.Post( sFilename, sNature, ... )
	if ( MUI.Config.PrintErrors ) then
		MsgC( MUI.Config.ErrorColor, MUI.Config.ErrorStart, MUI.Config.ColorWhite, Format( Errors.BuildMessage( sFilename, sNature ), ... ), "\n" );
	end
	
	if ( not Errors.Log ) then 
		Errors.Log = {};
	end
	
	table.insert( Errors.Log, {File = sFilename, Nature = sNature} );
	
	if ( MUI.Config.CallHooks ) then
		hook.Call( MUI.Config.ErrorHook, nil, sFilename, sNature );
	end
end

function Errors.GetLast( )
	if ( not Errors.Log ) then return false; end
	return Errors.Log[ table.Count( Errors.Log ) ] or false;
end

function Errors.ClearLog( )
	Errors.Log = nil;
end
