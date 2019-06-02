---
--- Color Picker Plugin
--- Generate a visual color picker
---

--- Color picker show vars
color_picker_page_var = "color_picker_page_index";
color_picker_macro_var = "color_picker_macro_start_index";

--- Color picker values
color_picker_exec_page_index = "";
color_picker_macro_start_index = "";

function create_color_picker_macros()
    local exec_button_start = 100;

    log("Creating color picker macro's...")
    for group = 1, 7, 1 do
        log("Creating color picker macros on line " .. _G.color_picker_macro_start_index)
        local exec_button = exec_button_start + group;

        for cue = 1, 12, 1 do
            local macro = tonumber(_G.color_picker_macro_start_index) + cue;
            gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Goto Executor %s Cue %i\"", macro, get_color_picker_executor(exec_button), cue));
        end

        _G.color_picker_macro_start_index = _G.color_picker_macro_start_index + 16;
    end
    log("Done creating color picker macro's")
end

function get_color_picker_executor(executor_index)
    return string.format("%i.%i", _G.color_picker_exec_page_index, executor_index);
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

    create_color_picker_macros();
end

function finalize()
end

return main, finalize;