--[[-------------------------------------
	MUI\sh_errors.lua
	Made by James Swift
--]]-------------------------------------


MUI.Errors = {};
local Errors = MUI.Errors;

function Errors.BuildLogTable( )
	if ( not Errors.Log ) then 
		Errors.Log = {};
		return false
	end
	return true
end

function Errors.BuildMessage( sFilename, sNature )
	return "Error in file " .. sFilename .. " : " .. sNature;
end

function Errors.Post( sFilename, sNature, ... )
	if ( MUI.Config.PrintErrors ) then
		MUI.Output( Errors.BuildMessage( sFilename, sNature ), ... );
	end
	
	Errors.BuildLogTable( );
	
	table.insert( Errors.Log, {File = sFilename, Nature = sNature} );
	
	if ( MUI.Config.CallHooks ) then
		hook.Call( MUI.Config.ErrorHook, nil, sFilename, sNature );
	end
end

function Errors.GetLast( )
	if ( not Errors.BuildLogTable( ) ) then return false; end
	return Errors.Log[ table.Count( Errors.Log ) ] or false;
end

function Errors.ClearLog( )
	Errors.Log = nil;
end

function Errors.List()
	Errors.BuildLogTable( );
	local i, n = 0, table.getn(Errors.Log);
	return function ()
		i = i + 1;
		if i <= n then
			return i, Errors.Log[i].File, Errors.Log[i].Nature;
		end
	end
end 