if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	
	resource.AddFile("models/weapons/v_vortbeamvm.mdl")
	resource.AddFile("materials/vgui/entities/swep_vortigaunt_beam.vmt")
	resource.AddFile("materials/vgui/killicons/swep_vortigaunt_beam.vmt")
	
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
end

if ( CLIENT ) then
	SWEP.DrawAmmo			= true
	SWEP.PrintName			= "Луч вортигонта"
	SWEP.DrawCrosshair		= true
	SWEP.ViewModelFOV		= 54

	killicon.Add("swep_vortigaunt_beam","VGUI/killicons/swep_vortigaunt_beam",Color(255,255,255));
end

SWEP.Category				= "Vort Swep" 
SWEP.Slot					= 5
SWEP.SlotPos				= 5
SWEP.Weight					= 5
SWEP.Spawnable     			= true
SWEP.AdminSpawnable  		= true
 
SWEP.ViewModel 				= "models/weapons/v_vortbeamvm.mdl"
SWEP.WorldModel 			= ""
SWEP.HoldType 				= "beam"
SWEP.LowerAngles = Angle(0, 0, -6)
SWEP.LowerAngles2 = Angle(0, 5, -19)
SWEP.KnockViewPunchAngle = Angle(-1.3, 1.8, 0)

SWEP.Range					= 2*GetConVarNumber( "sk_vortigaunt_zap_range",100)*12
SWEP.DamageForce			= 48000
SWEP.AmmoPerUse				= 1
SWEP.HealSound				= Sound("NPC_Vortigaunt.SuitOn")
SWEP.HealLoop				= Sound("NPC_Vortigaunt.StartHealLoop")
SWEP.AttackLoop				= Sound("NPC_Vortigaunt.ZapPowerup" )
SWEP.AttackSound			= Sound("npc/vort/attack_shoot.wav")
SWEP.HealDelay				= 1
SWEP.MaxHealth				= 18
SWEP.MinHealth				= 12
SWEP.HealthLimit				= 100
SWEP.BeamDamage				= 45	
SWEP.BeamChargeTime			= 0.5
SWEP.Deny					= Sound("Buttons.snd19")			

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo 			= false
SWEP.Primary.Automatic		= false


SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo 		= false
SWEP.Secondary.Automatic 	= false

function SWEP:Initialize()
	self.Charging=false;
	self.Healing=false;
	self.HealTime=CurTime();
	self.ChargeTime=CurTime();
	self:SetWeaponHoldType("beam")
	if (CLIENT) then return end
	self:CreateSounds()
end 

function SWEP:Precache()
	PrecacheParticleSystem( "vortigaunt_beam" );
	PrecacheParticleSystem( "vortigaunt_beam_charge" );
	PrecacheParticleSystem( "vortigaunt_charge_token" );
	PrecacheParticleSystem( "vortigaunt_charge_token_b" );
	PrecacheParticleSystem( "vortigaunt_charge_token_c" );
	util.PrecacheModel(self.ViewModel)
end

function SWEP:CreateSounds()

	if (!self.ChargeSound) then
		self.ChargeSound = CreateSound( self.Weapon, self.AttackLoop );
	end
	if (!self.HealingSound) then
		self.HealingSound = CreateSound( self.Weapon, self.HealLoop );
	end
end

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:SetDeploySpeed( 1 )
	return true
end

function SWEP:DispatchEffect(EFFECTSTR)
	local pPlayer=self.Owner;
	if !pPlayer then return end
	local view
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end
		if ( !pPlayer:IsNPC() && view:IsPlayer() ) then
			ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer:GetViewModel(), pPlayer:GetViewModel():LookupAttachment( "muzzle" ) );
		else
			ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "rightclaw" ) );
			ParticleEffectAttach( EFFECTSTR, PATTACH_POINT_FOLLOW, pPlayer, pPlayer:LookupAttachment( "leftclaw" ) );
		end
end

function SWEP:ShootEffect(EFFECTSTR,startpos,endpos)
	local pPlayer=self.Owner;
	if !pPlayer then return end
	local view
	if CLIENT then view=GetViewEntity() else view=pPlayer:GetViewEntity() end
		if ( !pPlayer:IsNPC() && view:IsPlayer() ) then
			util.ParticleTracerEx( EFFECTSTR, pPlayer:GetAttachment( pPlayer:LookupAttachment( "rightclaw" ) ).Pos,endpos, true,pPlayer:EntIndex(), pPlayer:LookupAttachment( "rightclaw" ) );
		end
end
	
function SWEP:ImpactEffect( traceHit )
	local data = EffectData();
	data:SetOrigin(traceHit.HitPos)
	data:SetNormal(traceHit.HitNormal)
	data:SetScale(20)
	util.Effect( "StunstickImpact", data );
	local rand=math.random(1,1.5);
	self:CreateBlast(rand,traceHit.HitPos)
	self:CreateBlast(rand,traceHit.HitPos)											
	if SERVER && traceHit.Entity && IsValid(traceHit.Entity) && string.find(traceHit.Entity:GetClass(),"ragdoll") then
		traceHit.Entity:Fire("StartRagdollBoogie");
		/*
		local boog=ents.Create("env_ragdoll_boogie")
		boog:SetPos(traceHit.Entity:GetPos())
		boog:SetParent(traceHit.Entity)
		boog:Spawn()
		boog:SetParent(traceHit.Entity)
		*/
	end
