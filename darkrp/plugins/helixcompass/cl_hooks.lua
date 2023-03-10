
local PLUGIN = PLUGIN;

surface.CreateFont("CompassFont", {
    font    = "BudgetLabel",
    size    = 25,
    weight  = 1000,
    antialias = true,
    shadow = false,
	outline = true
});

PLUGIN.compassText = {};
PLUGIN.compassText[0] 		= "N0";
PLUGIN.compassText[15]		= "345";
PLUGIN.compassText[30]		= "330";
PLUGIN.compassText[45] 		= "NW315";
PLUGIN.compassText[60]		= "300";
PLUGIN.compassText[75] 		= "285";
PLUGIN.compassText[90] 		= "W 270";
PLUGIN.compassText[105]		= "255";
PLUGIN.compassText[120]		= "240";
PLUGIN.compassText[135] 	= "SW 225";
PLUGIN.compassText[150]		= "210";
PLUGIN.compassText[165]		= "195";
PLUGIN.compassText[180] 	= "S 180";
PLUGIN.compassText[-180] 	= "S 180";
PLUGIN.compassText[-165]	= "165";
PLUGIN.compassText[-150]	= "150";
PLUGIN.compassText[-135] 	= "SE 135";
PLUGIN.compassText[-120]	= "120";
PLUGIN.compassText[-105]	= "105";
PLUGIN.compassText[-90] 	= "E 90";
PLUGIN.compassText[-75]		= "75";
PLUGIN.compassText[-60]		= "60";
PLUGIN.compassText[-45] 	= "NE 45";
PLUGIN.compassText[-30]		= "30";
PLUGIN.compassText[-15]		= "15";

function PLUGIN:HUDPaint()
	local client = LocalPlayer();
	local character = LocalPlayer():GetCharacter();
	
	if (client and character) then
		local faction = character:GetFaction();
		local inv = character:GetInventory();
		local compass = inv:HasItem("compass");
		
		if (faction and inv and (faction == FACTION_OTA or faction == FACTION_OWAF or (compass and compass:GetData("equip")))) then
			local width = ScrW() / 2.5;
			local height = 30;
			draw.RoundedBox(8, (ScrW() / 2) - (width / 2), 100, width, height, Color(0, 0, 0, 0));	
			
			local finalText = "";
			local yaw = math.floor(client:GetAngles().y);

			for i = yaw - 50, yaw + 50 do
				local y = i;
				if i > 180 then
					y = -360 + i;
				elseif i < -180 then
					y = 360 + i;
				end;

				if (self.compassText[y]) then
					finalText = self.compassText[y]..finalText;
				else
					finalText = " "..finalText;
				end;
			end;

			draw.DrawText(finalText, "CompassFont", ScrW() / 2, 100 + 2, Color(255, 255, 255, 255), TEXT_ALIGN_CENTER);
		end;
	end;
end;