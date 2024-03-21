---@class Boomerang : ItemModule
local boomerang, identifier = ...

if not boomerang then
    boomerang = {}
    boomerang.id = gm.item_create(namespace, identifier)
    local item = get(class_item, boomerang.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.common)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_damage)

    local sMonkeyMask = load_sprite("sXray.png", 20, 20)
    set(item, CLASS_ITEM.sprite_id, sMonkeyMask)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sMonkeyMask)

    boomerang.log_id = gm.item_log_create(namespace, identifier, 0, sMonkeyMask)
    local item_log = get(class_item_log, boomerang.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))

    set(item, CLASS_ITEM.item_log_id, boomerang.log_id)

    add_language {
        item = {
            boomerang = {
                name = "Boomerang",
                pickup = "Search and destroy.",
                description = "<b>Collecting an item</c> increases <y>movement speed</c> by <b>20% <c_stack>(+20% per stack)</c> for <b>15 seconds</c>.",
                destination = "going here",
                date = "5/01/2056",
                story = "blah blah blah"
            }
        }
    }
end

log.info(gm.constants.skill_util_facing_direction)

---[[
gm.post_script_hook(gm.constants.skill_util_update_heaven_cracker, function(self, other, result, args)
    log.info("skill_util_update_heaven_cracker: " .. #args)
    local actor = args[1].value
    local damage = args[2].value
    local xscale = args[3].value or actor.image_xscale
    log.info("hi")
    log.info(gm.constants.oChefKnife)
    local instance = gm.instance_create(actor.x, actor.y, gm.constants.oChefKnife)
    if xscale >= 0 then
        instance.direction = 0
    else
        instance.direction = 180
    end
    log.info(instance.direction)
    instance.damage_coeff = damage
    instance.parent = actor
    instance.team = actor.team
    instance.sprite_index = gm.constants.sBuffDroneEmpower
    instance.is_boomerang = true
end)
--]]

local prevent_line_draw = false

log.info(gm.constants.draw_line_width_colour)
gm.pre_script_hook(gm.constants.draw_line_width_colour, function(self, other, result, args)
    if prevent_line_draw then
        return false
    end
end)

object_pre_hooks["gml_Object_oChefKnife_Draw_0"] = function (self)
    if self.is_boomerang then
        log.info("is boomerang")
        prevent_line_draw = true
    end
end

object_post_hooks["gml_Object_oChefKnife_Draw_0"] = function (self)
    prevent_line_draw = false
end

--[[
gm.post_script_hook(gm.constants.instance_create, function(self, other, result, args)
    log.info("instance_create: " .. #args)
    for index, value in ipairs(args) do
       log.info(value.value)
    end
end)
--]]

return boomerang