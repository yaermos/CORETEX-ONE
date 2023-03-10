--Entity
ENT.PrintName = "Яйца муравьиного льва"
ENT.Category = "HL2 RP"
ENT.Author = "Lister"
ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminOnly = true

--var
local antliongrubmodel = "models/jq/hlvr/props/infestation/p1/boomerplant_exploded.mdl"
local reward = "grub_vial_full"
local curTime = CurTime()
local distance = 70
local huntingtime = 5

if (SERVER) then

   	function ENT:Initialize()
	  
	  self:SetModel(antliongrubmodel)
	  self:SetMoveType(MOVETYPE_VPHYSICS)
	  self:PhysicsInit(SOLID_VPHYSICS)
	  self:SetUseType(SIMPLE_USE)
	  self:SetSolid(SOLID_VPHYSICS)
	  self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	  self.next_use = 0

	end
	
	function ENT:SpawnFunction(client, trace)
		local entity = ents.Create(self.ClassName)
		entity:SetPos(trace.HitPos + trace.HitNormal)
		entity:Spawn() 
		entity:Activate()

		return entity
	end
	
	function ENT:Use(client)
	
	  local curTime = CurTime()
	
	  if client:Alive() && client:Crouching() && client:IsPlayer() && client:GetCharacter():GetInventory():HasItem("grub_vial") && !(self:GetNetVar('hunting', curTime) > curTime) && self.next_use < curTime && (client:GetPos():Distance(self:GetPos()) <= distance) then
	    
	   local char = client:GetChar()
	   local inv = char:GetInventory()
	   local item = inv:HasItem("grub_vial")
	   item:Remove()
		
		self.next_use = curTime + 10
		
		client:SetAction("Охота на личинку муравьиного льва в яйце...", huntingtime, function()
		 
		 if (client:GetPos():Distance(self:GetPos()) <= distance && client:Crouching()) then
		 		
			self:SetNetVar('hunting', curTime + 300)
			timer.Destroy("Check Player Eyesight")
			timer.Destroy("CPE Destroyer")
	        
			client:Notify("Вы поймали личинку муравьиного льва!")
			
						timer.Simple(0, function()
						
						  	if (IsValid(client) &&	client:GetCharacter() && not client:GetCharacter():GetInventory():Add(reward, 1)) then

								ix.item.Spawn(reward, client:GetItemDropPos())	

							end
							
						end)
						
		        end
		 
	    end)
		
		local function EyeSightChecker()
		
			if (!client:Crouching() or !client:Alive() or (client:GetPos():Distance(self:GetPos()) > 80) or self:GetNetVar('hunting', curTime) > curTime && IsValid(self) or !client:IsOnGround()) then 
				
				client:SetAction() 
				
				self.next_use = 0
			
			end
		
		end
		
		timer.Create("Check Player Eyesight", (1/100), 0, EyeSightChecker)
		timer.Create("CPE Destroyer", 10, 1, function() timer.Destroy("Check Player Eyesight") end )
		
        self.next_use = curTime + 1		
	
	end
	
   end
   
end

if (CLIENT) then

	function ENT:Draw()
		if !(self:GetNetVar('hunting', CurTime()) > CurTime()) then
			self:DrawModel()
			self:CreateShadow()
		else
			self:DestroyShadow()
		end
	end
	
	function ENT:OnPopulateEntityInfo(container)
	
	local antliongrub = container:AddRow("antliongrub")
	   antliongrub:SetImportant()
	   antliongrub:SetText("Личинка муравьиного льва")
	   antliongrub:SizeToContents()
    end
	
end

function ENT:OnRemove()
	timer.Destroy("Check Player Eyesight")
	timer.Destroy("CPE Destroyer")
end