
FACTION.name = "Патруль Альянса"
FACTION.description = ""
FACTION.color = Color(63, 4, 202)
FACTION.pay = 0
FACTION.models = {"models/player/soldier_stripped.mdl"}
FACTION.isDefault = false
FACTION.isGloballyRecognized = true
FACTION.runSounds = {[0] = "NPC_CombineS.RunFootstepLeft", [1] = "NPC_CombineS.RunFootstepRight"}

function FACTION:OnCharacterCreated(client, character)
    local inventory = character:GetInventory()
    local str = "UUCP-"..math.random(00000,99999) .. "-" .. math.random(00000,99999) .. "://JFK"
    local Timestamp = os.time()
    local TimeString = os.date( "%H:%M:%S - %d/%m/%Y" , Timestamp )

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
	return "C24.OTA-OWR.Soldier." .. Schema:ZeroNumber(math.random(1, 99999), 5), true
end

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
	character:SetData(THIRST_ID, nil)
	character:SetData(HUNGER_ID, nil)
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()
	local inventory = character:GetInventory()
	if (!Schema:IsCombineRank(oldValue, "OWS.Soldier") and Schema:IsCombineRank(value, "OWS.Soldier")) then
		character:JoinClass(CLASS_OWS)
	elseif (!Schema:IsCombineRank(oldValue, "OWS.Grunt") and Schema:IsCombineRank(value, "OWS.Grunt")) then
		character:JoinClass(CLASS_OWSGRUNT)
	elseif (!Schema:IsCombineRank(oldValue, "EOW.WallHammer") and Schema:IsCombineRank(value, "EOW.WallHammer")) then
		character:JoinClass(CLASS_EOW)
	elseif (!Schema:IsCombineRank(oldValue, "EOW.Ordinal") and Schema:IsCombineRank(value, "EOW.Ordinal")) then
		character:JoinClass(CLASS_EOWORDINAL)
	elseif (!Schema:IsCombineRank(oldValue, "EOW.Asassin") and Schema:IsCombineRank(value, "EOW.Asassin")) then
		character:SetModel("models/DPFilms/Metropolice/Playermodels/pm_tron_police_cn.mdl")
		character:JoinClass(CLASS_ASSASIN)
	elseif (!Schema:IsCombineRank(oldValue, "EOW.Knight") and Schema:IsCombineRank(value, "EOW.Knight")) then
		character:JoinClass(CLASS_KNIGHT)
	elseif (!Schema:IsCombineRank(oldValue, "EOT.Teach") and Schema:IsCombineRank(value, "EOT.Teach")) then
		character:SetModel("models/dpfilms/metropolice/playermodels/pm_rtb_police.mdl")
		character:JoinClass(CLASS_EOTTEACH)
	elseif (!Schema:IsCombineRank(oldValue, "EOW.King") and Schema:IsCombineRank(value, "EOW.King")) then
		character:JoinClass(CLASS_EOWSUP)
	end
end

FACTION_OTA = FACTION.index
