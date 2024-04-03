---@class MonkeyMask : ItemModule
local monkeyMask, identifier = ...

if not monkeyMask then
    monkeyMask = {}
    monkeyMask.id = gm.item_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.rare,
        custom_item_pickup(identifier, load_sprite("sMonkeyMask", 20, 20)),
        LOOT_TAG.category_damage,
        nil,
        nil,
        true,
        4
    )

    monkeyMask.rage_id = gm.buff_create(namespace, "rage")
    local rage = get(class_buff, monkeyMask.rage_id)
    set(rage, CLASS_BUFF.icon_sprite, load_sprite("sBuffRage", 12, 8))
    set(rage, CLASS_BUFF.show_icon, true)
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
        local buff_stack = get(self.buff_stack, monkeyMask.rage_id)
        gm.apply_buff(self, monkeyMask.rage_id, 60 + 60 * item_stack)
        if buff_stack <= 0 then
            self:recalculate_stats()
        end
    end
end)
--]]

return monkeyMask