--- Position Picker show vars
position_picker_page_var = "position_picker_page_index";
position_picker_macro_var = "position_picker_macro_start_index";
position_picker_sequence_var = "position_picker_sequence_start_index";

exec_page_position_picker = "";
seq_start_index_position_picker = "";
macro_start_index_position_picker = "";

position_macro_line_length = 16;

function create_position_picker_macros()
    local exec_button_start = 100;
    local macro_index = _G.macro_start_index_position_picker;
    local macro_row_labels = { "BEAMS", "SPOT", "WASH1", "WASH2", "LED1", "LED2", "ALL" };
    local macro_labels = { "LOWEST", "LOWER", "CENTER", "DEFAULT", "HIGHER", "HIGHEST", "SINGER", "G1", "G2", "KEYBOARD", "DRUMMER" };

    log("Creating position picker macro's...")
    for group = 1, 7, 1 do
        log("Creating position picker macros on line " .. macro_index)
        local exec_button = exec_button_start + group;
        local sequence_index = _G.seq_start_index_position_picker + group;

        -- create new row macro label
        gma.cmd(string.format("Store Macro %i", macro_index));
        gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro_index, macro_row_labels[group]));

        -- create sequence
        gma.cmd(string.format("Store Sequence %i /n", sequence_index))
        gma.cmd(string.format("Assign Sequence %i /name=\"%s\"", sequence_index, macro_row_labels[group]));

        -- create executor
        gma.cmd(string.format("Store Executor %s", get_position_picker_executor(exec_button)));
        gma.cmd(string.format("Assign Sequence %i At Executor %s", sequence_index, get_position_picker_executor(exec_button)));

        for cue = 1, 11, 1 do
            local macro = tonumber(macro_index) + cue;

            -- delete existing macro
            gma.cmd(string.format("Delete Macro %i", macro));

            -- create new macro and label
            gma.cmd(string.format("Store Macro %i", macro));
            gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro, macro_labels[cue]));

            gma.cmd(string.format("Store Macro 1.%i.1 Thru 1.%i.4", macro, macro))
            gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Goto Executor %s Cue %i\"", macro, get_position_picker_executor(exec_button), cue));

            -- add the appearance commands
            if group == 7 then
                set_color_for_macro_all(macro);
            else
                set_color_for_macro_line(macro_index, macro);
            end
        end

        macro_index = macro_index + _G.position_macro_line_length;
    end

    log("Done creating position picker macro's");
end

function create_position_picker_fade_macros()
    log("Creating position picker fade macro's...")
    local macro_index = get_position_picker_fade_macro_start_index();

    -- 0.0s fade
    create_position_picker_fade_macro(macro_index, 0.0);
    -- 0.5s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 0.5);
    -- 1.0s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 1.0);
    -- 1.5s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 1.5);
    -- 2s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 2.0);
    -- 4s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 4.0);
    -- 8s fade
    macro_index = macro_index + 1;
    create_position_picker_fade_macro(macro_index, 8.0);

    log("Done creating position picker fade macro's");
end

function get_position_picker_executor(executor_index)
    return string.format("%i.%i", _G.exec_page_position_picker, executor_index);
end

function get_position_picker_fade_macro_start_index()
    return _G.macro_start_index_position_picker + 113;
end

--- Set the appearance cmd command for the macro line
---
---@param macro_index number The current macro line start index.
---@param macro number The macro to add the cmd commands to.
function set_color_for_macro_line(macro_index, macro)
    local macro_line_start_index = macro_index + 1;
    local macro_line_end_index = macro_index + 11;
    local macro_all_start_index = _G.macro_start_index_position_picker + (6 * _G.position_macro_line_length);

    gma.cmd(string.format("Assign Macro 1.%i.2 /cmd=\"Appearance Macro %i Thru %i /reset\"",
            macro, macro_line_start_index, macro_line_end_index));
    gma.cmd(string.format("Assign Macro 1.%i.3 /cmd=\"Appearance Macro %i %s\"",
            macro, macro, get_color_green()));
    gma.cmd(string.format("Assign Macro 1.%i.4 /cmd=\"Appearance Macro %i Thru %i /reset\"",
            macro, macro_all_start_index, macro_all_start_index + _G.position_macro_line_length, get_color_green()));
end

--- Set the appearance cmd command for all position macro's
---
---@param macro number The macro to add the cmd commands to.
function set_color_for_macro_all(macro)
    local color_macro = macro;

    gma.cmd(string.format("Assign Macro 1.%i.2 /cmd=\"Appearance Macro %i Thru %i /reset\"",
            macro,  _G.macro_start_index_position_picker, _G.macro_start_index_position_picker + 107));

    gma.cmd(string.format("Store Macro 1.%i.5 Thru 1.%i.10", macro, macro))

    for macro_line = 3, 10, 1 do
        gma.cmd(string.format("Assign Macro 1.%i.%i /cmd=\"Appearance Macro %i %s\"",
                macro, macro_line, color_macro, get_color_green()));

        color_macro = color_macro - _G.position_macro_line_length;
    end
end

--- Create a new fade macro
---
---@param macro_index number The macro index to create the fade macro in
---@param fade_time number The fade time that the fade macro applies to the position picker
function create_position_picker_fade_macro(macro_index, fade_time)
    local fade_macro_start_index = get_position_picker_fade_macro_start_index();
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
    gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Assign Sequence %i Thru %i Cue 1 Thru 11 /fade = %s\"",
            macro_index, _G.seq_start_index_position_picker, _G.seq_start_index_position_picker + 7, fade_time));
    gma.cmd(string.format("Assign Macro 1.%i.2 /cmd=\"Appearance Macro %i Thru %i - %i /reset\"",
            macro_index, fade_macro_start_index, fade_macro_end_index, macro_index));
    gma.cmd(string.format("Assign Macro 1.%i.3 /cmd=\"Appearance Macro %i %s\"",
            macro_index, macro_index, get_color_green()));
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
    create_position_picker_fade_macros();
end

function finalize()
end

return main, finalize;