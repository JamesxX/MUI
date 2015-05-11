--[[-------------------------------------
	MUI\Themes\Default.lua
	Made by James Swift
--]]-------------------------------------

local LuaReloaded = false;
if ( not Theme ) then 
	LuaReloaded = true;
	Theme = {};
end

-----------------------------------------
--	Theme definition
-----------------------------------------

Theme.Name = "Default";
Theme.GwenTexture = Material("");

function Theme:Initialize( )

end

function Theme:CreateTextureBorder( _x, _y, _w, _h, l, t, r, b )

	local mat = self.GwenTexture;
	local tex = mat:GetTexture( "$basetexture" );
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
	
	local _l = l / tex:Width();
	local _t = t / tex:Height();
	local _r = r / tex:Width();
	local _b = b / tex:Height();
	
	return function( x, y, w, h, col )
		
		surface.SetMaterial( mat );
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		-- top 
		surface.DrawTexturedRectUV( x, y, l, t, _x, _y, _x+_l, _y+_t );
		surface.DrawTexturedRectUV( x+l, y, w-l-r, t, _x+_l, _y, _x+_w-_r, _y+_t );
		surface.DrawTexturedRectUV( x+w-r, y, r, t, _x+_w-_r, _y, _x+_w, _y+_t );
	
		-- bottom 
		surface.DrawTexturedRectUV( x, y+h-b, l, b, _x, _y+_h-_b, _x+_l, _y+_h );
		surface.DrawTexturedRectUV( x+l, y+h-b, w-l-r, b, _x+_l, _y+_h-_b, _x+_w-_r, _y+_h );
		surface.DrawTexturedRectUV( x+w-r, y+h-b, r, b, _x+_w-_r, _y+_h-_b, _x+_w, _y+_h );
		
		-- middle. 
		surface.DrawTexturedRectUV( x+l, y+t, w-l-r, h-t-b, _x+_l, _y+_t, _x+_w-_r, _y+_h-_b );
		surface.DrawTexturedRectUV( x, y+t, l, h-t-b, _x, _y+_t, _x+_l, _y+_h-_b );
		surface.DrawTexturedRectUV( x+w-r, y+t, r, h-t-b, _x+_w-_r, _y+_t, _x+_w, _y+_h-_b );
	
	end

end

function Theme:CreateTextureNormal( _x, _y, _w, _h )

	local mat = self.GwenTexture;
	local tex = mat:GetTexture( "$basetexture" );
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
		
	return function( x, y, w, h, col )
		
		surface.SetMaterial( mat );
		
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		surface.DrawTexturedRectUV( x, y, w, h, _x, _y, _x+_w, _y+_h );

	end

end

function Theme:CreateTextureCentered( _x, _y, _w, _h )

	local mat = self.GwenTexture;
	local tex = mat:GetTexture( "$basetexture" );
	
	local width = _w;
	local height = _h;
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
		
	return function( x, y, w, h, col );
		
		x = x + (w-width)*0.5;
		y = y + (h-height)*0.5;
		w = width;
		h = height;
		
		surface.SetMaterial( mat );
		
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		surface.DrawTexturedRectUV( x, y, w, h, _x, _y, _x+_w, _y+_h );

	end

end

function Theme:TextureColor( x, y )

	local mat = self.GwenTexture;
	return mat:GetColor( x, y );

end

-----------------------------------------
--	In case the file is reloaded, this fixes that
-----------------------------------------
if ( LuaReloaded ) then
	MUI.ThemeLoader.RegisterTable( Theme, "Default.lua" );
	Theme = nil;
end