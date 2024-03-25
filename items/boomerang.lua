---@class Boomerang : ItemModule
local boomerang, identifier = ...

if not boomerang then
    boomerang = {}
    boomerang.id = gm.item_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.common,
        custom_item_pickup(identifier, load_sprite("sBoomerang", 18, 18)),
        LOOT_TAG.category_damage,
        nil,
        nil,
        true,
        0
    )
end

local is_boomerang_identifier = namespace .. "-is_boomerang"
local sBoomerangThrown = load_sprite("sBoomerangThrown", 18, 18)

---[[
gm.post_script_hook(gm.constants.skill_util_update_heaven_cracker, function(self, other, result, args)
    local actor = args[1].value
    local stack = get(actor.inventory_item_stack, boomerang.id)
    if not stack or stack <= 0 or gm.random(100) > 9 then
        return
    end
    local damage = args[2].value
    local xscale = args[3].value or actor.image_xscale
    local instance = gm.instance_create(actor.x, actor.y, gm.constants.oChefKnife)
    if xscale >= 0 then
        instance.direction = 0
    else
        instance.direction = 180
    end
    instance.damage_coeff = damage * stack
    instance.parent = actor
    instance.team = actor.team
    instance.sprite_index = sBoomerangThrown
    instance[is_boomerang_identifier] = true
end)
--]]

local is_boomerang = false

gm.pre_script_hook(gm.constants.draw_line_width_colour, function(self, other, result, args)
    if is_boomerang then
        return false
    end
end)

gm.pre_script_hook(gm.constants.fire_direct, function(self, other, result, args)
    if is_boomerang then
        args[1].value = 2
        args[6].value = gm.constants.sSparks11
    end
end)

object_pre_hooks["gml_Object_oChefKnife_Draw_0"] = function (self)
    if self[is_boomerang_identifier] then
        is_boomerang = true
    end
end

object_post_hooks["gml_Object_oChefKnife_Draw_0"] = function (self)
    is_boomerang = false
end

object_pre_hooks["gml_Object_oChefKnife_Collision_pActorCollisionBase"] = function (self)
    if self[is_boomerang_identifier] then
        is_boomerang = true
    end
end

object_post_hooks["gml_Object_oChefKnife_Collision_pActorCollisionBase"] = function (self)
    is_boomerang = false
end

return boomerang