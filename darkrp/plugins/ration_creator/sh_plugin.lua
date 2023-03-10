PLUGIN.name = "Ration Creator C.W.U"
PLUGIN.description = ""
PLUGIN.author = "Lister"

ix.allowedHoldableClasses = {
    ["ix_item"]                  = true,
    ["ix_money"]                 = true,
    ["ix_shipment"]              = true,
    ["prop_physics"]             = true,
    ["prop_physics_override"]    = true,
    ["prop_physics_multiplayer"] = true,
    ["prop_ragdoll"]             = true,
    ["ix_box"]                   = true,
    ["ix_box01"]                 = true,
    ["ix_box02"]                 = true,
    ["ix_box03"]                 = true,
    ["ix_water"]                 = true,
    ["ix_food"]                  = true,
    ["ix_pack"]                  = true,
    ["ix_packfood"]              = true,
    ["ix_packdrink"]             = true,
    ["ix_packfull"]              = true
}

function PLUGIN:CanPlayerHoldObject(client, entity)
    if (ix.allowedHoldableClasses[entity:GetClass()]) then
        return true
    end
end