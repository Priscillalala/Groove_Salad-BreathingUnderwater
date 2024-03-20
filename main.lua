---@param array any
---@param index integer
---@return unknown
function get(array, index)
    return gm.array_get(array, index)
end

---@param array any
---@param index integer
---@param value any
function set(array, index, value)
    gm.array_set(array, index, value)
end

---@type table<string, string>
local language = {}

---@param language_table table<string, table|string>
---@param root string?
function add_language(language_table, root)
    for key, value in pairs(language_table) do
        if root then
            key = root .. "." .. key
        end
        if type(value) == "table" then
            add_language(value, key)
        else
            language[key] = value
        end
    end
end

local function register_language()
    local _language_map = gm.variable_global_get("_language_map")
    for key, value in pairs(language) do
        log.info(key)
        gm.ds_map_set(_language_map, key, value)
    end
end

gm.post_script_hook(gm.constants.translate_load_file, function(self, other, result, args)
    log.info("translate_load_file")
    register_language()
end)

local plugin_path = _ENV["!plugins_mod_folder_path"]

---@param local_path string
---@param x_orig integer
---@param y_orig integer
---@param sub_image_number integer?
---@return number
function load_sprite(local_path, x_orig, y_orig, sub_image_number)
    return gm.sprite_add(path.combine(plugin_path, local_path), sub_image_number or 1, false, false, x_orig, y_orig)
end



--[[
gm.post_script_hook(gm.constants.buff_create, function(self, other, result, args)
   log.info("buff_create: " .. #args)
   for index, value in ipairs(args) do
      log.info(value.value)
   end
   log.info("result: " .. result.value)
end)
--]]

--[[
gm.post_script_hook(gm.constants.apply_buff, function(self, other, result, args)
   log.info("buff_create: " .. #args)
   for index, value in ipairs(args) do
      log.info(value.value)
   end
   --log.info("result: " .. result.value)
end)
--]]

--[[
gm.post_script_hook(gm.constants.object_set_sprite_w, function(self, other, result, args)
   log.info("object_set_sprite_w: " .. #args)
   for index, value in ipairs(args) do
      log.info(value.value)
   end
end)
--]]

---[[
gm.post_script_hook(gm.constants.init_actor_default, function(self, other, result, args)
    local count_buff = gm.variable_global_get("count_buff")
    if #self.buff_stack < count_buff then
        gm.array_resize(self.buff_stack, count_buff)
    end
end)
--]]

---@type table<string, fun(self): boolean?>
object_pre_hooks = {}

gm.pre_code_execute(function(self, other, code, result, flags)
    if object_pre_hooks[code.name] then
        return object_pre_hooks[code.name](self)
    end
end)

---@type table<string, fun(self)>
object_post_hooks = {}

gm.post_code_execute(function(self, other, code, result, flags)
    if object_post_hooks[code.name] then
        object_post_hooks[code.name](self)
    end
end)

local function init()
    log.info("init!")
    require("./globals")
    ---@diagnostic disable-next-line: redundant-parameter
    items = require("./items", items)
    register_language()
    hot_reloading = true
end

log.info("hot_reloading?")
log.info(hot_reloading)
if hot_reloading then
    init()
else
    object_pre_hooks["gml_Object_oStartMenu_Step_2"] = function()
        object_pre_hooks["gml_Object_oStartMenu_Step_2"] = nil
        init()
    end
end

callback_names = gm.variable_global_get("callback_names")
for index, value in ipairs(callback_names) do
    log.info(value)
end

---@type table<string, fun(self, other, result, args): boolean?>
pre_callback_hooks = {}

gm.pre_script_hook(gm.constants.callback_execute, function (self, other, result, args)
    local hook = pre_callback_hooks[args[1].value]
    if hook then
        return hook(self, other, result, args)
    end
end)

---@type table<string, fun(self, other, result, args)>
post_callback_hooks = {}

gm.post_script_hook(gm.constants.callback_execute, function (self, other, result, args)
    local hook = post_callback_hooks[args[1].value]
    if hook then
        hook(self, other, result, args)
    end
end)