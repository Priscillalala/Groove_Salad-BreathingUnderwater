---@class MetalDetector : ItemModule
local metalDetector, identifier = ...

if not metalDetector then
    metalDetector = {}
    metalDetector.id = gm.item_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.uncommon,
        custom_item_pickup(identifier, load_sprite("sMetalDetector", 17, 17)),
        LOOT_TAG.category_utility | LOOT_TAG.item_blacklist_engi_turrets,
        nil,
        nil,
        true,
        2
    )
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
            if not item or (other_item and get(other_item, CLASS_ITEM.tier) > get(item, CLASS_ITEM.tier)) then
                pickup_object_id = other_pickup_object_id
            end
        end
        gm.item_set_dibs(player)
        local pickup = gm.instance_create(player.x + 50 * player.image_xscale * i, player.y, pickup_object_id)
        pickup.xstart = player.x
        pickup.item_stack_kind = 1
    end
end

local function on_teleporter_activated()
    log.info("Teleporter activated!")
    for _, instance in ipairs(gm.CInstance.instances_active) do
        if instance.object_index == gm.constants.oP and not instance.dead then
            local stack = get(instance.inventory_item_stack, metalDetector.id)
            if stack > 0 then
                create_pickups_for_player(instance, stack)
            end
        end
    end
end

object_pre_hooks["gml_Object_pTeleporter_Step_2"] = function (self)
    if self.active == 0 or self.just_activated ~= 0 then
        return
    end
    on_teleporter_activated()
end

object_pre_hooks["gml_Object_oCommand_Step_2"] = function (self)
    if self.active == 0 or self.just_activated ~= 0 then
        return
    end
    on_teleporter_activated()
end

return metalDetector