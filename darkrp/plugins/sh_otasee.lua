PLUGIN.name = "OTA visibility"
PLUGIN.author = "Unknown"
PLUGIN.description = "Ability to see other OTA on scoreboard."



function Schema:ShouldShowPlayerOnScoreboard(client)
    
    if LocalPlayer():GetCharacter():GetFaction()~=FACTION_OTA and LocalPlayer():GetCharacter():GetFaction()~=FACTION_OWAF and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADVISOR and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADMIN then
        if client:GetCharacter():GetFaction()==FACTION_OTA then
            return false
        end
    end

   if LocalPlayer():GetCharacter():GetFaction()~=FACTION_OTA and LocalPlayer():GetCharacter():GetFaction()~=FACTION_OWAF and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADVISOR and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADMIN then
        if client:GetCharacter():GetFaction()==FACTION_OWAF then
            return false
        end
    end

   if LocalPlayer():GetCharacter():GetFaction()~=FACTION_OTA and LocalPlayer():GetCharacter():GetFaction()~=FACTION_OWAF and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADVISOR and LocalPlayer():GetCharacter():GetFaction()~=FACTION_ADMIN then
        if client:GetCharacter():GetFaction()==FACTION_ADVISOR then
            return false
        end
    end

end