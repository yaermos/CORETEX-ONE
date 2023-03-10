AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.AdminOnly = false

ENT.Author	= "Dobytchick"
ENT.PrintName = "Консолька снюса"
ENT.Category = "[IX] CRATE"

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/props_c17/consolebox01a.mdl")
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
		local mins,maxs = self:GetModelBounds()
		cam.Start3D2D(self:GetPos() + Vector(maxs.x - 0.1,maxs.y - 7.85, maxs.z - 0.3), self:GetAngles() + Angle(0,90,90), 0.1)
		
		draw.DrawText( [[C:\Users\]], "DermaDefault", -110, 8, Color(223,0,5), TEXT_ALIGN_RIGHT )
		if !i1 then
			i1 = true
			timer.Simple(0.8, function()
				i2 = true
				if !i3 then
					i3 = true
					timer.Simple(0.8, function()
						i4 = true
						if !i5 then
							i5 = true
							timer.Simple(0.8, function()
								i6 = true
							end)
						end
					end)
				end
			end)
		end
		if i2 then
			draw.DrawText( [[C:\codecracker.exe]], "DermaDefault", -115, 20, Color(223,0,5), TEXT_ALIGN_RIGHT )
		end
		if i6 then
			for k,v in pairs(ents.FindInSphere(self:GetPos(), 50)) do
				if v:GetNetVar("crate_timer") and isnumber(v:GetNetVar("crate_timer")) then
					draw.DrawText( ">hack attack initialized..." .. (v:GetNetVar("crate_timer") and os.date("%M:%S", v:GetNetVar("crate_timer"))), "DermaDefault", -200, 32, Color(223,0,5), TEXT_ALIGN_LEFT)
					--draw.DrawText("Время до взлома: " .. (v:GetNetVar("crate_timer") and os.date("%M:%S", v:GetNetVar("crate_timer"))), "codecracker_big", -200, 20, Color(223,0,5), TEXT_ALIGN_LEFT )
				end
			end
		end
			if b1 then
			--draw.DrawText( (bruhtext or ""), "StalkerAmmoStore", -1, 33, Color(223,0,5), TEXT_ALIGN_CENTER )
			if !tcreator then
				tcreator = true
				timer.Simple(2, function()
					b1 = nil
					tcreator = nil
					bruhtext = nil
				end)
			end
		end
		if !b1 then
			timer.Simple(1, function()
				b1 = true
			end)
		end
		cam.End3D2D()
	end

	function ENT:OnRemove()
		i1,i2,i3,tcreator,bruhtext,i5,i6,i4,b1 = nil
		print(i1,tcreator,i2,i3,b1)
	end
end