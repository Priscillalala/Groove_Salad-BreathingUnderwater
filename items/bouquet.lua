---@class Bouquet : ItemModule
local bouquet, identifier = ...

if not bouquet then
    bouquet = {}
    bouquet.id = gm.item_create(namespace, identifier)
    local item = get(class_item, bouquet.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.common)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_utility)

    local sRecord = load_sprite("sRecord", 17, 17)
    set(item, CLASS_ITEM.sprite_id, sRecord)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sRecord)

    bouquet.log_id = gm.item_log_create(namespace, identifier, 0, sRecord)
    local item_log = get(class_item_log, bouquet.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))
    set(item, CLASS_ITEM.item_log_id, bouquet.log_id)
end

local bonus_maxhp_base

---[[
gm.pre_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, bouquet.id)
    if item_stack > 0 then
        bonus_maxhp_base = 5 * item_stack
        self.maxhp_base = self.maxhp_base + bonus_maxhp_base
    end
end)
--]]

---[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, bouquet.id)
    if item_stack > 0 then
        --damage (flat) +1  (1!)
        --attack speed (basically flat) NOT +1 (4)
        --move speed NOT +1 (6)
        --crit chance (flat kinda) +1? (2)
        --regen (flat) NOT +1 (0.07)
        --armor (flat) +1   (3)
        --max hp (flat) +  (5!)

        --[[
            +1 damage (unknown)
            +2 crit chance (~25% glasses)
            +3 armor (~37% of root)
            +4% attack speed (33% of syringe)
            +5 max hp (unknown)
            +0.06 move speed (14% of hoof)
            +0.07 regen (8.3% of vial)
            total 119% + 2 unknown (estimated around 30%)
            about 150% of the sum of its parts
        ]]
        self.damage = self.damage + item_stack
        self.critical_chance = self.critical_chance + 2 * item_stack
        self.armor = self.armor + 3 * item_stack
        self.attack_speed = self.attack_speed + 0.04 * item_stack
        self.pHmax = self.pHmax + 0.06 * item_stack
        self.hp_regen = self.hp_regen + 0.07 * item_stack / 60
    end
    if bonus_maxhp_base then
        self.maxhp_base = self.maxhp_base - bonus_maxhp_base
        bonus_maxhp_base = nil
    end
end)
--]]

return bouquet