AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "CID Терминал"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.RenderGroup = RENDERGROUP_BOTH

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_combine/breenconsole.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self.health = 50
	end

	function ENT:OnTakeDamage(damage)
		local atk = damage:GetAttacker()
		local dmg = damage:GetDamage()

		if not self:GetNetVar("destroyed", false) then
			self.health = self.health - dmg
		end

		if self.health <= 0 and self:GetNetVar("destroyed", false) == false then
			self:Destruct(atk)
		end
	end

	function ENT:Destruct(atk)
		self.health = 0
		self:SetNetVar("destroyed", true)
		local spark = ents.Create("env_spark")
		spark:SetPos(self:GetPos() + Vector(0, 10, 0))
		spark:Fire("SparkOnce")
		--I don't feel like remembering stuff.
		local explosion = ents.Create("npc_grenade_frag")
		explosion:SetPos(spark:GetPos())
		explosion:Fire("Timer", 0.01)
		explosion:Fire("SetTimer", 0.01)
	end

	function ENT:Use(user)
		if self:GetNetVar("destroyed", false) then
			user:Notify("Этот терминал сломан!")
			self:EmitSound("buttons/combine_button_locked.wav")

			return
		end

		if user:IsCombine() then
			user:SetAction("Происходит вход в систему...", 1, function()
				netstream.Start(user, "OpenCIDMenu", {})
				user:Freeze(false)
			end)

			self:EmitSound("buttons/button14.wav", 100, 50)
			user:SelectWeapon("ix_hands")
			user:Freeze(true)
		else
			user:Notify("Терминал не отвечает.")
		end
	end
else
	surface.CreateFont("panel_font", {
		["font"] = "verdana",
		["size"] = 13,
		["weight"] = 128,
	})

	function ENT:Draw()
		self:DrawModel()
	end
end