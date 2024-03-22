local language_path = path.combine(_ENV["!plugins_mod_folder_path"], "language")
local fallback_language = "english"

local function try_load_language(language)
    local path = path.combine(language_path, language .. ".json")
    if gm.file_exists(path) > 0 then
        gm.translate_load_file(gm.variable_global_get("_language_map"), path)
    else
        log.warning("No " .. language .. " translation found :(")
    end
end

gm.post_script_hook(gm.constants.translate_load_active_language, function (self, other, result, args)
    local active_language = gm.translate_lang_get_active()
    if active_language ~= fallback_language then
        try_load_language(fallback_language)
    end
    try_load_language(active_language)
end)