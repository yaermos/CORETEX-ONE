--Entity
ENT.PrintName = "Лечебный пункт"
ENT.Category = "HL2 RP"
ENT.Author = "Lister"
ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end

--var
local antlionhealthstationmodel = "models/props_combine/health_charger001.mdl"

if (SERVER) then

   	function ENT:Initialize()
	  
	  self:SetModel(antlionhealthstationmodel)
	  self:SetMoveType(MOVETYPE_VPHYSICS)
	  self:PhysicsInit(SOLID_VPHYSICS)
	  self:SetUseType(SIMPLE_USE)
	  self:SetSolid(SOLID_VPHYSICS)
	  self:SetCollisionGroup(COLLISION_GROUP_NONE)

	end
	
	netstream.Hook("AddMedkit", function(ply)

		local char = ply:GetCharacter()
		local inv = char:GetInventory()

		inv:Add("health_kit", 1)
		local item = inv:HasItem("grub_vial_full")
		item:Remove()
		
	end)
	
    function ENT:AcceptInput( Name, Activator, Caller )	
	
	if Name == "Use" and Caller:IsPlayer() then
		umsg.Start("Health", Caller)
		umsg.End()
    end
    
	end

end

if (CLIENT) then
   
	
	local function Menu()
	
          local DermaFrame = vgui.Create( "DFrame" )
          DermaFrame:SetTitle( "Лечебный пункт" )
          DermaFrame:SetSize(ScrW() / 4, ScrH() / 7)
          DermaFrame:Center()
          DermaFrame:SetSizable(false)
		  DermaFrame:SetBackgroundBlur(true)
          DermaFrame:SetVisible( true )
          DermaFrame:SetDraggable( true )
          DermaFrame:ShowCloseButton( true )
          DermaFrame:MakePopup(true)
		  
		  
          local DComboBox = vgui.Create( "DComboBox", DermaFrame )
          DComboBox:Center()
          DComboBox:Dock(FILL)
          DComboBox:SetValue( "Выберите флакон с личинкой муравьиного льва" )
		  
		  local DermaButton = vgui.Create( "DButton", DermaFrame )
          DermaButton:SetText( "Получить аптечку" )
          DermaButton:Dock(BOTTOM)
          DermaButton.DoClick = function ()

          end
		  
		  for k, v in pairs(LocalPlayer():GetCharacter():GetInventory():GetItems()) do
	        if v.uniqueID == "grub_vial_full" then
		        DComboBox:AddChoice("Полный флакон с личинкой муравьиного льва")
		    end
	      end
		  
		  function DermaButton:DoClick()
		  if string.len(DComboBox:GetText()) == 0 and not DComboBox:GetSelected() then
			 return
	      end

		  if DComboBox:GetSelected() and DComboBox:GetSelected()[1] then 
		 	netstream.Start("AddMedkit")
			DermaFrame:Close()
		 else
			DermaFrame:Close()
		 end
	end
	
    end
    usermessage.Hook("Health", Menu)
	
end

