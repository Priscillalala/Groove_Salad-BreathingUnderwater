---@class Xray : ItemModule
local xray, identifier = ...

if not xray then
    xray = {}
    xray.id = gm.item_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.rare,
        custom_item_pickup(identifier, load_sprite("sXray", 15, 16)),
        LOOT_TAG.category_utility | LOOT_TAG.item_blacklist_engi_turrets,
        nil,
        nil,
        true,
        4
    )
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