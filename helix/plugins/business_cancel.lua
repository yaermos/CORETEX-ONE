local PLUGIN = PLUGIN

PLUGIN.name = "Business cancel"
PLUGIN.author = "Huargenn"
PLUGIN.description = "Cancel the use of business menu"

function PLUGIN:CanPlayerUseBusiness(client, uniqueID)
	return false
end