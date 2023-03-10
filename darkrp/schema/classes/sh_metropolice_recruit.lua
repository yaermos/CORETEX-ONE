CLASS.name = "Рекрут"
CLASS.faction = FACTION_MPF
CLASS.isDefault = true

function CLASS:CanSwitchTo(client)
	return Schema:IsCombineRank(client:Name(), "RECRUIT")
end

CLASS_CPR = CLASS.index