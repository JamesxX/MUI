--[[-------------------------------------
	MUI\Themes\Default.lua
	Made by James Swift
--]]-------------------------------------

local LuaReloaded = false
if ( not Theme ) then 
	LuaReloaded = true
	Theme = {}
end

-----------------------------------------
--	Theme definition
-----------------------------------------

Theme.Name = "Default";

function Theme:Initialize( )

end


-----------------------------------------
--	In case the file is reloaded, this fixes that
-----------------------------------------
if ( LuaReloaded ) then
	MUI.ThemeLoader.RegisterTable( Theme, "Default.lua" )
	Theme = nil
end