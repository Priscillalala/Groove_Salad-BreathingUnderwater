---@class ItemModule
---@field id integer
---@field log_id integer

---@type table<string, ItemModule>
local items = ... or {}

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
--include_item("bouquet")

return items