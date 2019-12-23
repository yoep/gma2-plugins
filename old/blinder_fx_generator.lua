---
--- Blinder Picker
--- Configure executor buttons for blinder effects
---

---
--- Blinders Config
---

--- Blinder FX generator show vars
blinder_fx_generator_page_var = "blinder_fx_generator_page_index";
blinder_fx_generator_sequence_var = "blinder_fx_generator_sequence_start_index";
blinder_fx_generator_effect_var = "blinder_fx_generator_effect_index";

exec_button_page_blinders = "";
seq_start_index_blinders = "";
effect_index_blinders = "";

--- Blinders button executors config
executor_presets_index_blinders = 105;
executor_form_index_blinders = 106;
executor_groups_index_blinders = 107;
executor_blocks_index_blinders = 108;
executor_wings_index_blinders = 109;
executor_dir_index_blinders = 110;

function create_blinders_exec_buttons()
    local sequence = _G.seq_start_index_blinders;

    create_sequence(sequence, "PRESETS", get_full_executor_index(_G.executor_presets_index_blinders), get_color_blue(), true, true);
    create_preset_cues_blinders(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "FORM", get_full_executor_index(_G.executor_form_index_blinders), nil, true);
    create_form_cues_blinders(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "GROUPS", get_full_executor_index(_G.executor_groups_index_blinders), nil, true);
    create_group_cues_blinders(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "BLOCKS", get_full_executor_index(_G.executor_blocks_index_blinders), nil, true);
    create_block_cues_blinders(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "WINGS", get_full_executor_index(_G.executor_wings_index_blinders), nil, true);
    create_wing_cues_blinders(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "DIR", get_full_executor_index(_G.executor_dir_index_blinders), nil, true);
    create_dir_cues(sequence, _G.effect_index_blinders);
end

function create_preset_cues_blinders(sequence)
    create_cue(sequence, 1, "CHASE 2",
            create_cue_cmd_form_blinders(1) .. create_cue_cmd_group_blinders(1) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 2, "CHASE 3",
            create_cue_cmd_form_blinders(1) .. create_cue_cmd_group_blinders(2) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 3, "CHASE 4",
            create_cue_cmd_form_blinders(1) .. create_cue_cmd_group_blinders(3) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 4, "SIN 2",
            create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(1) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 5, "SIN 3",
            create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(2) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 6, "SIN 4",
            create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(3) .. create_cmd_phase(_G.effect_index_blinders, "0..360"));
    create_cue(sequence, 7, "ROW",
            create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(get_subgroups_blinders() - 1) .. create_row_cmd_blinders());
    create_cue(sequence, 8, "UP/DOWN",
            create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(1) .. create_up_down_cmd_blinders());
    create_cue(sequence, 9, "ALL",
            create_cue_cmd_form_blinders(5) .. create_cue_cmd_group_blinders(1) .. create_cmd_phase(_G.effect_index_blinders, "0"));
end

