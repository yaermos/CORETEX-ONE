CLASS.name = "Шпион сопротивления"
CLASS.faction = FACTION_SOP
CLASS.isDefault = false

function CLASS:OnSet(client)
	local character = client:GetCharacter()

	if (character) then
		character:SetModel("models/DPFilms/Metropolice/Playermodels/pm_HD_Barney.mdl")
	end
end

CLASS_BARNEY = CLASS.index
