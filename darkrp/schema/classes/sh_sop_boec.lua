CLASS.name = "Боец Сопротивления"
CLASS.faction = FACTION_SOP
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
	    inventory:Add("sks", 1)
	end
end

CLASS_BOECSOP = CLASS.index
