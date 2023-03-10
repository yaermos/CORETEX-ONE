ITEM.name = "CID карта"
ITEM.model = Model("models/dorado/tarjeta4.mdl")
ITEM.description = "Идентифицированная CID карта"

function ITEM:IsCWU()
	return self:GetData("cwu", false)
end

function ITEM:IsCombine()
	return self:GetData("cca", false)
end

function ITEM:GetModel()
	if self:IsCWU() then
		return "models/dorado/tarjeta3.mdl"
	elseif self:IsCombine() then
		return "models/dorado/tarjeta1.mdl"
	else
		return self.model
	end
end

function ITEM:PopulateTooltip(tooltip)
	if not self:IsCWU() and not self:IsCombine() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Имя: " .. self:GetData("citizen_name", "Unissued") .. "\nID: " .. self:GetData("cid", "00000") .. "\nДата выпуска: " .. self:GetData("issue_date", "Unissued"))
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	if self:IsCWU() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Имя: " .. self:GetData("citizen_name", "Unissued") .. "\nID: " .. self:GetData("cid", "00000") .. "\nДата выпуска: " .. self:GetData("issue_date", "Unissued") .. "\nРабочий ID: " .. self:GetData("worker_id", "NO ID! CONTACT DEVELOPER!"))
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end

	if self:IsCombine() then
		local data = tooltip:AddRow("data")
		data:SetBackgroundColor(derma.GetColor("Success", tooltip))
		data:SetText("Идентификатор: " .. string.match(self:GetData("citizen_name", "NO NAME"), "%d%d%d") .. "\nДата выпуска: " .. self:GetData("issue_date", "Unissued") .. "\nПолный идентификатор: " .. self:GetCPName())
		data:SetExpensiveShadow(0.5)
		data:SizeToContents()
	end
end

function ITEM:GetAssociatedCharacter()
	return self:GetData("associated_character", false)
end

--[[-------------------------------------------------------------------------
There will always be an associated character because these are -ONLY- given on spawn.
---------------------------------------------------------------------------]]
function ITEM:GetCPName()
	if ix.char.loaded[self:GetAssociatedCharacter()] then
		return ix.char.loaded[self:GetAssociatedCharacter()]:GetName()
	else
		return self:GetData("citizen_name", false)
	end
end

function ITEM:GetCPRank()
	local name = self:GetCPName()
	return string.match(name, "%p%a%a%p") or string.match(name, "%p%d%d%p")
end

hook.Add("CharacterVarChanged", "ixCPIDUpdate", function(char, key, oldValue, value)
	if key == "name" then
		local inv = char:GetInventory():GetItems()
		for k, v in pairs(inv) do
			if v.uniqueID == "cid" then
				if v:GetAssociatedCharacter() and v:GetAssociatedCharacter() == char:GetID() then
					v:SetData("citizen_name", value)
				end
			end
		end
	end
end)

ITEM.functions.ViewRecord = {
	name = "Просмотреть записи",
	OnRun = function(item)
		local client = item.player
		local char = client:GetChar()

		if client:IsCombine() then
			print(client)
			print(item.id)
			PrintTable(ix.item.instances[item.id])
			--PrintTable(item)
			netstream.Start(client, "OpenRecordMenu", {item.id})
		end

		return false
	end,

	OnCanRun = function(item)
		return item.player:IsCombine() or item.invID != item.player:GetCharacter():GetInventory():GetID()
	end
}