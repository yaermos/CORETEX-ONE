
--	Writed by Taxin2012
--	https://steamcommunity.com/id/Taxin2012/
--  Modded by Space



local PLUGIN = PLUGIN
PLUGIN.name = "Контекстное меню"
PLUGIN.author = "Space"
PLUGIN.description = "Контекстное меню"



if CLIENT then
	PLUGIN.Btns = {
		--[[{
	        Name = "Меню действий",
	        OnRun = function()
	            Acts_OpenMenu()
	        end
	    },]]
		{
	        Name = "Передать деньги",
	        OnRun = function()
	            Derma_StringRequest(
	                "Передать деньги", 
	                "Введите количество",
	                "",
	                function( text )
	                    RunConsoleCommand( "ix", "givemoney", text )
	                end
	            )
	        end
	    },
	    {
	        Name = "Выкинуть деньги",
	        OnRun = function()
	            Derma_StringRequest(
	                "Бросить деньги", 
	                "Введите количество",
	                "",
	                function( text )
	                    RunConsoleCommand( "ix", "dropmoney", text )
	                end
	            )
	        end
	    },
	    {
	        Name = "Сменить описание",
	        OnRun = function()
	            Derma_StringRequest(
	                "Сменить описание", 
	                "Введите новое описание",
	                "",
	                function( text )
	                    RunConsoleCommand( "ix", "chardesc", text )
	                end
	            )
	        end
	    },
		{
	        Name = "Вызов администратора",
	        OnRun = function()
	            Derma_StringRequest(
	                "Вызов администратора", 
	                "Опишите суть происходящего и причину вызова",
	                "Жалоба",
	                function( text,ply )
	                    RunConsoleCommand( "say", "@")
	                end
	            )
	        end
	    },
	    --[[{
	        Name = "Снять экипировку",
	        OnRun = function()
	        	local items = LocalPlayer():GetLocalVar( "equiped", {} )
	        	if table.IsEmpty( items ) then return end

	            local menu = DermaMenu()

	            for k, v in next, items do
	            	if v[ 1 ] ~= nil and v[ 2 ] ~= nil then
		            	local item = ix.item.list[ v[ 1 ] ]
		            	if item == nil then continue end

				        menu:AddOption( item.name, function()
				            netstream.Start( "CU_DeEquip", v[ 2 ] )
				        end):SetImage("icon16/cog_delete.png")
					end
				end

		        menu:Open()
	        end,
	        Check = function()
	        	return not table.IsEmpty( LocalPlayer():GetLocalVar( "equiped", {} ) )
	    	end
	    },]]
	   --[[ {
	        Name = "Вызвать Администратора",
	        OnRun = function()
	            Derma_StringRequest(
	                "Вызвать Администратора", 
	                "Укажите причину",
	                "",
	                function( text )
	                    RunConsoleCommand( "cats_help", text )
	                end
	            )
	        end
	    }]]
	}

	function CM_AddBtn( tbl )
		table.insert( PLUGIN.Btns, tbl )
	end

	function PLUGIN:OnContextMenuOpen()
		if IsValid( PLUGIN.Vgui ) then PLUGIN.Vgui:Remove() end

		PLUGIN.Vgui = vgui.Create( "CstmContextMenu" )
		PLUGIN.Vgui:Setup( PLUGIN.Btns )
	end

	function PLUGIN:OnContextMenuClose()
		if IsValid( PLUGIN.Vgui ) then PLUGIN.Vgui:Remove() end
	end
end