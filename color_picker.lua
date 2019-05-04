--- *** Config ***
--- Var config
picker_page_var = "picker_page";
beam_color_var = "beam_color";
spot_color_var = "spot_color";
wash1_color_var = "wash1_color";
wash2_color_var = "wash2_color";
led_color_var = "led_color";
--- Group config
beam_group_index = 5;
spot_group_index = 4;
wash1_group_index = 3;
wash2_group_index = 6;
led_group_index = 7;
--- Preset config
color_preset_start_index = 100;
gobo_preset_start_index = 100;
--- Button Executor config
executor_zoom_index = 106;
executor_dim_index = 107;
executor_gobo_index = 108;
executor_shutter_index = 109;
executor_presets_index = 110;
executor_color1_index = 111;
executor_color2_index = 112;
executor_color_index = 113;
executor_gobo1_index = 114;
executor_gobo2_index = 115;
executor_form_index = 116;
executor_groups_index = 117;
executor_blocks_index = 118;
executor_wings_index = 119;
executor_dir_index = 120;
executor_beam_index = 121;
executor_spot_index = 122;
executor_wash1_index = 123;
executor_wash2_index = 124;
executor_led_index = 125;
--- Effect config
zoom_effect_line_index = 4;
dim_effect_line_index = 5;
shutter_effect_line_index = 8;

--- **********************
--- DO NOT EDIT BELOW THIS
--- **********************
plugin_name = "color_picker";
exec_button_page = "";
exec_color_picker_page = "";
macro_start_index = "";
seq_start_index = "";
effect_index = "";
effect_executor = "";

function create_color_picker_macros()
    local exec_button_start = 100;

    log("Creating color picker macro's...")
    for group = 1, 7, 1 do
        log("Creating color picker macros on line " .. _G.macro_start_index)
        local exec_button = exec_button_start + group;

        for cue = 1, 12, 1 do
            local macro = tonumber(_G.macro_start_index) + cue;
            gma.cmd("Assign Macro 1." .. macro .. ".1 /cmd=\"Goto Executor $picker_page." .. exec_button .. " Cue " .. cue .. "\"")
        end

        _G.macro_start_index = _G.macro_start_index + 16;
    end
    log("Done creating color picker macro's")
end

