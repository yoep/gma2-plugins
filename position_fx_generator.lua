---
--- Position Config
---

--- Var config
beam_position_var = "beam_position";
spot_position_var = "spot_position";
wash1_position_var = "wash1_position";
wash2_position_var = "wash2_position";
led_position_var = "led_position";

--- Position FX generator show vars
position_fx_generator_page_var = "position_fx_generator_page_index";
position_fx_generator_sequence_var = "position_fx_generator_sequence_start_index";
position_fx_generator_effect_var = "position_fx_generator_effect_index";

exec_button_page_position = "";
seq_start_index_position = "";
effect_index_position = "";

--- Position button executors config
executor_color_fx_index_position = 106;
executor_color_index_position = 107;
executor_form_pan_index_position = 111;
executor_form_tilt_index_position = 112;
executor_val_pan_index_position = 113;
executor_val_tilt_index_position = 114;
executor_presets_index_position = 115;
executor_phase_index_position = 116;
executor_groups_index_position = 117;
executor_blocks_index_position = 118;
executor_wings_index_position = 119;
executor_dir_index_position = 120;
executor_beam_index_position = 121;
executor_spot_index_position = 122;
executor_wash1_index_position = 123;
executor_wash2_index_position = 124;
executor_led_index_position = 125;

--- Position Effect Line config
pan_index_position = 1;
tilt_index_position = 2;
color_fx_line_start_index_position = 3;
color_fx_line_end_index_position = 5;

