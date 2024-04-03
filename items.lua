---@class ItemModule
---@field id integer

---@type table<string, ItemModule>
local items = ... or {}

-- if this is not a separate function then the game crashes..
local function custom_item_pickup_object(identifier)
    return gm.object_add_w(namespace, "generated_ItemPickup_" .. identifier, gm.constants.pPickupItem)
end

---@param identifier string
---@param sprite number
---@return number
function custom_item_pickup(identifier, sprite)
    local object = custom_item_pickup_object(identifier)
    gm.object_set_depth(object, -290)
    gm.object_set_sprite_w(object, sprite)
    return object
end

---@param identifier string
local function include_item(identifier)
    ---@diagnostic disable-next-line: redundant-parameter
    items[identifier] = require("./" .. identifier, items[identifier], identifier)
end

include_item("monkeyMask")
include_item("xray")
include_item("metalDetector")
include_item("speedOnPickup")
include_item("boomerang")
--include_item("goldCandy")
--include_item("bouquet")

return items