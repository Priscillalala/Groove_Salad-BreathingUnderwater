---@class ItemModule
---@field id integer
---@field log_id integer

---@type table<string, ItemModule>
local items = ... or {}

local treasure_loot_pools = gm.variable_global_get("treasure_loot_pools")

function add_item_to_loot_pool(item)
    local tier = get(item, CLASS_ITEM.tier)
    local loot_pool = get(treasure_loot_pools, gm.ITEM_TIER_to_LOOT_POOL_INDEX(tier))
    local drop_pool = gm.struct_get(loot_pool, "drop_pool")
    gm.ds_list_add(drop_pool, get(item, CLASS_ITEM.object_id))
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
--include_item("bouquet")

return items