--- Position Picker show vars
position_picker_page_var = "position_picker_page_index";
position_picker_macro_var = "position_picker_macro_start_index";
position_picker_sequence_var = "position_picker_sequence_start_index";
position_picker_mode_var = "POS_PICKER_MODE";

exec_page_position_picker = "";
seq_start_index_position_picker = "";
macro_start_index_position_picker = "";

--- Position Picker static info
position_macro_line_length = 16;
position_preset_line_length = 12;
macro_row_labels = { "BEAMS", "SPOT", "WASH1", "WASH2", "LED1", "LED2", "ALL" };
macro_labels = { "LOWEST", "LOWER", "CENTER", "DEFAULT", "HIGHER", "HIGHEST", "SINGER", "G1", "G2", "KEYBOARD", "DRUMMER" };

function create_position_picker_sequences()
    log("Creating position picker sequences...")

    for group = 1, 7, 1 do
        local sequence_index = _G.seq_start_index_position_picker + group;

        -- delete sequence
        gma.cmd(string.format("Delete Sequence %i /nc", sequence_index));

        -- create sequence
        gma.cmd(string.format("Store Sequence %i /o /nc", sequence_index))
        gma.cmd(string.format("Assign Sequence %i /name=\"POS %s\"", sequence_index, _G.macro_row_labels[group]));

        -- create queues
        for cue = 1, 11, 1 do
            create_position_picker_sequence_cues(group, sequence_index, cue, 1, _G.macro_labels[cue]);
            create_position_picker_sequence_cues(group, sequence_index, cue, 2, _G.macro_labels[cue] .. " <>");
            create_position_picker_sequence_cues(group, sequence_index, cue, 3, _G.macro_labels[cue] .. " ><");
        end

        gma.cmd(string.format("Delete Sequence %i Cue 1 /nc", sequence_index))
    end

    log("Done creating position picker sequences")
end

function create_position_picker_macros()
    log("Creating position picker macro's...");
    local exec_button_start = 100;
    local macro_index = _G.macro_start_index_position_picker;

    for group = 1, 7, 1 do
        log("Creating position picker macros on line " .. macro_index)
        local exec_button = exec_button_start + group;
        local sequence_index = _G.seq_start_index_position_picker + group;

        -- create new row macro label
        gma.cmd(string.format("Store Macro %i /o /nc", macro_index));
        gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro_index, _G.macro_row_labels[group]));

        -- create executor
        gma.cmd(string.format("Store Executor %s", get_position_picker_executor(exec_button)));
        gma.cmd(string.format("Assign Sequence %i At Executor %s", sequence_index, get_position_picker_executor(exec_button)));

        for cue = 1, 11, 1 do
            local macro = tonumber(macro_index) + cue;

            -- delete existing macro
            gma.cmd(string.format("Delete Macro %i", macro));

            -- create new macro and label
            gma.cmd(string.format("Store Macro %i /o /nc", macro));
            gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro, _G.macro_labels[cue]));

            gma.cmd(string.format("Store Macro 1.%i.1 Thru 1.%i.4 /o /nc", macro, macro))
            gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"Goto Executor %s Cue %i.00$%s\"",
                    macro, get_position_picker_executor(exec_button), cue, _G.position_picker_mode_var));

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

function create_position_picker_mode_macros()
    log("Creating position picker mode macro's...");
    local macro_index = get_position_picker_mode_macro_start_index();

    create_position_picker_mode_macro(macro_index, 1, "NORMAL", get_position_picker_mode_macro_start_index());

    macro_index = macro_index + 1;
    create_position_picker_mode_macro(macro_index, 2, "<>", get_position_picker_mode_macro_start_index());

    macro_index = macro_index + 1;
    create_position_picker_mode_macro(macro_index, 3, "><", get_position_picker_mode_macro_start_index());

    log("Done creating position picker mode macro's");
end

function get_position_picker_executor(executor_index)
    return string.format("%i.%i", _G.exec_page_position_picker, executor_index);
end

