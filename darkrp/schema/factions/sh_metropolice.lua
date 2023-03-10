
FACTION.name = "Гражданская Оборона"
FACTION.description = ""
FACTION.color = Color(50, 100, 150)
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
FACTION.runSounds = {[0] = "NPC_MetroPolice.RunFootstepLeft", [1] = "NPC_MetroPolice.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
    local inventory = character:GetInventory()
    local str = "UUCP-"..math.random(00000,99999) .. "-" .. math.random(00000,99999) .. "://JFK"
    local Timestamp = os.time()
    local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )

	inventory:Add("handheld_radio", 1)

    inventory:Add("cid", 1, {
        ["citizen_name"] = character:GetName(),
        ["service_number"] = str,
        ["cid"] = str,
        ["issue_date"] = TimeString,
        ["cca"] = true,
        ["associated_character"] = character:GetID()
    })
end	

function FACTION:GetDefaultName(client)
	return "C24.CP-RECRUIT." .. Schema:ZeroNumber(math.random(1, 99999), 5), true
end

function FACTION:OnTransferred(character)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	character:SetName(self:GetDefaultName())
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	if (!Schema:IsCombineRank(oldValue, "RECRUIT") and Schema:IsCombineRank(value, "RECRUIT")) then
		character:JoinClass(CLASS_CPR)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.i5") and Schema:IsCombineRank(value, "PCU.i5")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.i4") and Schema:IsCombineRank(value, "PCU.i4")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.i3") and Schema:IsCombineRank(value, "PCU.i3")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.i2") and Schema:IsCombineRank(value, "PCU.i2")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.i1") and Schema:IsCombineRank(value, "PCU.i1")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.EPU") and Schema:IsCombineRank(value, "PCU.EPU")) then
		character:JoinClass(CLASS_CPU)
	elseif (!Schema:IsCombineRank(oldValue, "PCU.OFC") and Schema:IsCombineRank(value, "PCU.OFC")) then
		character:JoinClass(CLASS_CPС)
	elseif (!Schema:IsCombineRank(oldValue, "SU.MEDIC") and Schema:IsCombineRank(value, "SU.MEDIC")) then
		character:JoinClass(CLASS_CPMED)
	elseif (!Schema:IsCombineRank(oldValue, "SU.TECH") and Schema:IsCombineRank(value, "SU.TECH")) then
		character:JoinClass(CLASS_CPTECH)
	elseif (!Schema:IsCombineRank(oldValue, "SU.SNIPER") and Schema:IsCombineRank(value, "SU.SNIPER")) then
		character:JoinClass(CLASS_CPSNIP)
	elseif (!Schema:IsCombineRank(oldValue, "SU.GUARD") and Schema:IsCombineRank(value, "SU.GUARD")) then
		character:JoinClass(CLASS_CPGRD)
	elseif (!Schema:IsCombineRank(oldValue, "SU.OFC") and Schema:IsCombineRank(value, "SU.OFC")) then
		character:JoinClass(CLASS_CPС)
	elseif (!Schema:IsCombineRank(oldValue, "CMD.DVL") and Schema:IsCombineRank(value, "CMD.DVL")) then
		character:JoinClass(CLASS_CPС)
	elseif (!Schema:IsCombineRank(oldValue, "CMD.APEX") and Schema:IsCombineRank(value, "CMD.APEX")) then
		character:JoinClass(CLASS_CPС)
	elseif (!Schema:IsCombineRank(oldValue, "CMD.SEC") and Schema:IsCombineRank(value, "CMD.SEC")) then
		character:JoinClass(CLASS_CPС)
	elseif (!Schema:IsCombineRank(oldValue, "OVERWATCH.DISPATCHER") and Schema:IsCombineRank(value, "OVERWATCH.DISPATCHER")) then
		character:SetModel("models/DPFilms/Metropolice/Playermodels/pm_tron_police_cn.mdl")
		character:JoinClass(CLASS_DISP)
	elseif (!Schema:IsCombineRank(oldValue, "SCN") and Schema:IsCombineRank(value, "SCN")
	or !Schema:IsCombineRank(oldValue, "SHIELD") and Schema:IsCombineRank(value, "SHIELD")) then
		character:JoinClass(CLASS_MPS)
	end
end

FACTION_MPF = FACTION.index
