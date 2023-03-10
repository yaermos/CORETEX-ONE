
CLASS.name = "Медик ГСР"
CLASS.faction = FACTION_CWU
CLASS.isDefault = false
CLASS_MEDICCWU = CLASS.index

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		client:Give("weapon_medkit")
	end
end