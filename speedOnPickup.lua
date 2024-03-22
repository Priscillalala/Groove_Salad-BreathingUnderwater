---@class SpeedOnPickup : ItemModule
local speedOnPickup, identifier = ...

if not speedOnPickup then
    speedOnPickup = {}
    speedOnPickup.id = gm.item_create(namespace, identifier)
    local item = get(class_item, speedOnPickup.id)
    set(item, CLASS_ITEM.tier, ITEM_TIER.common)
    set(item, CLASS_ITEM.loot_tags, LOOT_TAG.category_utility)

    local sRecord = load_sprite("sRecord", 17, 17)
    set(item, CLASS_ITEM.sprite_id, sRecord)
    gm.object_set_sprite_w(get(item, CLASS_ITEM.object_id), sRecord)

    speedOnPickup.log_id = gm.item_log_create(namespace, identifier, 0, sRecord)
    local item_log = get(class_item_log, speedOnPickup.log_id)
    set(item_log, CLASS_ITEM_LOG.pickup_object_id, get(item, CLASS_ITEM.object_id))
    set(item, CLASS_ITEM.item_log_id, speedOnPickup.log_id)

    speedOnPickup.buff_id = gm.buff_create(namespace, "speedOnPickupBuff")
    local buff = get(class_buff, speedOnPickup.buff_id)
    set(buff, CLASS_BUFF.icon_sprite, load_sprite("sBuffRecord", 8, 9, 2))
    set(buff, CLASS_BUFF.show_icon, true)
    set(buff, CLASS_BUFF.icon_frame_speed, 0.03333)
    local paulsGoatHoof = get(class_item, 17)
    if paulsGoatHoof then
        local effect_display = gm["@@NewGMLObject@@"](gm.constants.EffectDisplayFunction)
        effect_display.draw_script = get(paulsGoatHoof, CLASS_ITEM.effect_display).draw_script
        set(buff, CLASS_BUFF.effect_display, effect_display)
    end
end

local onPickupCollected = gm.array_get_index(callback_names, "onPickupCollected")

post_callback_hooks[onPickupCollected] = function (self, other, result, args)
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

return speedOnPickup