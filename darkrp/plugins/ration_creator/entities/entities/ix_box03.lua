ENT.PrintName = "Коробка с 3 рационами"
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

    if(hit:GetClass() == "ix_mech")then
    self:Remove()

        end
    end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local boxname = container:AddRow("boxname")
	   boxname:SetImportant()
	   boxname:SetText("Коробка\n3/3")
	   boxname:SizeToContents()
	local boxapparat = container:AddRow("boxapparat")
	   boxapparat:SetText("Подсказка: Засуньте коробку в аппарат принимающий готовые рационы")
	   boxapparat:SizeToContents()
    end
end