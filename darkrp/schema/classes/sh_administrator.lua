CLASS.name = "Городской администратор"
CLASS.faction = FACTION_ADMIN
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/lt_c/sci_fi/humans/male_09.mdl")
	end
end

CLASS_CITIZEN = CLASS.index