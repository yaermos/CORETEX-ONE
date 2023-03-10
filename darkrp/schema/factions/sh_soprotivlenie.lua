
FACTION.name = "Сопротивление"
FACTION.description = "3, 233, 195"
FACTION.color = Color(63, 4, 202)
FACTION.pay = 0
FACTION.models = {
	"models/player/Group03/male_02.mdl",
	"models/player/Group03/male_03.mdl",
	"models/player/Group03/male_04.mdl",
	"models/player/Group03/male_06.mdl",
	"models/player/Group03/male_07.mdl",
	"models/player/Group03/male_08.mdl",
	"models/player/Group03/male_09.mdl",
}
FACTION.isDefault = false
FACTION.isGloballyRecognized = false

function FACTION:OnTransfered(client)
	local character = client:GetCharacter()

	character:SetName(self:GetDefaultName())
	character:SetModel(self.models[1])
	character:SetData(THIRST_ID, nil)
	character:SetData(HUNGER_ID, nil)
end

function FACTION:OnNameChanged(client, oldValue, value)
	local character = client:GetCharacter()

	if (!Schema:IsCombineRank(oldValue, "[Медик]") and Schema:IsCombineRank(value, "[Медик]")) then
		character:JoinClass(CLASS_SOPMEDIC)
		client:Give("weapon_medkit")
	elseif (!Schema:IsCombineRank(oldValue, "[Инженер]") and Schema:IsCombineRank(value, "[Инженер]")) then
		character:JoinClass(CLASS_SOPVETERAN)
		client:Give("tfa_ins2_cw_ar15")
		client:Give("alydus_fortificationbuildertablet")
	elseif (!Schema:IsCombineRank(oldValue, "[Ветеран]") and Schema:IsCombineRank(value, "[Ветеран]")) then
		character:JoinClass(CLASS_SOPVETERAN)
		client:Give("tfa_ins2_sks")
        client:Give("tfa_ins2_spas12")
	elseif (!Schema:IsCombineRank(oldValue, "[Шпион]") and Schema:IsCombineRank(value, "[Шпион]")) then
		character:JoinClass(CLASS_BARNEY)
		client:Give("smg")
		client:Give("pistol")
		
	end
end

FACTION_SOP = FACTION.index

