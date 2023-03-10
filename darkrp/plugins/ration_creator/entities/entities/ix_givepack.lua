ENT.PrintName = "Выдача рациона"
ENT.Type = "anim"
ENT.Author = "Lister"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:SpawnFunction( ply, tr )

	if !tr.Hit then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 1

	local ent = ents.Create( "ix_givepack" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:Initialize()

	self.Entity:SetModel("models/props_phx/construct/metal_tubex2.mdl")

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
    self.IsInUse = false
    self.UseTimer = 0

	self.Index = self.Entity:EntIndex()

	local phys = self.Entity:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

function ENT:Think()
  if self.IsInUse == true then
    if self.UseTimer <= CurTime() then
      self.IsInUse = false
    end
  end
end

function ENT:Use(activator)
  if self.IsInUse == false then 
    local givep = ents.Create( "ix_pack" )
    givep:SetPos( self:LocalToWorld(Vector( 6, 0, 5.3 ) ) )
    givep:Spawn()
    self.IsInUse = true
    self.UseTimer = CurTime() + 5
  end
end
