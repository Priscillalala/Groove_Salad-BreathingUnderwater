namespace = _ENV["!guid"]

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

---[[
gm.post_script_hook(gm.constants.init_actor_default, function(self, other, result, args)
    local count_buff = gm.variable_global_get("count_buff")
    if #self.buff_stack < count_buff then
        gm.array_resize(self.buff_stack, count_buff)
    end
end)
--]]

local function init()
    log.info("init!")
    register_language()
end

local hooks = {}
hooks["gml_Object_oStartMenu_Step_2"] = function()
    hooks["gml_Object_oStartMenu_Step_2"] = nil
    ---@type Items
    items = items or require "./items"
    ---@type Buffs
    buffs = buffs or require "./buffs"
    init()
end

gm.pre_code_execute(function(self, other, code, result, flags)
    if hooks[code.name] then
        hooks[code.name](self)
    end
end)

require "./monkeyMask"

local class_item = gm.variable_global_get("class_item")

gui.add_imgui(function()
    if ImGui.Begin("Debug") then
        for key, value in pairs(items) do
            if ImGui.Button("Give " .. key) then
                for _, instance in ipairs(gm.CInstance.instances_active) do
                    if instance.object_index == gm.constants.oP then
                        log.info(value)
                        local item = get(class_item, value)
                        --gm.item_give(instance, test_item_id, 1, 0)
                        gm.item_pickup_create(instance.x, instance.y, 0, get(item, CLASS_ITEM.object_id), 10)
                        break
                    end
                end
            end
        end
        ImGui.End()
    end
end)