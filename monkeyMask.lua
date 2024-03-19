---@class MonkeyMask : ItemModule
local monkeyMask, identifier = ...

if not monkeyMask then
    monkeyMask = {}
    monkeyMask.id = gm.item_create(namespace, identifier)
    local item = get(class_item, monkeyMask.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.rare)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_damage)

    local sMonkeyMask = load_sprite("sMonkeyMask.png", 20, 20)
    set(item, CLASS_ITEM.sprite_id, sMonkeyMask)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sMonkeyMask)

    monkeyMask.log_id = gm.item_log_create(namespace, identifier, 4, sMonkeyMask)
    local item_log = get(class_item_log, monkeyMask.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))

    set(item, CLASS_ITEM.item_log_id, monkeyMask.log_id)

    monkeyMask.rage_id = gm.buff_create(namespace, "rage")
    local rage = get(class_buff, monkeyMask.rage_id)
    set(rage, CLASS_BUFF.icon_sprite, load_sprite("sBuffRage.png", 12, 8))
    set(rage, CLASS_BUFF.show_icon, true)

    add_language {
        item = {
            monkeyMask = {
                name = "Second Soul",
                pickup = "Increase attack speed and guarantee Critical strikes after taking damage.",
                description = "Gain <y>18% attack speed</c> and <y>100% critical strike chance</c> for <y>2 <c_stack>(+1 per stack) <y>seconds</c> after getting hurt.",
                destination = "going here",
                date = "5/01/2056",
                story = "blah blah blah"
            }
        }
    }
end


---[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local buff_stack = get(self.buff_stack, monkeyMask.rage_id)
    if buff_stack > 0 then
        self.critical_chance = self.critical_chance + 100
        self.attack_speed = self.attack_speed + 0.18
    end
end)
--]]

---[[
gm.pre_script_hook(gm.constants.actor_proc_on_damage, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, monkeyMask.id)
    if item_stack > 0 then
        gm.apply_buff(self, monkeyMask.rage_id, 60 + 60 * item_stack)
    end
end)
--]]

return monkeyMask