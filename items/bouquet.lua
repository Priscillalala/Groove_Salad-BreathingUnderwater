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

---[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, bouquet.id)
    if item_stack > 0 then
        --damage (flat)
        --attack speed (basically flat)
        --move speed
        --crit chance (flat kinda)
        --regen (flat)
        --armor (flat)
        --max hp (flat)
        self.damage = self.damage + item_stack
        self.attack_speed = self.attack_speed + item_stack
        self.pHmax = self.pHmax + (self.pHmax_base * 0.2 * item_stack)
        self.critical_chance = self.critical_chance + item_stack
        self.hp_regen = self.hp_regen + 0.003
        self.armor = self.armor + item_stack
        self.maxhp = self.maxhp + item_stack
    end
end)
--]]

return bouquet