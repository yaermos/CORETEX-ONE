ENT.PrintName = "Аппарат принимающий готовые рационы"
ENT.Type = "anim"
ENT.Author = "Lister"
ENT.Category = "HL2 RP"
ENT.Spawnable = true
ENT.AdminOnly = true

if SERVER then
   function ENT:Initialize()
       self:SetModel("models/props_wasteland/laundry_washer003.mdl")
       self:PhysicsInit(SOLID_VPHYSICS)
       self:SetSolid(SOLID_VPHYSICS)
       self:SetMoveType(MOVETYPE_VPHYSICS)
       self.IsInUse = false
       self.UseTimer = 0
    local phys = self.Entity:GetPhysicsObject()
        local money = 0
        local notify = "Вам нужна коробка с рационами для того, чтобы получить награду."
    if (phys:IsValid()) then
    phys:Wake()
    phys:SetMass(1)
  end
  
end
end

function ENT:PhysicsCollide( data, phys )
if(SERVER) then
local hit = data.HitEntity
if(hit:GetClass() == "ix_box03") then
  money = 3
  notify = "Ваша награда за работу - 3 токена."
end

end
end

function ENT:Think()
  if self.IsInUse == true then
    if self.UseTimer <= CurTime() then
      self.IsInUse = false
    end
  end
end

function ENT:Use(client, activator)
  local character = client:GetCharacter()
  if self.IsInUse == false
  then 
  character:GiveMoney(money)
  activator:Notify(notify)
  self:SetNWInt("money",0)
  money = 0
  notify = "Вам нужна коробка с рационами для того, чтобы получить награду."
    self.IsInUse = true
    self.UseTimer = CurTime() + 5
  end
end

if CLIENT then
  function ENT:OnPopulateEntityInfo(container)
  
  local apparat = container:AddRow("apparat")
     apparat:SetImportant()
     apparat:SetText("Аппарат принимающий готовые рационы")
     apparat:SizeToContents()
  end
end