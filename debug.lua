gui.add_imgui(function()
    if ImGui.Begin("My Items") then
        for identifier, module in pairs(items) do
            if ImGui.Button("Give " .. identifier) then
                for _, instance in ipairs(gm.CInstance.instances_active) do
                    if instance.object_index == gm.constants.oP then
                        local item = get(class_item, module.id)
                        --gm.item_give(instance, test_item_id, 1, 0)
                        gm.item_pickup_create(instance.x, instance.y, 1, get(item, CLASS_ITEM.object_id), 0)
                        break
                    end
                end
            end
        end
        ImGui.End()
    end
    if ImGui.Begin("All Items") then
        for id, item in ipairs(class_item) do
            if ImGui.Button("Give " .. get(item, CLASS_ITEM.identifier)) then
                for _, instance in ipairs(gm.CInstance.instances_active) do
                    if instance.object_index == gm.constants.oP then
                        --gm.item_give(instance, test_item_id, 1, 0)
                        gm.item_pickup_create(instance.x, instance.y, 1, get(item, CLASS_ITEM.object_id), 0)
                        break
                    end
                end
            end
        end
        ImGui.End()
    end
end)

---[[
local english_path = path.combine(_ENV["!plugins_mod_folder_path"], "language", "english.json")
---@type string
local file_string = gm.string_read_file(english_path)
local substitutions = {
    --colors taken from the official wiki
    ["<y>"] = "$\\color{#e5C962}\\textsf{",
    ["<b>"] = "$\\color{#319ad2}\\textsf{",
    ["<g>"] = "$\\color{#7eb686}\\textsf{",
    ["<r>"] = "$\\color{#cf6666}\\textsf{",
    ["<c_stack>"] = "$\\color{#808080}\\textsf{",
    ["</c>"] = "}$",
    ["%%"] = "\\\\%%"
}
for pattern, repl in pairs(substitutions) do
    file_string = string.gsub(file_string, pattern, repl)
end
log.info(file_string)
--]]