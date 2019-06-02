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
executor_subgroups_index_blinders = 101;
executor_presets_index_blinders = 105;
executor_form_index_blinders = 106;
executor_groups_index_blinders = 107;
executor_blocks_index_blinders = 108;
executor_wings_index_blinders = 109;
executor_dir_index_blinders = 110;

function create_blinders_exec_buttons()
    local sequence = _G.seq_start_index_blinders;

    -- create an executor for each subgroup
    create_sequence(sequence, "SUBGROUP", get_full_executor_index(_G.executor_subgroups_index_blinders), get_color_cyan(), true);
    create_subgroup_blinders_activation(sequence);

    sequence = sequence + 1;
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
    create_dir_cues_blinders(sequence);
end

function create_subgroup_blinders_activation(sequence)
    local subgroup_index = 1;

    for i = _G.group_subgroups_blinders, 1, -1 do
        create_cue(sequence, subgroup_index, "SG" .. subgroup_index, create_effect_line_activation_blinders({ [1] = "Group 999;" }, subgroup_index));

        subgroup_index = subgroup_index + 1;
    end
end

function create_preset_cues_blinders(sequence)
    create_cue(sequence, 1, "CHASE 2", create_cue_cmd_form_blinders(1) .. create_cue_cmd_group_blinders(1));
    create_cue(sequence, 2, "CHASE 3", create_cue_cmd_form_blinders(1) .. create_cue_cmd_group_blinders(2));
    create_cue(sequence, 3, "SIN 2", create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(1));
    create_cue(sequence, 4, "SIN 3", create_cue_cmd_form_blinders(2) .. create_cue_cmd_group_blinders(2));
end

function create_form_cues_blinders(sequence)
    create_cue(sequence, 1, "CHASE",
            string.format("Assign Form 5 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 2, "SIN",
            string.format("Assign Form 8 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 3, "PWN",
            string.format("Assign Form 4 At Effect %i; Assign Effect %i /phase=0..360 /width=25", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 4, "RAMP",
            string.format("Assign Form 10 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 5, "BUMP",
            string.format("Assign Form 16 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 6, "SWING",
            string.format("Assign Form 17 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 7, "STEP",
            string.format("Assign Form 13 At Effect %i; Assign Effect %i /phase=0..90 /width=25", _G.effect_index_blinders, _G.effect_index_blinders));
    create_cue(sequence, 8, "FULL",
            string.format("Assign Form 16 At Effect %i; Assign Effect %i /phase=0 /width=100", _G.effect_index_blinders, _G.effect_index_blinders));
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

function create_dir_cues_blinders(sequence)
    create_cue(sequence, 1, "<",
            string.format("Assign Effect %i /dir=<", _G.effect_index_blinders));
    create_cue(sequence, 2, ">",
            string.format("Assign Effect %i /dir=>", _G.effect_index_blinders));
    create_cue(sequence, 3, "< BOUNCE",
            string.format("Assign Effect %i /dir=<bounce", _G.effect_index_blinders));
    create_cue(sequence, 4, "> BOUNCE",
            string.format("Assign Effect %i /dir=>bounce", _G.effect_index_blinders));
end

function create_cue_cmd_form_blinders(cueIndex)
    return create_goto_cmd(_G.executor_form_index_blinders, cueIndex);
end

function create_cue_cmd_group_blinders(cueIndex)
    return create_goto_cmd(_G.executor_groups_index_blinders, cueIndex);
end

function create_effect_line_activation_blinders(effect_activation, total_active_lines)
    local cmd = "";
    local activation = ("");

    for effect_line, groups in effect_activation do
        activation = activation .. "ClearSelection; ";
        activation = activation .. groups;
        activation = activation .. string.format("Store Effect 1.%i.%i Thru 1.%i.%i; ", _G.effect_index_blinders, effect_line, _G.effect_index_blinders, effect_line);
    end

    cmd = cmd .. "BlindEdit On; ";
    -- update the effect lines selection
    cmd = cmd .. activation;
    -- update the width of each line
    cmd = cmd .. string.format("Assign Effect %i /width=\"%i\"", _G.effect_index_blinders, 100 / total_active_lines);
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";

    return cmd;
end

function get_blinders_subgroup_selection(group_active_selections)
    local groups = "";

    -- convert to group selection
    for i = 0, table.getn(group_active_selections) do
        groups = groups .. string.format(" Group %i +", group_active_selections[i])
    end

    -- remove last '+' and add ';' instead on the end
    groups = groups:sub(1, -2);
    groups = groups .. ";";

    return groups;
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

    -- set the page index for the executor
    _G.page_index = _G.exec_button_page_blinders;

    create_blinders_exec_buttons();
end

function finalize()
end

return main, finalize;