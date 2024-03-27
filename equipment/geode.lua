---@class Geode : EquipmentModule
local geode, identifier = ...

if not geode then
    geode = {}
    geode.id = gm.equipment_create(
        namespace,
        identifier,
        nil,
        ITEM_TIER.equipment,
        nil,
        LOOT_TAG.category_healing | LOOT_TAG.category_utility,
        nil,
        nil,
        true,
        6
    )
end

local equipment = get(class_equipment, geode.id)
local on_use = get(equipment, CLASS_EQUIPMENT.on_use)

post_callback_hooks[on_use] = function (self, other, result, args)
    log.info("used the .. Geode!")
end

return geode