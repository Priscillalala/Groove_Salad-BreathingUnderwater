namespace = "breathingUnderwater"

---@enum class_buff
CLASS_BUFF  = {
	namespace = 0,
	identifier = 1,
	show_icon = 2,
	icon_sprite = 3,
	icon_subimage = 4,
	icon_frame_speed = 5,
	icon_stack_subimage = 6,
	draw_stack_number = 7,
	stack_number_col = 8,
	max_stack = 9,
	on_apply = 10,
	on_remove = 11,
	on_step = 12,
	is_timed = 13,
	is_debuff = 14,
	client_handles_removal = 15,
	effect_display = 16,
}

class_buff = gm.variable_global_get("class_buff")

---@class class_item
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

class_item = gm.variable_global_get("class_item")
class_item_log = gm.variable_global_get("class_item_log")