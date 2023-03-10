local PLUGIN = PLUGIN

ENT.Type = "anim"
ENT.PrintName = "Trashcan"
ENT.Category = "Helix"
ENT.Spawnable = false
ENT.bNoPersist = true

if (SERVER) then

	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.receivers = {}

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Wake()
		end
		
		self.canUse = true
	end
	
	function ENT:Use(activator)
		local character = activator:GetCharacter()
		
		if (activator:Team() == FACTION_CITIZEN or activator:Team() == FACTION_CWU or activator:Team() == FACTION_CMU or activator:Team() == FACTION_VORTIGAUNT --[[or activator:Team() == FACTION_CWU]]) then
			self.canUse = false
				if (character:GetData("trashcan"..self.id, 0) < os.time()) then
					activator:SetAction("@trashcanSearch",ix.config.Get("trashcanSearchTime"))
					activator:DoStaredAction(self, function()
						local inventory = character:GetInventory()
						local uniqueID = PLUGIN:ItemChance(self.loot)
						local name = L(ix.item.list[uniqueID].name, activator)
						
						inventory:Add(uniqueID,1)
						character:SetData("trashcan"..self.id, os.time() + ix.config.Get("trashcanInterval", 1))
						
						activator:NotifyLocalized("foundTrashcan",name)
						ix.log.Add(activator,"searchTrashcan",name)
						
						self.canUse = true
					end, ix.config.Get("trashcanSearchTime"), function()
						activator:SetAction()
						self.canUse = true
					end)
				else
					local timeLeft = character:GetData("trashcan"..self.id, 0) - os.time()
					activator:NotifyLocalized("cooldownTrashcan",timeLeft)
				end
		else
			activator:NotifyLocalized("notAllowedTrashcan")
		end
	end
	
	function ENT:Touch( ent )
		if (ent:GetClass() == "ix_item" and ix.config.Get("trashcansRemoveItems") == true) then
			ent:Remove()
		else
			return
		end
	end
else
	ENT.PopulateEntityInfo = true

	function ENT:OnPopulateEntityInfo(trashcan)
		local info = PLUGIN.models[self:GetModel():lower()]
		
		local title = trashcan:AddRow("name")
		title:SetFont("ixSmallTitleFont")
		title:SetText(self:GetDisplayName())
		title:SetBackgroundColor(ix.config.Get("color"))
		title:SizeToContents()
		
		local description = trashcan:AddRow("description")
		description:SetText(info.description)
		description:SizeToContents()
	end
	
	function ENT:GetDisplayName()
		local info = PLUGIN.models[self:GetModel():lower()]
		return self:GetNetVar("name", info.name)
	end
end