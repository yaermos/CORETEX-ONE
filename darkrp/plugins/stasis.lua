
PLUGIN.name = "Стазис"
PLUGIN.author = "Den"
PLUGIN.desc = "Стазис для ОТА"

if (SERVER) then
	function PLUGIN:PlayerEnteredVehicle(client, veh)
		if client:Team() == FACTION_OTA and client:GetVehicle():GetVehicleClass() == "Pod" then
			client:SetLocalVar("InPod", true)
			client:AddCombineDisplayMessage("Система отключена.", Color(255, 0, 0, 255))
			if client:Health() < 100 then
				client:SetHealth(client:Health() + 100)
			end
			if client:Armor() < 100 then
				client:SetArmor(client:Armor() + 100)
			end
		end
	end
end