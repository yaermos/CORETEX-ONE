CLASS.name = "Патрульно-контрольный юнит"
CLASS.faction = FACTION_MPF
CLASS.weapons = {"pistol"}

function CLASS:CanSwitchTo(client)
	local name = client:Name()
	local bStatus = false

	for k, v in ipairs({ "PCU.i5", "PCU.i4", "PCU.i3", "PCU.i2", "PCU.i1" }) do
		if (Schema:IsCombineRank(name, v)) then
			bStatus = true

			break
		end
	end

	return bStatus
end

CLASS_CPU = CLASS.index