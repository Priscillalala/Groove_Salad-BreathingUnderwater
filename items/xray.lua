---@class Xray : ItemModule
local xray, identifier = ...

if not xray then
    xray = {}
    xray.id = gm.item_create(namespace, identifier)
    local item = get(class_item, xray.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.rare)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_utility | LOOT_TAG.item_blacklist_engi_turrets)

    local sXray = load_sprite("sXray", 15, 16)
    set(item, CLASS_ITEM.sprite_id, sXray)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sXray)

    xray.log_id = gm.item_log_create(namespace, identifier, 4, sXray)
    local item_log = get(class_item_log, xray.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))

    set(item, CLASS_ITEM.item_log_id, xray.log_id)

    add_item_to_loot_pool(item)
end

local lock = false
---[[
gm.post_script_hook(gm.constants.item_drop_boss, function(self, other, result, args)
    if not lock then
        local count = 0
        for _, instance in ipairs(gm.CInstance.instances_active) do
            if instance.object_index == gm.constants.oP and not instance.dead then
                count = count + get(instance.inventory_item_stack, xray.id)
            end
        end
        for _ = 1, count do
            lock = true
            gm.call("item_drop_boss", self, other, args)
            lock = false
        end
    end
end)
--]]

return xray