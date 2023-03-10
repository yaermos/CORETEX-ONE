
FACTION.name = "Серверная Администрация"
FACTION.description = ""
FACTION.color = Color(251, 255, 0)
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
	"models/player/gc21police/gc21police.mdl",
	"models/player/witness.mdl",
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	if (!Schema:IsCombineRank(oldValue, "[ERF]") and Schema:IsCombineRank(value, "[ERF]")) then
		character:SetModel("models/kemono_friends/ezo_red_fox/ezo_red_fox_player.mdl")
	elseif (!Schema:IsCombineRank(oldValue, "[GW]") and Schema:IsCombineRank(value, "[GW]")) then
		character:SetModel("models/kemono_friends/gray_wolf/gray_wolf_player.mdl")
	elseif (!Schema:IsCombineRank(oldValue, "[SF]") and Schema:IsCombineRank(value, "[SF]")) then
		character:SetModel("models/kemono_friends/silver_fox/silver_fox_player.mdl")
	elseif (!Schema:IsCombineRank(oldValue, "[RF]") and Schema:IsCombineRank(value, "[RF]")) then
		character:SetModel("models/pacagma/kemono_friends/red_fox/red_fox_player.mdl")
	end
end

FACTION_SERVER = FACTION.index
