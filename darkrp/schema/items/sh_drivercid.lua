
ITEM.name = "DID"
ITEM.model = Model("models/dorado/tarjetazero.mdl")
ITEM.description = "Разрешение на вождение транспорта"

function ITEM:GetDescription()
	return string.format(self.description, self:GetData("id", "00000"), self:GetData("name", "nobody"))
end