end

function SWEP:CreateBlast(scale,pos)
	if CLIENT then return end
	local blastspr = ents.Create("env_sprite");
	blastspr:SetPos( pos );
	blastspr:SetKeyValue( "model", "sprites/vortring1.vmt")
	blastspr:SetKeyValue( "scale",tostring(scale))
	blastspr:SetKeyValue( "framerate",60)
	blastspr:SetKeyValue( "spawnflags","1")
	blastspr:SetKeyValue( "brightness","255")
	blastspr:SetKeyValue( "angles","0 0 0")
	blastspr:SetKeyValue( "rendermode","9")
	blastspr:SetKeyValue( "renderamt","255")
	blastspr:Spawn()
	blastspr:Fire("kill","",0.45)
end						
function SWEP:Shoot(dmg,effect)
	local pPlayer=self.Owner
	if !pPlayer then return end
	local traceres=util.QuickTrace(self.Owner:EyePos(),self.Owner:GetAimVector()*self.Range,self.Owner)
	self:ShootEffect(effect or "vortigaunt_beam",pPlayer:EyePos(),traceres.HitPos)	//shoop da whoop
	if SERVER then
		if IsValid(traceres.Entity) then
		local DMG=DamageInfo()
		DMG:SetDamageType(DMG_SHOCK)
		DMG:SetDamage(dmg or self.BeamDamage)
		DMG:SetAttacker(self.Owner)
		DMG:SetInflictor(self)
		DMG:SetDamagePosition(traceres.HitPos)
		DMG:SetDamageForce(pPlayer:GetAimVector()*self.DamageForce)
		traceres.Entity:TakeDamageInfo(DMG)
		end
	end
	self:ImpactEffect( traceres )
end

function SWEP:Holster( wep )
	self:StopEveryThing()
	return true
end

function SWEP:OnRemove()
	self:StopEveryThing()
end

function SWEP:StopEveryThing()
	self.Charging=false;
	if SERVER && self.ChargeSound then
		self.ChargeSound:Stop();
	end
	self.Healing=false;
	if SERVER && self.HealingSound then
		self.HealingSound:Stop();
	end
	
	local pPlayer = self.LastOwner;
	if (!pPlayer) then
		return;
	end
	local Weapon = self.Weapon
		if (!pPlayer) then return end
		if (!pPlayer:GetViewModel()) then return end
		if ( CLIENT ) then if ( pPlayer == LocalPlayer() ) then pPlayer:GetViewModel():StopParticles();end	end
		pPlayer:StopParticles();
end

function SWEP:GiveHealth()
	if CLIENT then return end
	local arm=math.random(self.MinHealth,self.MaxHealth)
	local plarm=self.Owner:Health()
	self.Owner:SetHealth(plarm + math.Clamp(arm,0,self.HealthLimit))
				
end


function SWEP:PrimaryAttack()

	self:DispatchEffect("vortigaunt_charge_token_b")
	self:DispatchEffect("vortigaunt_charge_token_c")
	self.ChargeTime=CurTime()+self.BeamChargeTime;
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	timer.Simple(0.5,function()
		if IsValid(self.Owner:GetViewModel())then self.Owner:GetViewModel():StopParticles() end
			self.Owner:StopParticles()
			if (!self.Owner:Alive()) then return end
			-- self.Charging=false;
			self:Shoot()
			self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
			timer.Simple(0.75,function()if !IsValid(self.Owner) || self.Owner:GetActiveWeapon()!=self || !IsValid(self)  then return end self.Weapon:SendWeaponAnim(ACT_VM_IDLE)end)
			if SERVER && self.ChargeSound then	
				self.ChargeSound:Stop()
				self.Weapon:EmitSound(self.AttackSound)
			end


	end)
	
	/*
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(0,32,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(0,-32,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(32,0,0))
	self:ShootEffect("vortigaunt_beam_charge",self.Owner:EyePos(),self.Owner:GetPos()+Vector(-32,0,0))
	*/
	if SERVER && self.ChargeSound then
	self.ChargeSound:PlayEx( 100, 150 );
	end
	self.Weapon:SetNextPrimaryFire(CurTime()+2)
	self.Weapon:SetNextSecondaryFire(CurTime()+2)
end


function SWEP:SecondaryAttack()
	if self.Owner:Health()>=self.HealthLimit then return end

	self.HealTime=CurTime()+self.HealDelay;
	self:DispatchEffect("vortigaunt_charge_token")
	self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
	if SERVER && self.HealingSound then
		self.HealingSound:PlayEx( 100, 150 );
	end

	timer.Simple(1,function()
		if (!self.Owner:Alive()) then return end
		if IsValid(self.Owner:GetViewModel())then self.Owner:GetViewModel():StopParticles() end
			self.Owner:StopParticles()
		self:GiveHealth()
		if SERVER && self.HealingSound then	self.HealingSound:Stop() end
		if !IsValid(self.Owner) || self.Owner:GetActiveWeapon()!=self || !IsValid(self)  then return end self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
		self.Owner:GetViewModel():EmitSound(self.HealSound)
	end)

	self.Weapon:SetNextPrimaryFire(CurTime()+1)
	self.Weapon:SetNextSecondaryFire(CurTime()+1)
end

function SWEP:Reload()
end
