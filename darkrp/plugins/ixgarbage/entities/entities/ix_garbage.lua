
ENT.PrintName = "Мусор"
ENT.Author = "Den"
ENT.Category = "HL2 RP"
ENT.Type = "anim"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Chance = 50
ENT.RewardItems = { "referent", "rat_citizen", "health_kit", "tie", "cookie", "chips", "water" }

if (SERVER) then
	
	function ENT:Initialize()
	local garbageModels = { "models/props_junk/garbage128_composite001a.mdl", "models/props_junk/garbage128_composite001b.mdl", "models/props_junk/TrashCluster01a.mdl", "models/props_junk/garbage128_composite001d.mdl" }

	self:SetModel(table.Random(garbageModels))
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	
	local phys = self:GetPhysicsObject()
		 phys:SetMass( 120 )
	
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
		  if client:Alive() && client:Crouching() && client:IsPlayer() && !client:GetNetVar("restricted") && !(self:GetNetVar('cleaned', curTime) > curTime) && self.next_use < curTime && (client:GetPos():Distance(self:GetPos()) <= 80) then
			self.next_use = curTime + 10
				
				client:SetAction("Убираю мусор...", 15, function()
					if (client:GetPos():Distance(self:GetPos()) <= 80 && client:Crouching()) then
						client:EmitSound("physics/body/body_medium_impact_soft"..math.random(1, 7)..".wav");
						self:SetNetVar('cleaned', curTime + 300)
						timer.Destroy("Check Player Eyesight")
						timer.Destroy("CPE Destroyer")
					
						local a = math.random(0, 100)
						if a <= self.Chance then
							client:Notify("Вы нашли что-то!")
					
							local reward = table.Random(self.RewardItems)
							
						timer.Simple(0, function()
						  	if (IsValid(client) &&	client:GetCharacter() && not client:GetCharacter():GetInventory():Add(reward, 1)) then
								ix.item.spawn(reward, client:getItemDropPos())							
							end
						end)
						
						else
							client:Notify("Вы ничего не нашли...")
						end
				
					end
				end)
			
			local function EyeSightChecker()
				if (!client:Crouching() or !client:Alive() or client:GetNetVar("restricted") or (client:GetPos():Distance(self:GetPos()) > 80) or self:GetNetVar('cleaned', curTime) > curTime && IsValid(self) or !client:IsOnGround()) then 
					client:SetAction() 
					self.next_use = 0
				end
			end
			
			timer.Create("Check Player Eyesight", (1/100), 0, EyeSightChecker)
			timer.Create("CPE Destroyer", 10, 1, function() timer.Destroy("Check Player Eyesight") end )
				
		  elseif !client:Crouching() && !(self:GetNetVar('cleaned', curTime) > curTime) && self.next_use < curTime then
			 client:Notify("Присядьте, чтобы начать убирать мусор.")
			self.next_use = curTime + 1
		  elseif client:GetNetVar("restricted") && !(self:GetNetVar('cleaned', curTime) > curTime) && self.next_use < curTime then
			 client:Notify("Вы связаны и не можете убрать мусор!")
			self.next_use = curTime + 1
		  elseif self:GetNetVar('cleaned', curTime) > curTime then
			 return false
		  end
	end
end

if (CLIENT) then
	function ENT:Draw()
		if !(self:GetNetVar('cleaned', CurTime()) > CurTime()) then
			self:DrawModel()
			self:CreateShadow()
		else
			self:DestroyShadow()
		end
	end
	
	function ENT:OnPopulateEntityInfo(container)
	
	local trashname = container:AddRow("trashname")
	   trashname:SetImportant()
	   trashname:SetText("Мусор")
	   trashname:SizeToContents()
    end
	
end

function ENT:OnRemove()
	timer.Destroy("Check Player Eyesight")
	timer.Destroy("CPE Destroyer")
end