function get_position_picker_fade_macro_start_index()
    return _G.macro_start_index_position_picker + 113;
end

function get_position_picker_mode_macro_start_index()
    return get_position_picker_fade_macro_start_index() + _G.position_macro_line_length;
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
            macro, _G.macro_start_index_position_picker, _G.macro_start_index_position_picker + 107));

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

--- Create a new position mode macro
---
---@param macro_index number The macro index to create the position mode macro in.
---@param mode number The mode value of the position mode macro.
---@param name string The name of the position mode macro.
---@param macro_mode_start_index number The start index of the mode macro's
function create_position_picker_mode_macro(macro_index, mode, name, macro_mode_start_index)
    -- create and label macro
    gma.cmd(string.format("Store Macro %i /o /nc", macro_index));
    gma.cmd(string.format("Assign Macro %i /name=\"%s\"", macro_index, name));

    -- create cmd
    gma.cmd(string.format("Store Macro 1.%i.1 Thru 1.%i.3 /o /nc",
            macro_index, macro_index));
    gma.cmd(string.format("Assign Macro 1.%i.1 /cmd=\"SetVar %s=%i\"",
            macro_index, _G.position_picker_mode_var, mode));
    gma.cmd(string.format("Assign Macro 1.%i.2 /cmd=\"Appearance Macro %i Thru % i %s\"",
            macro_index, macro_mode_start_index, macro_mode_start_index + 3, get_color_cyan()));
    gma.cmd(string.format("Assign Macro 1.%i.3 /cmd=\"Appearance Macro %i %s\"",
            macro_index, macro_index, get_color_green()));
end

--- Create the cues for the sequence with activated position for the group
---
---@param group number The group index to activate in the cue.
---@param sequence_index number The sequence index to store the cue in.
---@param cue number The cue index to store.
---@param mode number The sub cue (or mode) to store.
---@param name string The name of the cue.
function create_position_picker_sequence_cues(group, sequence_index, cue, mode, name)
    -- select the group and activate the position
    gma.cmd(get_group(group));

    if mode == 1 then
        gma.cmd(string.format("At Preset 2.%i", cue));
    elseif mode == 2 then
        gma.cmd(string.format("At Preset 2.%i", (cue * _G.position_preset_line_length) + 1));
    elseif mode == 3 then
        gma.cmd(string.format("At Preset 2.%i", (cue * _G.position_preset_line_length) + 2));
    end

    -- store the selection + position in the correct cue within the sequence & label the cue
    gma.cmd(string.format("Store Sequence %i Cue %i.00%i /o /nc", sequence_index, cue, mode));
    gma.cmd(string.format("Assign Sequence %i Cue %i.00%i /name=\"%s\"", sequence_index, cue, mode, name));

    -- clear selection & position
    clear_all();
end

function initialize_position_picker_vars()
    log("Initializing position picker vars...");

    gma.cmd(string.format("SetVar %s=1", _G.position_picker_mode_var));

    log("Done initializing position picker vars");
end

--- Plugin Entry Point
function main()
    clear_all();

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

    local handle = gma.gui.progress.start(_G.plugin_name);
    gma.gui.progress.setrange(handle, 0, 5);
    gma.gui.progress.set(handle, 1);
    gma.gui.progress.settext(handle, "creating sequences");
    create_position_picker_sequences();

    gma.gui.progress.set(handle, 2);
    gma.gui.progress.settext(handle, "creating position macro's");
    create_position_picker_macros();

    gma.gui.progress.set(handle, 3);
    gma.gui.progress.settext(handle, "creating fade macro's");
    create_position_picker_fade_macros();

    gma.gui.progress.set(handle, 4);
    gma.gui.progress.settext(handle, "creating mode macro's");
    create_position_picker_mode_macros();

    gma.gui.progress.set(handle, 5);
    gma.gui.progress.settext(handle, "initializing variables");
    initialize_position_picker_vars();

    gma.gui.progress.settext(handle, "done");
    gma.gui.progress.stop(handle);
end

function finalize()
end

return main, finalize;