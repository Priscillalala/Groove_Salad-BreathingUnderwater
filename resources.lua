local resources_path = path.combine(_ENV["!plugins_mod_folder_path"], "resources")
local sprites_path = path.combine(resources_path, "sprites")

---@type table<string, string>
local full_sprite_paths = {}

for _, file in ipairs(path.get_files(sprites_path)) do
    full_sprite_paths[path.stem(file)] = file
end

---@param file string
---@param x_orig integer
---@param y_orig integer
---@param sub_image_number integer?
---@return number
function load_sprite(file, x_orig, y_orig, sub_image_number)
    return gm.sprite_add(full_sprite_paths[file] or path.combine(sprites_path, file), sub_image_number or 1, false, false, x_orig, y_orig)
end