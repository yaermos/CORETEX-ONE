
FACTION.name = "Бандиты"
FACTION.description = ""
FACTION.color = Color(3, 233, 195)
FACTION.pay = 0
FACTION.models = {
	"models/daemon_alyx/players/male_citizen_01.mdl",
	"models/daemon_alyx/players/male_citizen_10.mdl",
	"models/daemon_alyx/players/male_citizen_11.mdl",
	"models/daemon_alyx/players/male_citizen_12.mdl",
	"models/daemon_alyx/players/male_citizen_13.mdl",
	"models/daemon_alyx/players/male_citizen_02.mdl",
	"models/daemon_alyx/players/male_citizen_03.mdl",
	"models/daemon_alyx/players/male_citizen_04.mdl",
	"models/daemon_alyx/players/male_citizen_05.mdl",
	"models/daemon_alyx/players/male_citizen_06.mdl",
	"models/daemon_alyx/players/male_citizen_07.mdl",
	"models/daemon_alyx/players/male_citizen_08.mdl",
	"models/daemon_alyx/players/male_citizen_09.mdl"
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	if (!Schema:IsCombineRank(oldValue, "[HUNTER]") and Schema:IsCombineRank(value, "[HUNTER]")) then
		character:JoinClass(CLASS_HUNTER)
		character:SetModel("models/delta/destiny2/hunterexilemale.mdl")
	elseif (!Schema:IsCombineRank(oldValue, "[GHUNTER]") and Schema:IsCombineRank(value, "[GHUNTER]")) then
		character:JoinClass(CLASS_GHUNTER)
		character:SetModel("models/destiny2/luxe_hunter/luxehunter.mdl")
	end
end

FACTION_BAN = FACTION.index
