CLASS.name = "Лидер Сопротивления"
CLASS.faction = FACTION_SOP
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/player/camouflage_rebels/army_09.mdl")
		inventory:Add("spas12", 1)
        inventory:Add("ar15", 1)
        inventory:Add("king", 1)
	end
end

CLASS_LEAD = CLASS.index
