CLASS.name = "Референт Альянса (Джудит)"
CLASS.faction = FACTION_ADMIN
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/player/mossman.mdl")
		client:Give("pistol")
	end
end

CLASS_RUSS = CLASS.index
