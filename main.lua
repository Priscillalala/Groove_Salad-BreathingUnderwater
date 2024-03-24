require("./debug")
require("./language")
require("./resources")

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

-- for some reason I had to manually extend the buff stack array to fit new buffs
gm.post_script_hook(gm.constants.init_actor_default, function(self, other, result, args)
    local count_buff = gm.variable_global_get("count_buff")
    if #self.buff_stack < count_buff then
        gm.array_resize(self.buff_stack, count_buff)
    end
end)

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
    hot_reloading = true
end

if hot_reloading then
    log.info("hot reloading!")
    init()
else
    object_pre_hooks["gml_Object_oStartMenu_Step_2"] = function()
        object_pre_hooks["gml_Object_oStartMenu_Step_2"] = nil
        init()
    end
end

callback_names = gm.variable_global_get("callback_names")

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