function create_exec_buttons()
    local sequence = _G.seq_start_index;

    log("Creating color picker exec buttons...");

    create_sequence(sequence, "ZOOM", get_full_executor_index(_G.executor_zoom_index));
    create_cue(sequence, 1, "ON", create_cue_cmd_on("1." .. effect_index .. "." .. _G.zoom_effect_line_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_off("1." .. effect_index .. "." .. _G.zoom_effect_line_index));

    sequence = sequence + 1;
    create_sequence(sequence, "DIM", get_full_executor_index(_G.executor_dim_index));
    create_cue(sequence, 1, "ON", create_cue_cmd_on("1." .. effect_index .. "." .. _G.dim_effect_line_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_off("1." .. effect_index .. "." .. _G.dim_effect_line_index));

    sequence = sequence + 1;
    create_sequence(sequence, "GOBO", get_full_executor_index(_G.executor_gobo_index));
    create_cue(sequence, 1, "ON", create_cue_cmd_on("1." .. effect_index .. ".6 Thru 1." .. effect_index .. ".7"));
    create_cue(sequence, 2, "OFF", create_cue_cmd_off("1." .. effect_index .. ".6 Thru 1." .. effect_index .. ".7"));

    sequence = sequence + 1;
    create_sequence(sequence, "SHUTTER", get_full_executor_index(_G.executor_shutter_index));
    create_cue(sequence, 1, "ON", create_cue_cmd_on("1." .. effect_index .. "." .. _G.shutter_effect_line_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_off("1." .. effect_index .. "." .. _G.shutter_effect_line_index));

    sequence = sequence + 1;
    create_sequence(sequence, "PRESETS", get_full_executor_index(_G.executor_presets_index), get_color_blue(), true, true);
    create_preset_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "COLOR 1", get_full_executor_index(_G.executor_color1_index), nil, true);
    create_color_cues(sequence, "LOW FX" .. _G.exec_button_page, _G.color_preset_start_index + (_G.exec_button_page * 2 - 2));

    sequence = sequence + 1;
    create_sequence(sequence, "COLOR 2", get_full_executor_index(_G.executor_color2_index), nil, true);
    create_color_cues(sequence, "HIGH FX" .. _G.exec_button_page, _G.color_preset_start_index + (_G.exec_button_page * 2 - 2) + 1);

    sequence = sequence + 1;
    create_sequence(sequence, "COLOR", get_full_executor_index(_G.executor_color_index));
    create_cue(sequence, 1, "REL", string.format("Assign Effect 1.%i.1 Thru 1.%i.3 /mode=rel;", _G.effect_index, _G.effect_index));
    create_cue(sequence, 2, "ABS", string.format("Assign Effect 1.%i.1 Thru 1.%i.3 /mode=abs;", _G.effect_index, _G.effect_index));

    sequence = sequence + 1;
    create_sequence(sequence, "GOBO 1", get_full_executor_index(_G.executor_gobo1_index), nil, true);
    create_gobo_cues(sequence, "LOW FX" .. _G.exec_button_page, _G.gobo_preset_start_index + (_G.exec_button_page * 2 - 2));

    sequence = sequence + 1
    create_sequence(sequence, "GOBO 2", get_full_executor_index(_G.executor_gobo2_index), nil, true);
    create_gobo_cues(sequence, "HIGH FX" .. _G.exec_button_page, _G.gobo_preset_start_index + (_G.exec_button_page * 2 - 2) + 1);

    sequence = sequence + 1;
    create_sequence(sequence, "FORM", get_full_executor_index(_G.executor_form_index), nil, true);
    create_form_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "GROUPS", get_full_executor_index(_G.executor_groups_index), nil, true);
    create_group_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "BLOCKS", get_full_executor_index(_G.executor_blocks_index), nil, true);
    create_block_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "WINGS", get_full_executor_index(_G.executor_wings_index), nil, true);
    create_wing_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "DIR", get_full_executor_index(_G.executor_dir_index), nil, true);
    create_dir_cues(sequence);

    sequence = sequence + 1;
    create_sequence(sequence, "BEAM", get_full_executor_index(_G.executor_beam_index), get_color_red());
    create_cue(sequence, 1, "ON", create_cue_cmd_group_on(_G.beam_color_var, _G.beam_group_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_group_off(_G.beam_color_var, _G.beam_group_index));

    sequence = sequence + 1;
    create_sequence(sequence, "SPOT", get_full_executor_index(_G.executor_spot_index), get_color_red());
    create_cue(sequence, 1, "ON", create_cue_cmd_group_on(_G.spot_color_var, _G.spot_group_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_group_off(_G.spot_color_var, _G.spot_group_index));

    sequence = sequence + 1;
    create_sequence(sequence, "WASH 1", get_full_executor_index(_G.executor_wash1_index), get_color_red());
    create_cue(sequence, 1, "ON", create_cue_cmd_group_on(_G.wash1_color_var, _G.wash1_group_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_group_off(_G.wash1_color_var, _G.wash1_group_index));

    sequence = sequence + 1;
    create_sequence(sequence, "WASH 2", get_full_executor_index(_G.executor_wash2_index), get_color_red());
    create_cue(sequence, 1, "ON", create_cue_cmd_group_on(_G.wash2_color_var, _G.wash2_group_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_group_off(_G.wash2_color_var, _G.wash2_group_index));

    sequence = sequence + 1;
    create_sequence(sequence, "LED", get_full_executor_index(_G.executor_led_index), get_color_red());
    create_cue(sequence, 1, "ON", create_cue_cmd_group_on(_G.led_color_var, _G.led_group_index));
    create_cue(sequence, 2, "OFF", create_cue_cmd_group_off(_G.led_color_var, _G.led_group_index));

    log("Done creating color picker exec buttons");
end

function get_full_executor_index(executorIndex)
    return _G.exec_button_page .. "." .. executorIndex;
end

--- Create/overwrite sequence
---@param seqIndex number The sequence index
---@param name string The name of the sequence
---@param executor string The executor index to link the sequence to
---@param color string The color options for the sequence
---@param isGoTo boolean Is the sequence executor a GoTo button
---@param isRelease boolean Is the executor released after activation
function create_sequence(seqIndex, name, executor, color, isGoTo, isRelease)
    local executorOptions = "";

    log("Creating sequence " .. name .. " at index " .. seqIndex);
    gma.cmd(string.format("Store Sequence %i Cue 1 /nc", seqIndex));
    gma.cmd(string.format("Assign Sequence %i /name=\"%s\"", seqIndex, name));
    gma.cmd(string.format("Assign Sequence %i At Executor %s", seqIndex, executor))

    if color ~= nil then
        gma.cmd(string.format("Appearance Sequence %i %s", seqIndex, color))
    end
    if isRelease ~= nil then
        executorOptions = "/cm=release";
    end
    if isGoTo ~= nil then
        gma.cmd(string.format("Assign GoTo Executor %s %s", executor, executorOptions));
    end
end

---@param sequence number The sequence index to create the cue in
---@param cueIndex number The cue index in the sequence
---@param name string The name of the cue
function create_cue(sequence, cueIndex, name, cmd)
    local cueOptions = "";

    gma.cmd(string.format("Store Sequence %i Cue %i /nc", sequence, cueIndex));

    if cmd ~= nil then
        cueOptions = string.format(" /cmd=\"%s\"", cmd);
    end

    gma.cmd(string.format('Assign Sequence %i Cue %i /name="%s" %s', sequence, cueIndex, name, cueOptions));
end

function create_cue_cmd_on(effectIndex)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. get_color_groups_cmd();
    cmd = cmd .. "Store Effect " .. effectIndex .. "; ";
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

function create_cue_cmd_off(effectIndex)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. "Store Effect " .. effectIndex .. "; ";
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

---@param varName string The variable name in the gma2 show
---@param groupIndex number The group index to switch on
function create_cue_cmd_group_on(varName, groupIndex)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. string.format("SetVar $%s='Group %i'; ", varName .. exec_button_page, groupIndex);
    cmd = cmd .. get_color_groups_cmd();
    cmd = cmd .. string.format("Store Effect 1.%i.1 Thru 1.%i.3; ", effect_index, effect_index);
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

function create_cue_cmd_group_off(varName)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. string.format("SetVar $%s='Group 999'; ", varName .. exec_button_page);
    cmd = cmd .. get_color_groups_cmd();
    cmd = cmd .. string.format("Store Effect 1.%i.1 Thru 1.%i.3; ", effect_index, effect_index);
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

function create_cue_cmd_form(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_form_index), cueIndex);
end

function create_cue_cmd_group(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_groups_index), cueIndex);
end

function create_cue_cmd_blocks(cueIndex)
    return string.format("GoTo Executor %s Cue %i; ", get_full_executor_index(_G.executor_blocks_index), cueIndex);
end

function create_cue_cmd_executor_off(executorIndex)
    return string.format("Off Executor %s; ", get_full_executor_index(executorIndex));
end

function create_color_cues(sequence, presetName, presetIndex)
    gma.cmd(string.format("Store Preset 4.%i", presetIndex));
    gma.cmd(string.format("Assign Preset 4.%i /name=\"%s\"", presetIndex, presetName));

    create_cue(sequence, 1, "WHITE", string.format("Copy Preset 4.1  At 4.%i /m", presetIndex))
    create_cue(sequence, 2, "RED", string.format("Copy Preset 4.2  At 4.%i /m", presetIndex))
    create_cue(sequence, 3, "ORANGE", string.format("Copy Preset 4.3  At 4.%i /m", presetIndex))
    create_cue(sequence, 4, "YELLOW", string.format("Copy Preset 4.4  At 4.%i /m", presetIndex))
    create_cue(sequence, 5, "GREEN", string.format("Copy Preset 4.5  At 4.%i /m", presetIndex))
    create_cue(sequence, 6, "SEA", string.format("Copy Preset 4.6 At 4.%i /m", presetIndex))
    create_cue(sequence, 7, "CYAN", string.format("Copy Preset 4.7  At 4.%i /m", presetIndex))
    create_cue(sequence, 8, "BLUE", string.format("Copy Preset 4.8  At 4.%i /m", presetIndex))
    create_cue(sequence, 9, "AVENDER", string.format("Copy Preset 4.9  At 4.%i /m", presetIndex))
    create_cue(sequence, 10, "VIOLET", string.format("Copy Preset 4.10  At 4.%i /m", presetIndex))
    create_cue(sequence, 11, "MAGENTA", string.format("Copy Preset 4.11  At 4.%i /m", presetIndex))
    create_cue(sequence, 12, "PINK", string.format("Copy Preset 4.12  At 4.%i /m", presetIndex))
    create_cue(sequence, 13, "BLACK", string.format("Copy Preset 4.13  At 4.%i /m", presetIndex))
end

function create_gobo_cues(sequence, presetName, presetIndex)
    gma.cmd(string.format("Store Preset 3.%i", presetIndex));
    gma.cmd(string.format("Assign Preset 3.%i /name=\"%s\"", presetIndex, presetName));

    create_cue(sequence, 1, "OPEN", string.format("Copy Preset 3.1 At 3.%i /m", presetIndex))
    create_cue(sequence, 2, "FLOWERS", string.format("Copy Preset 3.2 At 3.%i /m", presetIndex))
    create_cue(sequence, 3, "DOTS", string.format("Copy Preset 3.3 At 3.%i /m", presetIndex))
    create_cue(sequence, 4, "WINDMILL", string.format("Copy Preset 3.4 At 3.%i /m", presetIndex))
    create_cue(sequence, 5, "RAYS", string.format("Copy Preset 3.5 At 3.%i /m", presetIndex))
    create_cue(sequence, 6, "CIRCLE", string.format("Copy Preset 3.6 At 3.%i /m", presetIndex))
    create_cue(sequence, 7, "LINES", string.format("Copy Preset 3.7 At 3.%i /m", presetIndex))
    create_cue(sequence, 8, "OVAL", string.format("Copy Preset 3.8 At 3.%i /m", presetIndex))
    create_cue(sequence, 9, "LIMBO", string.format("Copy Preset 3.9 At 3.%i /m", presetIndex))
end

function create_preset_cues(sequence)
    create_cue(sequence, 1, "CHASE 2", create_cue_cmd_form(1) .. create_cue_cmd_group(1));
    create_cue(sequence, 2, "CHASE 3", create_cue_cmd_form(1) .. create_cue_cmd_group(2));
    create_cue(sequence, 3, "SIN 2", create_cue_cmd_form(2) .. create_cue_cmd_group(2));
    create_cue(sequence, 4, "SIN 3", create_cue_cmd_form(2) .. create_cue_cmd_group(4));
    create_cue(sequence, 5, "PWN 2", create_cue_cmd_form(3) .. create_cue_cmd_group(1));
    create_cue(sequence, 6, "PWN 3", create_cue_cmd_form(3) .. create_cue_cmd_group(2));
    create_cue(sequence, 7, "RAMP 2", create_cue_cmd_form(4) .. create_cue_cmd_group(1));
    create_cue(sequence, 8, "RAMP 3", create_cue_cmd_form(4) .. create_cue_cmd_group(2));
    create_cue(sequence, 9, "STEP 2", create_cue_cmd_form(7) .. create_cue_cmd_group(1));
    create_cue(sequence, 10, "STEP 3", create_cue_cmd_form(7) .. create_cue_cmd_group(2));
    create_cue(sequence, 11, "FULL", create_cue_cmd_form(5) .. create_cue_cmd_group(1));
    create_cue(sequence, 12, "FULL EVEN/ODD", create_cue_cmd_form(1) .. create_cue_cmd_group(1) .. create_cue_cmd_blocks(4));
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
    create_cue(sequence, 9, "RAINBOW", string.format("Assign Form 13 At Effect 1.%i.1; Assign Form 14 At Effect 1.%i.2;  Assign Form 15 At Effect 1.%i.3;  Assign Effect %i /phase=0..360 /width=100", _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index));
    create_cue(sequence, 10, "C SIN MY PWM", string.format("Assign Form 8 At Effect 1.%i.1; Assign Effect 1.%i.1 /phase=0..360 /width=100; Assign Form 4 At Effect 1.%i.1 Thru 1.%i.3 - 1.%i.1; Assign Effect 1.%i.2 /phase=90 /width=50; Assign Effect 1.%i.3 /phase=-90 /width=50", _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index));
    create_cue(sequence, 11, "M SIN CY PWM", string.format("Assign Form 8 At Effect 1.%i.2; Assign Effect 1.%i.2 /phase=0..360 /width=100; Assign Form 4 At Effect 1.%i.1 Thru 1.%i.3 - 1.%i.2; Assign Effect 1.%i.1 /phase=90 /width=50; Assign Effect 1.%i.3 /phase=-90 /width=50", _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index));
    create_cue(sequence, 12, "Y SIN CM PWM", string.format("Assign Form 8 At Effect 1.%i.3; Assign Effect 1.%i.3 /phase=0..360 /width=100; Assign Form 4 At Effect 1.%i.1 Thru 1.%i.3 - 1.%i.3; Assign Effect 1.%i.1 /phase=90 /width=50; Assign Effect 1.%i.2 /phase=-90 /width=50", _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index, _G.effect_index));
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

function get_color_blue()
    return "/b=100 /g=50 /r=50 /h=240 /s=50";
end

function get_color_red()
    return "/b=50 /g=50 /r=100 /h=0 /s=50";
end

function get_color_groups_cmd()
    return string.format("$%s + $%s + $%s + $%s + $%s; ",
            beam_color_var .. exec_button_page, spot_color_var .. exec_button_page, wash1_color_var .. exec_button_page, wash2_color_var .. exec_button_page, led_color_var .. exec_button_page);
end

function initialize_vars()
    log("Initializing vars...")
    gma.show.setvar(beam_color_var .. exec_button_page, "Group 999");
    gma.show.setvar(spot_color_var .. exec_button_page, "Group 999");
    gma.show.setvar(wash1_color_var .. exec_button_page, "Group 999");
    gma.show.setvar(wash2_color_var .. exec_button_page, "Group 999");
    gma.show.setvar(led_color_var .. exec_button_page, "Group 999");
    log("Initializing vars done")
end

--- Log the message to the GMA console
---@param message string Set the message to log
function log(message)
    gma.echo("[" .. plugin_name .. "]" .. ": " .. message);
end

--- Get a numeric input value from the user
---@param title string The title to display
---@param default_value string The default value to show
function get_number_input(title, default_value)
    local input = gma.textinput(title, default_value);
    local number = tonumber(input);
    return number;
end

--- Get an optional var from the gma show file.
---@param name string The var name to retrieve.
function get_show_var(name)
    local value = gma.show.getvar(name);

    if value ~= nil then
        return value;
    else
        return "";
    end
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    _G.exec_button_page = get_show_var("exec_button_page");
    _G.exec_button_page = get_number_input("Executor page for buttons", _G.exec_button_page);
    log("Setting exec_button_page to " .. _G.exec_button_page);
    gma.show.setvar("exec_button_page", _G.exec_button_page);

    _G.exec_color_picker_page = get_show_var(picker_page_var);
    _G.exec_color_picker_page = get_number_input("Executor page for Color Picker", _G.exec_color_picker_page);
    log("Setting $picker_page & exec_color_picker_page to " .. _G.exec_color_picker_page);
    gma.show.setvar(picker_page_var, _G.exec_color_picker_page);

    _G.macro_start_index = get_show_var("macro_start_index");
    _G.macro_start_index = get_number_input("Macro start index of the Color Picker", _G.macro_start_index);
    log("Setting macro_start_index to " .. _G.macro_start_index);
    gma.show.setvar("macro_start_index", _G.macro_start_index);

    _G.seq_start_index = get_show_var("seq_start_index");
    _G.seq_start_index = get_number_input("Sequence start index", _G.seq_start_index);
    log("Setting seq_start_index to " .. _G.seq_start_index);
    gma.show.setvar("seq_start_index", _G.seq_start_index);

    _G.effect_index = get_show_var("effect");
    _G.effect_index = get_number_input("Store in effect", _G.effect_index);
    log("Setting effect to " .. _G.effect_index);
    gma.show.setvar("effect", _G.effect_index);

    _G.effect_executor = get_show_var("effect_executor");
    _G.effect_executor = get_number_input("Assign effect to Executor", _G.effect_executor);
    log("Setting effect_executor to " .. _G.effect_executor);
    gma.show.setvar("effect_executor", _G.effect_executor);

    create_color_picker_macros();
    create_exec_buttons();
    initialize_vars();
end

function finalize()
end

return main, finalize;