local plugin_path = _ENV["!plugins_mod_folder_path"]
local language_path = path.combine(plugin_path, "language")
local fallback_language = "english"

local function try_load_language(language)
    local path = path.combine(language_path, language .. ".json")
    local file_string = gm.string_read_file(path)
    if file_string and file_string ~= "" then
        local language_json = gm.json_parse(file_string)
        gm.translate_load_file_internal(gm.variable_global_get("_language_map"), language_json, "")
    end
end

gm.post_script_hook(gm.constants.translate_load_active_language, function (self, other, result, args)
    local active_language = gm.translate_lang_get_active()
    if active_language ~= fallback_language then
        try_load_language(fallback_language)
    end
    try_load_language(active_language)
end)