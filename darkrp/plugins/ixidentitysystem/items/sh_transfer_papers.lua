ITEM.name = "Миграционный билет"
ITEM.model = Model("models/props_lab/clipboard.mdl")
ITEM.description = "Билет на котором написано: Имя, номер, дата прибытия."

function ITEM:PopulateTooltip(tooltip)

	local data = tooltip:AddRow("data")
	data:SetBackgroundColor(derma.GetColor("Success", tooltip))
	data:SetText("Имя: " .. self:GetData("citizen_name", "Unissued") .. "\nНомер: " .. self:GetData("unique", "00000") .. "\nДата прибытия: " .. self:GetData("issue_date", "Unissued"))
	data:SetExpensiveShadow(0.5 )
	data:SizeToContents()

end