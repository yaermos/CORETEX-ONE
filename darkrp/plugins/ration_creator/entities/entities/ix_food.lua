ENT.PrintName = "Еда"
ENT.Type = "anim"
ENT.Author = "Lister"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
    function ENT:Initialize()
    	self:SetModel("models/props_junk/watermelon01.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		
		local phys = self.Entity:GetPhysicsObject()

		if (phys:IsValid()) then
		   phys:Wake()
		   phys:SetMass(1)
	    end
    end

    function ENT:PhysicsCollide( data, phys )
        local hit = data.HitEntity

        if(hit:GetClass() == "ix_pack")then
          self:Remove()
        end

    end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local food = container:AddRow("food")
	   food:SetImportant()
	   food:SetText("Еда")
	   food:SizeToContents()
    end
end