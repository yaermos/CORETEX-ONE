AddCSLuaFile()

ENT.Base = "base_anim"
ENT.Spawnable = true
ENT.AdminOnly = true

ENT.Author	= "Dobytchick"
ENT.PrintName = "Ящик (делать взлом)"
ENT.Category = "[IX] CRATE"
ENT.AutomaticFrameAdvance = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/items/ammocrate_ar2.mdl")
		self:SetBodygroup(0, 1) 
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)

		self:SetUseType(SIMPLE_USE)
		self:GetPhysicsObject():EnableMotion(false)
		self:SetAngles(Angle(0,0,0))

		self.receivers = {}

		keypad = ents.Create("prop_physics")
		keypad:SetMoveType(MOVETYPE_VPHYSICS)
		keypad:PhysicsInit(SOLID_VPHYSICS)
		keypad:SetModel("models/props_lab/keypad.mdl")
		keypad:SetPos(self:GetPos() + Vector(15.5,0,15))
		keypad:SetAngles(self:GetAngles() + Angle(0,0,0))
		keypad:Spawn()
		keypad:GetPhysicsObject():EnableMotion(false)


		local inventory = ix.item.CreateInv(STORAGE.CFG.StorageWidth, STORAGE.CFG.StorageHeight, os.time())

		inventory.noSave = true

		self.ixInventory = inventory
	end

	function ENT:Use(activator, caller, ue, i)
		touse(self,activator)
	end

	function ENT:OnRemove()
		if timer.Exists("crate_timer01") then
			timer.Remove("crate_timer01")
		end
		SafeRemoveEntity(self.console)
		SafeRemoveEntity(keypad)
	end
end

if CLIENT then
	function ENT:Draw()
		self:DrawModel()
	end
end