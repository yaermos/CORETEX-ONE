--[[
https://github.com/Chessnut/hl2rp/blob/1.1/entities/weapons/nut_suitcase.lua
Взято с nutscript.
]]--
AddCSLuaFile()

if (CLIENT) then
	SWEP.PrintName = "Чемодан"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.Category = "HL2 RP"
end

SWEP.Author = "Chessnut"
SWEP.Purpose = "Держать чемодан."
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.HoldType = "passive"

SWEP.ViewModelFOV = 60
SWEP.ViewModelFlip = false

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Primary.Damage = 7.5
SWEP.Primary.Delay = 0.7

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/props_c17/SuitCase_Passenger_Physics.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.UseHands = true
SWEP.LowerAngles = Angle(15, -15, -15)
SWEP.IsAlwaysLowered = true

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:GetViewModelPosition(position, angles)
	return position + angles:Right()*10 + angles:Forward() * 20, angles
end

function SWEP:DrawWorldModel()
	if (!self.dummy) then
		self.dummy = ClientsideModel("models/weapons/w_suitcase_passenger.mdl")
		self.dummy:SetModelScale(0.85, 0)
	end

	self.dummy:SetNoDraw(false)
		local info = self:GetAttachment(1)
		local position, angles

		if (info) then
			position, angles = info.Pos, info.Ang
		else
			position, angles = self.Owner:GetShootPos(), self.Owner:EyeAngles()
		end

		angles:RotateAroundAxis(angles:Right(), 80)
		angles:RotateAroundAxis(angles:Up(), 70)

		self.dummy:SetPos(position - angles:Forward()*4 + angles:Up()*7 + angles:Right()*0)
		self.dummy:SetAngles(angles)
		self.dummy:DrawModel()
	self.dummy:SetNoDraw(true)
end