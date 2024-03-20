---@class ItemModule
---@field id integer
---@field log_id integer

---@type table<string, ItemModule>
local items = ...

if not items then
    items = {}
    gui.add_imgui(function()
        if ImGui.Begin("Debug") then
            for identifier, module in pairs(items) do
                if ImGui.Button("Give " .. identifier) then
                    for _, instance in ipairs(gm.CInstance.instances_active) do
                        if instance.object_index == gm.constants.oP then
                            local item = get(class_item, module.id)
                            --gm.item_give(instance, test_item_id, 1, 0)
                            gm.item_pickup_create(instance.x, instance.y, 1, get(item, CLASS_ITEM.object_id), 0).item_stack_kind = 1
                            break
                        end
                    end
                end
            end
            ImGui.End()
        end
    end)
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

return items