function create_position_exec_buttons()
    local sequence = _G.seq_start_index_position;

    log("Creating position picker exec buttons...");

    create_sequence(sequence, "COLOR FX", get_full_executor_index(_G.executor_color_fx_index_position));
    create_color_fx_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "COLOR", get_full_executor_index(_G.executor_color_index_position));
    create_color_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "FORM PAN", get_full_executor_index(_G.executor_form_pan_index_position), nil, true);
    create_form_pan_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "FORM TILT", get_full_executor_index(_G.executor_form_tilt_index_position), nil, true);
    create_form_tilt_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "VAL PAN", get_full_executor_index(_G.executor_val_pan_index_position));
    create_val_cues_position(sequence, _G.pan_index_position);

    sequence = sequence + 1;
    create_sequence(sequence, "VAL TILT", get_full_executor_index(_G.executor_val_tilt_index_position));
    create_val_cues_position(sequence, _G.tilt_index_position);

    sequence = sequence + 1;
    create_sequence(sequence, "PRESETS", get_full_executor_index(_G.executor_presets_index_position), get_color_blue(), true, true);
    create_preset_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "PHASE", get_full_executor_index(_G.executor_phase_index_position), nil, true);
    create_phase_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "GROUPS", get_full_executor_index(_G.executor_groups_index_position), nil, true);
    create_group_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "BLOCKS", get_full_executor_index(_G.executor_blocks_index_position), nil, true);
    create_block_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "WINGS", get_full_executor_index(_G.executor_wings_index_position), nil, true);
    create_wing_cues_position(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "DIR", get_full_executor_index(_G.executor_dir_index_position), nil, true);
    create_dir_cues(sequence, _G.effect_index_position);

    sequence = sequence + 1;
    create_sequence(sequence, "BEAM", get_full_executor_index(_G.executor_beam_index_position), get_color_red());
    create_cue(sequence, 1, "ON",
            create_cue_cmd_group_on(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.beam_position_var, _G.group_beams_index, get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF",
            create_cue_cmd_group_off(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.beam_position_var, get_groups_cmd_position()));

    sequence = sequence + 1;
    create_sequence(sequence, "SPOT", get_full_executor_index(_G.executor_spot_index_position), get_color_red());
    create_cue(sequence, 1, "ON",
            create_cue_cmd_group_on(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.spot_position_var, _G.group_spots_index, get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF",
            create_cue_cmd_group_off(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.spot_position_var, get_groups_cmd_position()));

    sequence = sequence + 1;
    create_sequence(sequence, "WASH1", get_full_executor_index(_G.executor_wash1_index_position), get_color_red());
    create_cue(sequence, 1, "ON",
            create_cue_cmd_group_on(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.wash1_position_var, _G.group_wash1_index, get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF",
            create_cue_cmd_group_off(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.wash1_position_var, get_groups_cmd_position()));

    sequence = sequence + 1;
    create_sequence(sequence, "WASH2", get_full_executor_index(_G.executor_wash2_index_position), get_color_red());
    create_cue(sequence, 1, "ON",
            create_cue_cmd_group_on(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.wash2_position_var, _G.group_wash2_index, get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF",
            create_cue_cmd_group_off(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.wash2_position_var, get_groups_cmd_position()));

    sequence = sequence + 1;
    create_sequence(sequence, "LED", get_full_executor_index(_G.executor_led_index_position), get_color_red());
    create_cue(sequence, 1, "ON",
            create_cue_cmd_group_on(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.led_position_var, _G.group_led1_index, get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF",
            create_cue_cmd_group_off(_G.effect_index_position, _G.pan_index_position, _G.color_fx_line_end_index_position, _G.led_position_var, get_groups_cmd_position()));
end

function create_color_fx_cues_position(sequence)
    create_cue(sequence, 1, "ON", create_cue_cmd_on(
            get_multi_line_effect_index(_G.effect_index_position, color_fx_line_start_index_position, color_fx_line_end_index_position), get_groups_cmd_position()));
    create_cue(sequence, 2, "OFF", create_cue_cmd_off(
            get_multi_line_effect_index(_G.effect_index_position, color_fx_line_start_index_position, color_fx_line_end_index_position)));
end

function create_color_cues_position(sequence)
    create_cue(sequence, 1, "REL", string.format("Assign Effect %s /mode=rel;",
            get_multi_line_effect_index(_G.effect_index_position, color_fx_line_start_index_position, color_fx_line_end_index_position)));
    create_cue(sequence, 2, "ABS", string.format("Assign Effect %s /mode=abs;",
            get_multi_line_effect_index(_G.effect_index_position, color_fx_line_start_index_position, color_fx_line_end_index_position)));
end

function create_form_pan_cues_position(sequence)
    create_cue(sequence, 0, "STOMP", string.format("Assign Form 1 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 1, "SIN", string.format("Assign Form 8 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 2, "COS", string.format("Assign Form 9 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 3, "RAMP", string.format("Assign Form 12 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 4, "BUMP", string.format("Assign Form 16 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 5, "SWING", string.format("Assign Form 17 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 6, "CIRCLE", string.format("Assign Form 19.1 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 7, "WAVE", string.format("Assign Form 22.1 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 8, "CROSS", string.format("Assign Form 23.1 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
    create_cue(sequence, 9, "FLY OUT", string.format("Assign Form 21.2 At Effect 1.%i.%i", _G.effect_index_position, _G.pan_index_position));
end

function create_form_tilt_cues_position(sequence)
    create_cue(sequence, 0, "STOMP", string.format("Assign Form 1 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 1, "SIN", string.format("Assign Form 8 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 2, "COS", string.format("Assign Form 9 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 3, "RAMP", string.format("Assign Form 12 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 4, "BUMP", string.format("Assign Form 16 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 5, "SWING", string.format("Assign Form 17 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 6, "CIRCLE", string.format("Assign Form 19.2 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 7, "WAVE", string.format("Assign Form 22.2 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 8, "CROSS", string.format("Assign Form 23.2 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
    create_cue(sequence, 9, "FLY OUT", string.format("Assign Form 21.2 At Effect 1.%i.%i", _G.effect_index_position, _G.tilt_index_position));
end

function create_val_cues_position(sequence, line_index)
    create_cue(sequence, 1, "00..75", string.format("Assign Effect 1.%i.%i /lowvalue=0 /highvalue=75", _G.effect_index_position, line_index));
    create_cue(sequence, 2, "-75..75", string.format("Assign Effect 1.%i.%i /lowvalue=-75 /highvalue=75", _G.effect_index_position, line_index));
end

function create_preset_cues_position(sequence)
    create_cue(sequence, 1, "FULL UP",
            create_cue_cmd_phase_position(1) .. create_cue_cmd_form_pan_position(0) .. create_cue_cmd_form_tilt_position(1) .. create_cue_cmd_color_fx_position(1) .. create_cue_cmd_group_position(1));
    create_cue(sequence, 2, "EVEN/ODD UP",
            create_cue_cmd_phase_position(2) .. create_cue_cmd_form_pan_position(0) .. create_cue_cmd_form_tilt_position(1) .. create_cue_cmd_color_fx_position(1) .. create_cue_cmd_group_position(1));
    create_cue(sequence, 3, "3 UP",
            create_cue_cmd_phase_position(2) .. create_cue_cmd_form_pan_position(0) .. create_cue_cmd_form_tilt_position(1) .. create_cue_cmd_color_fx_position(1) .. create_cue_cmd_group_position(2));
    create_cue(sequence, 4, "TILT",
            create_cue_cmd_phase_position(3) .. create_cue_cmd_form_pan_position(0) .. create_cue_cmd_form_tilt_position(1) .. create_cue_cmd_color_fx_position(0));
    create_cue(sequence, 5, "PAN",
            create_cue_cmd_phase_position(3) .. create_cue_cmd_form_pan_position(1) .. create_cue_cmd_form_tilt_position(0) .. create_cue_cmd_color_fx_position(0));
    create_cue(sequence, 6, "MOVE",
            create_cue_cmd_phase_position(3) .. create_cue_cmd_form_pan_position(1) .. create_cue_cmd_form_tilt_position(2) .. create_cue_cmd_color_fx_position(0));
    create_cue(sequence, 7, "BALLYHOO",
            create_cue_cmd_phase_position(2) .. create_cue_cmd_form_pan_position(1) .. create_cue_cmd_form_tilt_position(2) .. create_cue_cmd_color_fx_position(1) .. create_color_form_cmd_position(12));
    create_cue(sequence, 8, "FLY OUT",
            create_cue_cmd_phase_position(2) .. create_cue_cmd_form_pan_position(0) .. create_cue_cmd_form_tilt_position(9) .. create_cue_cmd_color_fx_position(1) .. create_color_form_cmd_position(21.1));
end

function create_color_form_cmd_position(form_index)
    return string.format("Assign Form %s At Effect %s", form_index,
            get_multi_line_effect_index(_G.effect_index_position, _G.color_fx_line_start_index_position, _G.color_fx_line_end_index_position));
end

function create_phase_cues_position(sequence)
    create_cue(sequence, 1, "0", string.format("Assign Effect %i /phase=0", _G.effect_index_position));
    create_cue(sequence, 2, "0..360", string.format("Assign Effect %i /phase=0..360", _G.effect_index_position));
    create_cue(sequence, 3, "-100..360", string.format("Assign Effect %i /phase=-100..360", _G.effect_index_position));
end

function create_group_cues_position(sequence)
    create_cue(sequence, 0, "OFF", string.format("Assign Effect %i /groups=0 /rate=1", _G.effect_index_position));
    create_cue(sequence, 1, "GROUP 2", string.format("Assign Effect %i /groups=2 /rate=0.5", _G.effect_index_position));
    create_cue(sequence, 2, "GROUP 3", string.format("Assign Effect %i /groups=3 /rate=0.33", _G.effect_index_position));
    create_cue(sequence, 3, "GROUP 4", string.format("Assign Effect %i /groups=4 /rate=0.25", _G.effect_index_position));
    create_cue(sequence, 4, "GROUP 6", string.format("Assign Effect %i /groups=6 /rate=0.16", _G.effect_index_position));
    create_cue(sequence, 5, "GROUP 8", string.format("Assign Effect %i /groups=8 /rate=0.0125", _G.effect_index_position));
end

function create_block_cues_position(sequence)
    create_cue(sequence, 1, "BLOCK 2", string.format("Assign Effect %i /blocks=2", _G.effect_index_position));
    create_cue(sequence, 2, "BLOCK 3", string.format("Assign Effect %i /blocks=3", _G.effect_index_position));
    create_cue(sequence, 3, "BLOCK 4", string.format("Assign Effect %i /blocks=4", _G.effect_index_position));
    create_cue(sequence, 4, "BLOCK 6", string.format("Assign Effect %i /blocks=6", _G.effect_index_position));
    create_cue(sequence, 5, "BLOCK 8", string.format("Assign Effect %i /blocks=8", _G.effect_index_position));
end

function create_wing_cues_position(sequence)
    create_cue(sequence, 1, "WING 2", string.format("Assign Effect %i /wings=2", _G.effect_index_position));
    create_cue(sequence, 2, "WING 3", string.format("Assign Effect %i /wings=3", _G.effect_index_position));
    create_cue(sequence, 3, "WING 4", string.format("Assign Effect %i /wings=4", _G.effect_index_position));
    create_cue(sequence, 4, "WING 6", string.format("Assign Effect %i /wings=6", _G.effect_index_position));
    create_cue(sequence, 5, "WING 8", string.format("Assign Effect %i /wings=8", _G.effect_index_position));
end

function create_cue_cmd_phase_position(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_phase_index_position), cueIndex);
end

function create_cue_cmd_form_pan_position(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_form_pan_index_position), cueIndex);
end

function create_cue_cmd_form_tilt_position(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_form_tilt_index_position), cueIndex);
end

function create_cue_cmd_group_position(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_groups_index_position), cueIndex);
end

function create_cue_cmd_color_fx_position(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_color_fx_index_position), cueIndex);
end

function get_groups_cmd_position()
    return string.format("$%s + $%s + $%s + $%s + $%s; ",
            beam_position_var .. _G.exec_button_page_position,
            spot_position_var .. _G.exec_button_page_position,
            wash1_position_var .. _G.exec_button_page_position,
            wash2_position_var .. _G.exec_button_page_position,
            led_position_var .. _G.exec_button_page_position);
end

function initialize_position_vars()
    log("Initializing vars...")
    gma.show.setvar(_G.beam_position_var .. _G.exec_button_page_position, "Group 999");
    gma.show.setvar(_G.spot_position_var .. _G.exec_button_page_position, "Group 999");
    gma.show.setvar(_G.wash1_position_var .. _G.exec_button_page_position, "Group 999");
    gma.show.setvar(_G.wash2_position_var .. _G.exec_button_page_position, "Group 999");
    gma.show.setvar(_G.led_position_var .. _G.exec_button_page_position, "Group 999");
    log("Initializing vars done")
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    -- Set plugin name for logging
    _G.plugin_name = "Position FX Generator";

    -- Request executor page
    _G.exec_button_page_position = show_user_var_input_number(_G.position_fx_generator_page_var, "Executor page for buttons");
    -- Request sequence start index
    _G.seq_start_index_position = show_user_var_input_number(_G.position_fx_generator_sequence_var, "Sequence start index");
    -- Request effect index
    _G.effect_index_position = show_user_var_input_number(_G.position_fx_generator_effect_var, "Store in effect");

    -- set the page index for the executors
    _G.page_index = _G.exec_button_page_position;

    create_position_exec_buttons();
    initialize_position_vars();
end

function finalize()
end

return main, finalize;