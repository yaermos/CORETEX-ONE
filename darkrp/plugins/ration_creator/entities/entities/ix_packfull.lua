ENT.PrintName = "Полный рацион"
ENT.Type = "anim"
ENT.Author = "Lister"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/weapons/w_package.mdl")
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

        if(hit:GetClass() == "ix_box" || hit:GetClass() == "ix_box01" || hit:GetClass() == "ix_box02")then
           self:Remove()
        end
    end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local rationfull = container:AddRow("rationapparat")
	   rationfull:SetImportant()
	   rationfull:SetText("Полный рацион")
	   rationfull:SizeToContents()
	local rationapparat = container:AddRow("rationapparat")
	   rationapparat:SetText("Подсказка: засуньте рацион в коробку.")
	   rationapparat:SizeToContents()
    end
end
