---[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local buff_stack = get(self.buff_stack, buffs.rage_id)
    if buff_stack > 0 then
        self.critical_chance = self.critical_chance + 100
        self.attack_speed = self.attack_speed + 0.18
    end
end)
--]]

---[[
gm.pre_script_hook(gm.constants.actor_proc_on_damage, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, items.monkeyMask_id)
    if item_stack > 0 then
        gm.apply_buff(self, buffs.rage_id, 60 + 60 * item_stack)
    end
end)
--]]