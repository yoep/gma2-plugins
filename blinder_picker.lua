--- *** Config ***
--- Var config
picker_page_var = "blinder_picker_page";
--- **********************
--- DO NOT EDIT BELOW THIS
--- **********************
--- Var config
plugin_name = "blinder_picker";
exec_button_page = "";
seq_start_index = "";
effect_index = "";
--- Button Executor config
executor_form_index_blinders = 101;
executor_groups_index_blinders = 102;
executor_blocks_index_blinders = 103;
executor_wings_index_blinders = 104;
executor_dir_index_blinders = 105;

function create_exec_buttons()
    local sequence = _G.seq_start_index;

    create_sequence(sequence, "FORM", get_full_executor_index(_G.executor_form_index_blinders), nil, true);
    create_form_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "GROUPS", get_full_executor_index(_G.executor_groups_index_blinders), nil, true);
    create_group_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "BLOCKS", get_full_executor_index(_G.executor_blocks_index_blinders), nil, true);
    create_block_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "WINGS", get_full_executor_index(_G.executor_wings_index_blinders), nil, true);
    create_wing_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "DIR", get_full_executor_index(_G.executor_dir_index_blinders), nil, true);
    create_dir_cues(sequence);
end

function create_form_cues(sequence)
    create_cue(sequence, 1, "CHASE", string.format("Assign Form 5 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index));
    create_cue(sequence, 2, "SIN", string.format("Assign Form 8 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index));
    create_cue(sequence, 3, "PWN", string.format("Assign Form 4 At Effect %i; Assign Effect %i /phase=0..360 /width=25", _G.effect_index, _G.effect_index));
    create_cue(sequence, 4, "RAMP", string.format("Assign Form 10 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index));
    create_cue(sequence, 5, "BUMP", string.format("Assign Form 16 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index));
    create_cue(sequence, 6, "SWING", string.format("Assign Form 17 At Effect %i; Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index));
    create_cue(sequence, 7, "STEP", string.format("Assign Form 13 At Effect %i; Assign Effect %i /phase=0..90 /width=25", _G.effect_index, _G.effect_index));
    create_cue(sequence, 8, "FULL", string.format("Assign Form 16 At Effect %i; Assign Effect %i /phase=0 /width=100", _G.effect_index, _G.effect_index));
end

function create_group_cues(sequence)
    create_cue(sequence, 0, "OFF", string.format("Assign Effect %i /groups=0 /rate=1; %s", effect_index, create_cue_cmd_executor_off(_G.executor_groups_index)));
    create_cue(sequence, 1, "G2", string.format("Assign Effect %i /groups=2 /rate=0.5", effect_index));
    create_cue(sequence, 2, "G3", string.format("Assign Effect %i /groups=3 /rate=0.33", effect_index));
    create_cue(sequence, 3, "G4", string.format("Assign Effect %i /groups=4 /rate=0.25", effect_index));
    create_cue(sequence, 4, "G6", string.format("Assign Effect %i /groups=6 /rate=0.16", effect_index));
    create_cue(sequence, 5, "G8", string.format("Assign Effect %i /groups=8 /rate=0.125", effect_index));
end

function create_block_cues(sequence)
    create_cue(sequence, 0, "OFF", string.format("Assign Effect %i /blocks=0; %s", effect_index, create_cue_cmd_executor_off(_G.executor_blocks_index)));
    create_cue(sequence, 1, "B2", string.format("Assign Effect %i /blocks=2", effect_index));
    create_cue(sequence, 2, "B3", string.format("Assign Effect %i /blocks=3", effect_index));
    create_cue(sequence, 3, "B4", string.format("Assign Effect %i /blocks=4", effect_index));
    create_cue(sequence, 4, "B6", string.format("Assign Effect %i /blocks=6", effect_index));
    create_cue(sequence, 5, "B8", string.format("Assign Effect %i /blocks=8", effect_index));
end

function create_wing_cues(sequence)
    create_cue(sequence, 0, "OFF", string.format("Assign Effect %i /wings=0; %s", effect_index, create_cue_cmd_executor_off(_G.executor_wings_index)));
    create_cue(sequence, 1, "W2", string.format("Assign Effect %i /wings=2", effect_index));
    create_cue(sequence, 2, "W3", string.format("Assign Effect %i /wings=3", effect_index));
    create_cue(sequence, 3, "W4", string.format("Assign Effect %i /wings=4", effect_index));
    create_cue(sequence, 4, "W6", string.format("Assign Effect %i /wings=6", effect_index));
    create_cue(sequence, 5, "W8", string.format("Assign Effect %i /wings=8", effect_index));
end

function create_dir_cues(sequence)
    create_cue(sequence, 1, "<", string.format("Assign Effect %i /dir=<", effect_index));
    create_cue(sequence, 2, ">", string.format("Assign Effect %i /dir=>", effect_index));
    create_cue(sequence, 3, "< BOUNCE", string.format("Assign Effect %i /dir=<bounce", effect_index));
    create_cue(sequence, 4, "> BOUNCE", string.format("Assign Effect %i /dir=>bounce", effect_index));
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    _G.exec_button_page = get_show_var("exec_button_page_blinders");
    _G.exec_button_page = get_number_input("Executor page for buttons", _G.exec_button_page);
    log("Setting exec_button_page to " .. _G.exec_button_page);
    gma.show.setvar("exec_button_page_blinders", _G.exec_button_page);

    _G.seq_start_index = get_show_var("seq_start_index_blinders");
    _G.seq_start_index = get_number_input("Sequence start index", _G.seq_start_index);
    log("Setting seq_start_index to " .. _G.seq_start_index);
    gma.show.setvar("seq_start_index_blinders", _G.seq_start_index);

    _G.effect_index = get_show_var("effect_blinders");
    _G.effect_index = get_number_input("Store in effect", _G.effect_index);
    log("Setting effect to " .. _G.effect_index);
    gma.show.setvar("effect_blinders", _G.effect_index);

    create_exec_buttons();
end

function finalize()
end

return main, finalize;