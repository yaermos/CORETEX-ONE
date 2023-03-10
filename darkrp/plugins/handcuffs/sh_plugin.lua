local PLUGIN = PLUGIN

PLUGIN.name = "Handcuffs"
PLUGIN.author = "Huargenn"
PLUGIN.description = "Add handcuffs and a key."

--[[ Declaración de Variables ]]--

ix.char.RegisterVar("tying", {
	field = "tying",
	fieldType = ix.type.bool,
	default = false,
	isLocal = true,
	bNoDisplay = true
})

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

--[[ Comando para Ver Inventario ]]--

do
	local COMMAND = {}
	COMMAND.description = "Search on the body"
	function COMMAND:OnRun(client, arguments)
		local data = {}
			data.start = client:GetShootPos()
			data.endpos = data.start + client:GetAimVector() * 96
			data.filter = client
		local target = util.TraceLine(data).Entity

		if (IsValid(target) and target:IsPlayer() and target:IsRestricted()) then
			if (!client:IsRestricted()) then
				Schema:SearchPlayer(client, target)
			else
				return "@notNow"
			end
		end
	end

	ix.command.Add("CharSearch", COMMAND)
end