---@class MetalDetector : ItemModule
local metalDetector, identifier = ...

if not metalDetector then
    metalDetector = {}
    metalDetector.id = gm.item_create(namespace, identifier)
    local item = get(class_item, metalDetector.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.uncommon)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_utility)

    local sMonkeyMask = load_sprite("sXray.png", 20, 20)
    set(item, CLASS_ITEM.sprite_id, sMonkeyMask)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sMonkeyMask)

    metalDetector.log_id = gm.item_log_create(namespace, identifier, 2, sMonkeyMask)
    local item_log = get(class_item_log, metalDetector.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))

    set(item, CLASS_ITEM.item_log_id, metalDetector.log_id)
end

---@param player any
---@param stack integer
local function create_pickups_for_player(player, stack)
    for i = 1, 3 do
        local pickup_object_id = gm.treasure_weights_roll_pickup(29)
        for _ = 1, stack - 1 do
            local other_pickup_object_id = gm.treasure_weights_roll_pickup(29)
            local item = get(class_item, gm.object_to_item(pickup_object_id))
            local other_item = get(class_item, gm.object_to_item(other_pickup_object_id))
            if (not item) or (other_item and get(other_item, CLASS_ITEM.tier) > get(item, CLASS_ITEM.tier)) then
                pickup_object_id = other_pickup_object_id
                log.info("upgrade pickup!")
            end
        end
        local pickup = gm.item_pickup_create(player.x, player.y, 1, pickup_object_id, 0)
        pickup.item_stack_kind = 1
    end
end

object_pre_hooks["gml_Object_pTeleporter_Step_2"] = function (self)
    if self.active == 0 or self.just_activated ~= 0 then
        return
    end
    log.info("gml_Object_pTeleporter_Step_2")
    for _, instance in ipairs(gm.CInstance.instances_active) do
        if instance.object_index == gm.constants.oP and not instance.dead then
            local stack = get(instance.inventory_item_stack, metalDetector.id)
            if stack > 0 then
                create_pickups_for_player(instance, stack)
            end
        end
    end
end

--[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local item_stack = get(self.inventory_item_stack, metalDetector.id)
    if item_stack > 0 then
        self.critical_chance = self.critical_chance + 100
        self.attack_speed = self.attack_speed + 0.18
        self.pHmax = 10
    end
end)
--]]

--[[
gm.post_script_hook(gm.constants.treasure_weights_roll_pickup, function(self, other, result, args)
    log.info("treasure_weights_roll_pickup: " .. #args)
    for index, value in ipairs(args) do
       log.info(value.value)
    end
    log.info("result: " .. result.value)
end)
--]]

return metalDetector