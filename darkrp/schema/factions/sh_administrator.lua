
FACTION.name = "Администрация Альянса"
FACTION.description = ""
FACTION.color = Color(107, 8, 189)
FACTION.pay = 10
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
	"models/daemon_alyx/players/male_citizen_09.mdl",
	"models/player/zelpa/female_01.mdl",
	"models/player/zelpa/female_02.mdl",
	"models/player/zelpa/female_03.mdl",
	"models/player/zelpa/female_04.mdl",
	"models/player/zelpa/female_06.mdl",
	"models/player/zelpa/female_06.mdl",
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true

function FACTION:OnCharacterCreated(client, character)
    local id = Schema:ZeroNumber(math.random(1, 99999), 5)
    local inventory = character:GetInventory()

	inventory:Add("request_device", 1)

    character:SetData("cid", id)

    inventory:Add("suitcase", 1)
    local Timestamp = os.time()
        local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )
    inventory:Add("transfer_papers", 1, {
        citizen_name = character:GetName(),
        unique = math.random(0000000,999999999),
        issue_date = tostring(TimeString)
    })
end

FACTION_ADMIN = FACTION.index

