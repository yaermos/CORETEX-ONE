local PLUGIN = PLUGIN
PLUGIN.name = "Мусор"
PLUGIN.author = "Den"
PLUGIN.description = "Добавляет мусор для нахождения предметов."
--Огромное спасибо Lister#3693 за то что дал небольшую часть кода.
function PLUGIN:SaveData()
	local data = {}
		for k, v in ipairs(ents.FindByClass("ix_garbage")) do
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
		local entity = ents.Create("ix_garbage")
		entity:SetPos(v.pos)
		entity:SetAngles(v.angles)
		entity:Spawn()
	end
end