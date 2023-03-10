local PLUGIN = PLUGIN

PLUGIN.name = "System of hunting on antlion grub"
PLUGIN.author = "Lister"
PLUGIN.description = "--"

if SERVER then
   resource.AddWorkshop( "2102514270" )
end

function PLUGIN:SaveData()
	local data = {}
		for k, v in ipairs(ents.FindByClass("ix_antliongrub")) do
			data[#data + 1] =
			{
				pos = v:GetPos(),
				angles = v:GetAngles()
			}
		end

	self:SetData(data)
end

function PLUGIN:LoadData()
	for k, v in ipairs(self:GetData() or {}) do
		local entity = ents.Create("ix_antliongrub")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()
	end
end