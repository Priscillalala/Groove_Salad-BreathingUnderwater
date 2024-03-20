---@class SpeedOnPickup : ItemModule
local speedOnPickup, identifier = ...

if not speedOnPickup then
    speedOnPickup = {}
    speedOnPickup.id = gm.item_create(namespace, identifier)
    local item = get(class_item, speedOnPickup.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.common)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_utility)

    local sMonkeyMask = load_sprite("sXray.png", 20, 20)
    set(item, CLASS_ITEM.sprite_id, sMonkeyMask)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sMonkeyMask)

    speedOnPickup.log_id = gm.item_log_create(namespace, identifier, 0, sMonkeyMask)
    local item_log = get(class_item_log, speedOnPickup.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))

    set(item, CLASS_ITEM.item_log_id, speedOnPickup.log_id)

    speedOnPickup.buff_id = gm.buff_create(namespace, "speedOnPickupBuff")
    local buff = get(class_buff, speedOnPickup.buff_id)
    set(buff, CLASS_BUFF.icon_sprite, load_sprite("sBuffRage.png", 12, 8))
    set(buff, CLASS_BUFF.show_icon, true)

    add_language {
        item = {
            speedOnPickup = {
                name = "Speed on pickup",
                pickup = "Move faster after collecting an item.",
                description = "<b>Collecting an item</c> increases <y>movement speed</c> by <b>20% <c_stack>(+20% per stack)</c> for <b>15 seconds</c>.",
                destination = "going here",
                date = "5/01/2056",
                story = "blah blah blah"
            }
        }
    }
end

local onPickupCollected = gm.array_get_index(callback_names, "onPickupCollected")

post_callback_hooks[onPickupCollected] = function (self, other, result, args)
    log.info("pickup collected")
    for index, value in ipairs(args) do
        log.info(value.value)
    end
    local pickup = args[2].value
    local player = args[3].value
    if pickup.equipment_id and pickup.equipment_id >= 0 and player.inventory_equipment and player.inventory_equipment >= 0 then
       return
    end
    local item_stack = get(player.inventory_item_stack, speedOnPickup.id)
    if item_stack > 0 then
        gm.apply_buff(player, speedOnPickup.buff_id, 60 * 15)
    end
end

---[[
gm.post_script_hook(gm.constants.recalculate_stats, function(self, other, result, args)
    local buff_stack = get(self.buff_stack, speedOnPickup.buff_id)
    if buff_stack > 0 then
        local item_stack = get(self.inventory_item_stack, speedOnPickup.id)
        self.pHmax = self.pHmax + (self.pHmax_base * 0.2 * item_stack)
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

return speedOnPickup