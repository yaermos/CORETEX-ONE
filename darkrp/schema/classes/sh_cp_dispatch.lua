CLASS.name = "Центр"
CLASS.faction = FACTION_MPF
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/DPFilms/Metropolice/Playermodels/pm_tron_police_cn.mdl")
		client:Give("pistol")
	end
end

CLASS_DISP = CLASS.index
