ENT.PrintName = "Рацион с едой"
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
		
		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
    end

    function ENT:PhysicsCollide( data, phys )
        local hit = data.HitEntity

        if(hit:GetClass() == "ix_water")then
        local racionfs = ents.Create( "ix_packfull" )
              racionfs:SetPos( self:LocalToWorld(Vector( 6, 0, 5.3 ) ) )
              racionfs:Spawn()
              self:Remove()
        end
    end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local ration = container:AddRow("ration")
	   ration:SetImportant()
	   ration:SetText("Рацион с едой")
	   ration:SizeToContents()
	local rationwater = container:AddRow("ration")
	   rationwater:SetText("Подсказка: засуньте в рацион воду.")
	   rationwater:SizeToContents()
    end
end