
--
-- Copyright (C) 2020 Taxin2012
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--



--  Writed by Taxin2012
--  https://steamcommunity.com/id/Taxin2012/



local btn_size = 29
local PANEL = {}

function PANEL:Init()
    self:SetTitle( "Быстрые команды" )
end

function PANEL:Setup( tbl )
    local wi, hi = ScrW() / 5, ScrH() / 6
    local btns_size = #tbl * btn_size + 30

    self:SetSize( wi, btns_size )
    self:SetPos( ( ScrW() - wi ) / 2, ScrH() - btns_size - 5 )
    self:ShowCloseButton( false )
    self:MakePopup()
    self:SetDraggable( false )
    self:SetMouseInputEnabled( true )

    local new_pos = btn_size

    for k, v in next, tbl do
        local btn = self:Add( "DButton" )
        btn:SetText( v.Name )
        btn:SetTextColor( Color( 255, 255, 255 ) )
        btn:SetSize( wi - 10, 24 )
        btn:SetPos( 5, new_pos )
        btn.DoClick = v.OnRun

        if v.Check and ( v.Check() == false ) then
        	btn:SetEnabled( false )
        end

        new_pos = new_pos + btn_size
    end
end

vgui.Register( "CstmContextMenu", PANEL, "DFrame" )