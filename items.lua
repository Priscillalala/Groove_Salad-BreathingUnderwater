---@enum class_item
CLASS_ITEM = {
    namespace = 0,
    identifier = 1,
    token_name = 2,
    token_text = 3,
    on_acquired = 4,
    on_removed = 5,
    tier = 6,
    sprite_id = 7,
    object_id = 8,
    item_log_id = 9,
    achievement_id = 10,
    is_hidden = 11,
    effect_display = 12,
    actor_component = 13,
    loot_tags = 14,
    is_new_item = 15,
}

---@enum class_item_log
CLASS_ITEM_LOG = {
    namespace = 0,
    identifier = 1,
    token_name = 2,
    token_description = 3,
    token_story = 4,
    token_date = 5,
    token_destination = 6,
    token_priority = 7,
    pickup_object_id = 8,
    sprite_id = 9,
    group = 10,
    achievement_id = 11,
}

---@enum item_tier
ITEM_TIER = {
	common = 0,
	uncommon = 1,
	rare = 2,
	equipment = 3,
	boss = 4,
	special = 5,
	food = 6,
	notier = 7,
}

---@enum loot_tag
LOOT_TAG =  {
	category_damage  = (1 << 0),
	category_healing = (1 << 1),
	category_utility = (1 << 2),
	equipment_blacklist_enigma = (1 << 3),
	equipment_blacklist_chaos = (1 << 4),
	equipment_blacklist_activator = (1 << 5),
	item_blacklist_engi_turrets = (1 << 6),
	item_blacklist_vendor = (1 << 7),
	item_whitelist_infuser = (1 << 8),
}

local class_item = gm.variable_global_get("class_item")
local class_item_log = gm.variable_global_get("class_item_log")

---@class Items
local items = {}

items.monkeyMask_id = gm.item_create(namespace, "monkeyMask")
log.info(items.monkeyMask_id)
local monkeyMask = get(class_item, items.monkeyMask_id)
log.info(get(monkeyMask, CLASS_ITEM.identifier))
--gm.array_set(test_item, CLASS_ITEM.tier, 1.0)
set(monkeyMask, CLASS_ITEM.tier, ITEM_TIER.rare)
set(monkeyMask, CLASS_ITEM.sprite_id, gm.constants.sAncientValley2TitleDoodads4)

local monkeyMask_log_id = gm.item_log_create(namespace, "monkeyMask", 4, gm.constants.sAncientValley2TitleDoodads4)
local monkeyMask_log = get(class_item_log, monkeyMask_log_id)
set(monkeyMask_log, CLASS_ITEM_LOG.pickup_object_id, get(monkeyMask, CLASS_ITEM.object_id))

set(monkeyMask, CLASS_ITEM.item_log_id, monkeyMask_log_id)

add_language({
    item = {
        monkeyMask = {
            name = "Second Soul",
            pickup = "Increase attack speed and guarantee Critical strikes after taking damage.",
            description = "Gain <y>18% attack speed</c> and <y>100% critical strike chance</c> for <y>2 <c_stack>(+1 per stack) <y>seconds</c> after getting hurt.",
            destination = "going here",
            date = "5/01/2056",
            story = "blah blah blah"
        }
    }
})

return items