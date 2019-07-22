--- Position Picker show vars
position_picker_page_var = "position_picker_page_index";
position_picker_macro_var = "position_picker_macro_start_index";
position_picker_sequence_var = "position_picker_sequence_start_index";

exec_page_position_picker = "";
seq_start_index_position_picker = "";
macro_start_index_position_picker = "";

function create_position_picker_macros()
    local exec_button_start = 100;
    local macro_index = _G.macro_start_index_position_picker;
    local macro_row_labels = { "BEAMS", "SPOT", "WASH1", "WASH2", "LED1", "LED2", "ALL" };
    local macro_labels = { "LOWEST", "LOWER", "CENTER", "DEFAULT", "HIGHER", "HIGHEST", "SINGER", "G1", "G2", "KEYBOARD", "DRUMMER" };

    log("Creating position picker macro's...")
    for group = 1, 7, 1 do
        log("Creating position picker macros on line " .. macro_index)
        local exec_button = exec_button_start + group;

        -- create new row macro label
        gma.cmd(string.format("Store Macro %i", macro_index));
        gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro_index, macro_row_labels[group]));

        for cue = 1, 11, 1 do
            local macro = tonumber(macro_index) + cue;
            -- delete existing macro
            gma.cmd(string.format("Delete Macro %i", macro));
            -- create new macro and label
            gma.cmd(string.format("Store Macro %i", macro));
            gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro, macro_labels[cue]));

            gma.cmd(string.format("Store Macro 1.%i.1", macro))
            gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Goto Executor %s Cue %i\"", macro, get_position_picker_executor(exec_button), cue));
        end

        macro_index = macro_index + 16;
    end

    log("Done creating position picker macro's");
end

function get_position_picker_executor(executor_index)
    return string.format("%i.%i", _G.exec_page_position_picker, executor_index);
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    -- Set plugin name for logging
    _G.plugin_name = "Position Picker";

    -- Request executor page
    _G.exec_page_position_picker = show_user_var_input_number(_G.position_picker_page_var, "Executor page for Position Picker");
    -- The start of the macro index for the color picker
    _G.macro_start_index_position_picker = show_user_var_input_number(_G.position_picker_macro_var, "Macro start index of the Position Picker");
    -- Request sequence start index
    _G.seq_start_index_position_picker = show_user_var_input_number(_G.position_picker_sequence_var, "Sequence start index");

    -- set the page index for the executors
    _G.page_index = _G.exec_page_position_picker;

    create_position_picker_macros();
end

function finalize()
end

return main, finalize;