function create_form_cues_blinders(sequence)
    create_cue(sequence, 1, "CHASE",
            string.format("Assign Form 5 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 2, "SIN",
            string.format("Assign Form 8 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 3, "PWN",
            string.format("Assign Form 4 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 4, "RAMP",
            string.format("Assign Form 10 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 5, "BUMP",
            string.format("Assign Form 16 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 6, "SWING",
            string.format("Assign Form 17 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 7, "STEP",
            string.format("Assign Form 13 At Effect %i;", _G.effect_index_blinders, _G.effect_index_blinders));
end

function create_group_cues_blinders(sequence)
    create_cue(sequence, 0, "OFF",
            string.format("Assign Effect %i /groups=0 /rate=1; %s", _G.effect_index_blinders, create_cue_cmd_executor_off(_G.executor_groups_index_blinders)));
    create_cue(sequence, 1, "G2",
            string.format("Assign Effect %i /groups=2 /rate=0.5", _G.effect_index_blinders));
    create_cue(sequence, 2, "G3",
            string.format("Assign Effect %i /groups=3 /rate=0.33", _G.effect_index_blinders));
    create_cue(sequence, 3, "G4",
            string.format("Assign Effect %i /groups=4 /rate=0.25", _G.effect_index_blinders));
    create_cue(sequence, 4, "G6",
            string.format("Assign Effect %i /groups=6 /rate=0.16", _G.effect_index_blinders));
    create_cue(sequence, 5, "G8",
            string.format("Assign Effect %i /groups=8 /rate=0.125", _G.effect_index_blinders));
end

function create_block_cues_blinders(sequence)
    create_cue(sequence, 0, "OFF",
            string.format("Assign Effect %i /blocks=0; %s", _G.effect_index_blinders, create_cue_cmd_executor_off(_G.executor_blocks_index_blinders)));
    create_cue(sequence, 1, "B2",
            string.format("Assign Effect %i /blocks=2", _G.effect_index_blinders));
    create_cue(sequence, 2, "B3",
            string.format("Assign Effect %i /blocks=3", _G.effect_index_blinders));
    create_cue(sequence, 3, "B4",
            string.format("Assign Effect %i /blocks=4", _G.effect_index_blinders));
    create_cue(sequence, 4, "B6",
            string.format("Assign Effect %i /blocks=6", _G.effect_index_blinders));
    create_cue(sequence, 5, "B8",
            string.format("Assign Effect %i /blocks=8", _G.effect_index_blinders));
end

function create_wing_cues_blinders(sequence)
    create_cue(sequence, 0, "OFF",
            string.format("Assign Effect %i /wings=0; %s", _G.effect_index_blinders, create_cue_cmd_executor_off(_G.executor_wings_index_blinders)));
    create_cue(sequence, 1, "W2",
            string.format("Assign Effect %i /wings=2", _G.effect_index_blinders));
    create_cue(sequence, 2, "W3",
            string.format("Assign Effect %i /wings=3", _G.effect_index_blinders));
    create_cue(sequence, 3, "W4",
            string.format("Assign Effect %i /wings=4", _G.effect_index_blinders));
    create_cue(sequence, 4, "W6",
            string.format("Assign Effect %i /wings=6", _G.effect_index_blinders));
    create_cue(sequence, 5, "W8",
            string.format("Assign Effect %i /wings=8", _G.effect_index_blinders));
end

function create_cue_cmd_form_blinders(cueIndex)
    return create_goto_cmd(_G.executor_form_index_blinders, cueIndex);
end

function create_cue_cmd_group_blinders(cueIndex)
    return create_goto_cmd(_G.executor_groups_index_blinders, cueIndex);
end

function create_row_cmd_blinders()
    local cmd = "";
    local last_phase = 0;

    for i = 1, get_subgroups_blinders(), 1 do
        cmd = cmd .. create_cmd_phase_effect_line(_G.effect_index_blinders, last_phase, i);
        last_phase = last_phase + 90;
    end

    return cmd;
end

function create_up_down_cmd_blinders()
    local cmd = "";

    cmd = cmd .. create_cmd_phase_effect_line(_G.effect_index_blinders, 0, 1);

    for i = 2, get_subgroups_blinders(), 1 do
        cmd = cmd .. create_cmd_phase_effect_line(_G.effect_index_blinders, 180, i);
    end

    return cmd;
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    -- Set plugin name for logging
    _G.plugin_name = "Blinder FX Generator";

    -- Request executor page
    _G.exec_button_page_blinders = show_user_var_input_number(_G.blinder_fx_generator_page_var, "Executor page for buttons");
    -- Request sequence start index
    _G.seq_start_index_blinders = show_user_var_input_number(_G.blinder_fx_generator_sequence_var, "Sequence start index");
    -- Request effect index
    _G.effect_index_blinders = show_user_var_input_number(_G.blinder_fx_generator_effect_var, "Store in effect");

    -- set the page index for the executors
    _G.page_index = _G.exec_button_page_blinders;

    create_blinders_exec_buttons();
end

function finalize()
end

return main, finalize;