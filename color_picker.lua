---
--- Color Picker Plugin
--- Generate a visual color picker
---

--- Color picker show vars
color_picker_page_var = "color_picker_page_index";
color_picker_macro_var = "color_picker_macro_start_index";
color_picker_sequence_var = "color_picker_sequence_start_index";

--- Color picker values
color_picker_exec_page_index = "";
color_picker_macro_start_index = "";
color_picker_sequence_start_index = "";

function create_color_picker_macros()
    local exec_button_start = 100;
    local macro_index = _G.color_picker_macro_start_index;

    log("Creating color picker macro's...")
    for group = 1, 7, 1 do
        log("Creating color picker macros on line " .. macro_index)
        local exec_button = exec_button_start + group;

        for cue = 1, 12, 1 do
            local macro = tonumber(macro_index) + cue;
            gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Goto Executor %s Cue %i\"", macro, get_color_picker_executor(exec_button), cue));
        end

        macro_index = macro_index + 16;
    end
    log("Done creating color picker macro's")
end

function create_color_picker_fade_macros()
    log("Creating color picker fade macro's...")
    local macro_index = get_color_picker_fade_macro_start_index();

    -- 0.0s fade
    create_color_picker_fade_macro(macro_index, 0.0)
    -- 0.5s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 0.5)
    -- 1.0s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 1.0)
    -- 1.5s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 1.5)
    -- 2s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 2.0)
    -- 4s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 4.0)
    -- 8s fade
    macro_index = macro_index + 1;
    create_color_picker_fade_macro(macro_index, 8.0)

    log("Done creating color picker fade macro's")
end

function get_color_picker_executor(executor_index)
    return string.format("%i.%i", _G.color_picker_exec_page_index, executor_index);
end

function get_color_picker_fade_macro_start_index()
    return _G.color_picker_macro_start_index + 113;
end

--- Create a new fade macro
---@param macro_index number The macro index to create the fade macro in
---@param fade_time number The fade time that the fade macro applies to the color picker
function create_color_picker_fade_macro(macro_index, fade_time)
    local fade_macro_start_index = get_color_picker_fade_macro_start_index();
    local fade_macro_end_index = fade_macro_start_index + 6;

    log("Creating fade macro at index " .. macro_index);

    -- delete existing macro
    delete_macro(macro_index);
    -- create macro and assign name
    gma.cmd(string.format("Store Macro %i /o /nc", macro_index));
    gma.cmd(string.format("Assign Macro %i /name=\"Fade %ss\"", macro_index, fade_time));
    -- create macro lines
    gma.cmd(string.format("Store Macro 1.%i.1 Thru 1.%i.3", macro_index, macro_index));
    -- assign cmd commands to macro lines
    gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Assign Sequence %i Thru %i Cue 1 Thru 12 /fade = %s\"",
            macro_index, _G.color_picker_sequence_start_index, _G.color_picker_sequence_start_index + 7, fade_time));
    gma.cmd(string.format("Assign Macro 1.%i.2 /cmd=\"Appearance Macro %i Thru %i - %i %s\"",
            macro_index, fade_macro_start_index, fade_macro_end_index, macro_index, get_color_green()));
    gma.cmd(string.format("Assign Macro 1.%i.3 /cmd=\"Appearance Macro %i %s\"",
            macro_index, macro_index, get_color_red()));
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    -- Set plugin name for logging
    _G.plugin_name = "Color Picker";

    -- Request the executor page for the generic color picker
    _G.color_picker_exec_page_index = show_user_var_input_number(_G.color_picker_page_var, "Executor page for Color Picker");
    -- The start of the macro index for the color picker
    _G.color_picker_macro_start_index = show_user_var_input_number(_G.color_picker_macro_var, "Macro start index of the Color Picker");
    -- The start of the sequence index for the color picker
    _G.color_picker_sequence_start_index = show_user_var_input_number(_G.color_picker_sequence_var, "Sequence start index of the Color Picker");

    create_color_picker_macros();
    create_color_picker_fade_macros();
end

function finalize()
end

return main, finalize;