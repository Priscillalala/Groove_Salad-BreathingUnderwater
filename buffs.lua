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

local class_buff = gm.variable_global_get("class_buff")

---@class Buffs
local buffs = {}

buffs.rage_id = gm.buff_create(namespace, "rage")
local rage = get(class_buff, buffs.rage_id)
set(rage, CLASS_BUFF.icon_sprite, gm.constants.sMonitorFaceRightALT)
set(rage, CLASS_BUFF.show_icon, true)

buffs.secondary_id = gm.buff_create(namespace, "secondary")

return buffs