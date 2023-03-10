ENT.PrintName = "Пустой рацион"
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
            local racionv = ents.Create( "ix_packdrink" )
                racionv:SetPos( self:LocalToWorld(Vector( 6, 0, 5.3 ) ) )
                racionv:Spawn()
            self:Remove()
            end
    end

    function ENT:PhysicsCollide( data, phys )
     
         local hit = data.HitEntity

         if(hit:GetClass() == "ix_food")then
         local racionda = ents.Create( "ix_packfood" )
             racionda:SetPos( self:LocalToWorld(Vector( 6, 0, 5.3 ) ) )
             racionda:Spawn()
             self:Remove()
         end
    end
end

if CLIENT then
	function ENT:OnPopulateEntityInfo(container)
	
	local ration = container:AddRow("ration")
	   ration:SetImportant()
	   ration:SetText("Пустой рацион")
	   ration:SizeToContents()
    local rationfood = container:AddRow("rationfood")
       rationfood:SetText("Подсказка: засуньте в рацион еду.")
       rationfood:SizeToContents()
    end
end