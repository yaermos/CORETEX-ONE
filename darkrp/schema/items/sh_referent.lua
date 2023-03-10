
ITEM.name = "Допуск референта"
ITEM.model = Model("models/dorado/tarjetazero.mdl")
ITEM.description = "Допуск референта к NEXUS OVERWATCH. Доступные места: Весь NEXUS. (Искл: Плац, казармы ГО и стазная ОТА, кабинет АГ.)"

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("name", "nobody"))
end
