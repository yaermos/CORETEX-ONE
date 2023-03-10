ENT.PrintName = "Коробка"
ENT.Type = "anim"
ENT.Author = "Lister"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
    function ENT:Initialize()
		self:SetModel("models/props_junk/cardboard_box001a.mdl")
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

    if(hit:GetClass() == "ix_packfull")then
    local raciond = ents.Create( "ix_box01" )
       raciond:SetPos( self:LocalToWorld(Vector( 6, 0, 5.3 ) ) )
       raciond:Spawn()
       self:Remove()
    end
  end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local boxname = container:AddRow("boxname")
	   boxname:SetImportant()
	   boxname:SetText("Коробка\n0/3")
	   boxname:SizeToContents()
    end
end