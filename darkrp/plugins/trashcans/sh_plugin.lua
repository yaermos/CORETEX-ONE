
local PLUGIN = PLUGIN

PLUGIN.name = "Trashcans"
PLUGIN.description = "Adds trashcans that can be searched."
PLUGIN.author = "DrM (with help of alexgrist and `impulse)"
PLUGIN.models = PLUGIN.models or {}

ix.util.Include("sh_trashcans.lua")

ix.config.Add("trashcansRemoveItems", true, "Whether or not trashcans should remove items that are touching them.", nil, {
	category = "Trashcans"
})

ix.config.Add("trashcanInterval", 150, "How much time does player need to wait before beign able to search trashcan again.", nil, {
	data = {min = 0, max = 1200},
	category = "Trashcans"
})

ix.config.Add("trashcanSearchTime", 5, "How much time it takes to search a trashcan.", nil, {
	data = {min = 0, max = 15},
	category = "Trashcans"
})

if (SERVER) then

	function PLUGIN:PlayerSpawnedProp(client, model, entity)
		model = tostring(model):lower()
		local data = self.models[model:lower()]

		if (data) then
			if (hook.Run("CanPlayerSpawnTrashcan", client, model, entity) == false) then return end

			local trashcan = ents.Create("ix_trashcan")
			trashcan:SetPos(entity:GetPos())
			trashcan:SetAngles(entity:GetAngles())
			trashcan:SetModel(model)
			trashcan:Spawn()
			trashcan.id = math.random(10000,99999)
			trashcan.loot = {junk=10, junk2=10, junk3=10, junk4=10}

			self:SaveTrashcan()
			entity:Remove()
		end
	end
	
	function PLUGIN:SaveTrashcan()
		local data = {}

		for _, v in ipairs(ents.FindByClass("ix_trashcan")) do
				data[#data + 1] = {
					v:GetPos(),
					v:GetAngles(),
					v:GetModel(),
					v.id,
					v.loot
				}
		end
			
		self:SetData(data)
	end

	function PLUGIN:SaveData()
		self:SaveTrashcan()
	end
	
	function PLUGIN:TrashcanRemoved(entity)
		self:SaveTrashcan()
	end

	function PLUGIN:LoadData()
		local data = self:GetData()

		if (data) then
			for _, v in ipairs(data) do
				local data2 = self.models[v[3]:lower()]

				if (data2) then
					local entity = ents.Create("ix_trashcan")
					entity:SetPos(v[1])
					entity:SetAngles(v[2])
					entity:Spawn()
					entity:SetModel(v[3])
					entity:SetSolid(SOLID_VPHYSICS)
					entity:PhysicsInit(SOLID_VPHYSICS)

					if (v[4]) then
						entity.id = v[4]
						entity:SetNetVar("id", v[4])
					end
					
					if (v[5]) then
						entity.loot = v[5]
						entity:SetNetVar("loot", v[5])
					end

					local physObject = entity:GetPhysicsObject()

					if (physObject) then
						physObject:EnableMotion()
					end
				end
			end
		end
	end
	
	ix.log.AddType("searchTrashcan", function(client, ...)
		local arg = {...}
		return string.format("%s has found %s in a trashcan.", client:Name(),arg[1])
	end)
	
	function PLUGIN:ItemChance(loot)
		local sum = 0
		
		for _, chance in pairs(loot) do
			sum = sum + chance
		end

		local select = math.random() * sum

		for key, chance in pairs(loot) do
			select = select - chance
			if select < 0 then return key end
		end
	end
end
