---@class EquipmentModule
---@field id integer

---@type table<string, ItemModule>
local equipment = ... or {}

-- if this is not a separate function then the game crashes..
local function custom_equipment_pickup_object(identifier)
    return gm.object_add_w(namespace, "generated_EquipmentPickup_" .. identifier, gm.constants.pPickupEquipment)
end

---@param identifier string
---@param sprite number
---@return number
function custom_equipment_pickup(identifier, sprite)
    local object = custom_equipment_pickup_object(identifier)
    gm.object_set_depth(object, -290)
    gm.object_set_sprite_w(object, sprite)
    return object
end

---@param identifier string
local function include_equipment(identifier)
    ---@diagnostic disable-next-line: redundant-parameter
    equipment[identifier] = require("./" .. identifier, equipment[identifier], identifier)
end

include_equipment("geode")

return equipment