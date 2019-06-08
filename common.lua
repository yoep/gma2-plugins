---
--- Common Functionality Library
---

--- Common vars
plugin_name = "";
page_index = 0;

---
--- GETTERS
---

--- Get the executor index for the page
---@param executor_index number The button executor index.
function get_full_executor_index(executor_index)
    -- _G.page_index should be updated in the main function before calling this method
    return _G.page_index .. "." .. executor_index;
end

--- Get the effect line index
function get_multi_line_effect_index(effect_index, start_index, end_index)
    return string.format("1.%i.%i Thru 1.%i.%i", effect_index, start_index, effect_index, end_index);
end

--- Get the blue color CMD
function get_color_blue()
    return "/b=100 /g=50 /r=50 /h=240 /s=50";
end

--- Get the red color CMD
function get_color_red()
    return "/b=50 /g=50 /r=100 /h=0 /s=50";
end

--- Get the cyan color CMD
function get_color_cyan()
    return "/b=100 /g=100 /r=0 /h=0 /s=50";
end

---
--- SEQUENCE AND CUE FUNCTIONS
---

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

--- Delete an existing executor
---@param executorIndex number The executor index to remove
function delete_executor(executorIndex)
    log(string.format("Deleting executor at index %i", executorIndex));
    gma.cmd(string.format("Delete Executor %i /nc", executorIndex));
end

--- Delete an existing sequence
---@param sequenceIndex number The sequence index to remove
function delete_sequence(sequenceIndex)
    log(string.format("Deleting sequence at index %i", sequenceIndex));
    gma.cmd(string.format("Delete Sequence %i /nc", sequenceIndex));
end

--- Delete the existing executor with its sequence
---@param executorIndex number The executor index to remove
---@param sequenceIndex number The sequence index to remove
function delete_executor_and_sequence(executorIndex, sequenceIndex)
    delete_executor(executorIndex);
    delete_sequence(sequenceIndex);
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

---
--- CMD CREATION FUNCTIONS
---

--- Create GoTo Executor Cue CMD
---@param executor number The executor number.
---@param cueIndex number The cue index in the executor to go to.
---@return string Returns the go to executor cue CMD.
function create_goto_cmd(executor, cueIndex)
    local fullExecutorIndex = get_full_executor_index(executor);

    return string.format("GoTo Executor %s Cue %i; ", fullExecutorIndex, cueIndex);
end

--- Create the CMD to enable/activate a certain group in an effect.
---@param effect_index number The effect index to enable/activate the group in.
---@param start_index number The start effect line to enable the group in.
---@param end_index number The end effect line to enable the group in
---@param var_name string The variable name in the gma2 show to modify the selection of.
---@param group_index number The group index to enable/activate in the varName.
function create_cue_cmd_group_on(effect_index, start_index, end_index, var_name, group_index, group_cmd)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. string.format("SetVar $%s='Group %i'; ", var_name .. _G.page_index, group_index);
    cmd = cmd .. group_cmd .. "; ";
    cmd = cmd .. string.format("Store Effect %s; ", get_multi_line_effect_index(effect_index, start_index, end_index));
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

--- Create the CMD to disable a certain group in an effect.
---@param effect_index number The effect index to disable the group in.
---@param start_index number The start effect line to disable the group in.
---@param end_index number The end effect line to disable the group in
---@param var_name string The variable name in the gma2 show to modify the selection of.
function create_cue_cmd_group_off(effect_index, start_index, end_index, varName, group_cmd)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. string.format("SetVar $%s='Group 999'; ", varName .. _G.page_index);
    cmd = cmd .. group_cmd .. "; ";
    cmd = cmd .. string.format("Store Effect %s; ", get_multi_line_effect_index(effect_index, start_index, end_index));
    cmd = cmd .. "ClearAll; ";
    cmd = cmd .. "BlindEdit Off; ";
    return cmd;
end

function create_cue_cmd_on(effectIndex, groups_cmd)
    local cmd = "";
    cmd = cmd .. "BlindEdit On; ";
    cmd = cmd .. "ClearSelection; ";
    cmd = cmd .. groups_cmd .. "; ";
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

--- Create the cmd to modify the effect phase
---@param effect_index number The effect index to modify the phase of.
---@param phase string The phase that should be applied to the effect.
---@param width number The width of the effect.
function create_cmd_phase(effect_index, phase, width)
    if width == nil then
        width = 100;
    end

    return string.format("Assign Effect %i /phase=%s /width=%i; ", effect_index, phase, width);
end

--- Create the cmd to modify the effect phase
---@param effect_index number The effect index to modify the phase of.
---@param effect_line number The effect line index to modify the phase of.
---@param phase string The phase that should be applied to the effect.
---@param width number The width of the effect line.
function create_cmd_phase_effect_line(effect_index, phase, effect_line, width)
    if width == nil then
        width = 100;
    end

    return string.format("Assign Effect 1.%i.%i /phase=%s /width=%i; ", effect_index, effect_line, phase, width);
end

--- Create the direction cues for the given sequence and effect
---@param sequence number The sequence index to assign the cue to.
---@param effect_index number The effect index to modify the direction of.
function create_dir_cues(sequence, effect_index)
    create_cue(sequence, 1, "<", string.format("Assign Effect %i /dir=<", effect_index));
    create_cue(sequence, 2, ">", string.format("Assign Effect %i /dir=>", effect_index));
    create_cue(sequence, 3, "< BOUNCE", string.format("Assign Effect %i /dir=<bounce", effect_index));
    create_cue(sequence, 4, "> BOUNCE", string.format("Assign Effect %i /dir=>bounce", effect_index));
end

---
--- GENERIC FUNCTIONS
---

--- Log the message to the GMA console
---@param message string Set the message to log
function log(message)
    gma.echo("[" .. _G.plugin_name .. "]" .. ": " .. message);
end

--- Get the input value from the user
---@param title string The title to display
---@param default_value string The default value to show
function get_input(title, default_value)
    return gma.textinput(title, default_value);
end

--- Get a numeric input value from the user
---@param title string The title to display
---@param default_value string The default value to show
function get_number_input(title, default_value)
    local input = get_input(title, default_value);
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

--- Get and update the given var
---@param name string The name of the var to request the input value for.
---@param text string The text to show to the user.
function show_user_var_input(name, text)
    local current_value = get_show_var(name);
    local new_value = get_input(text, current_value);

    log("Updating '" .. name .. "' with new value: " .. new_value);
    gma.show.setvar(name, new_value);

    return new_value;
end

--- Get and update the given numeric var
---@param name string The name of the var to request the input value for.
---@param text string The text to show to the user.
function show_user_var_input_number(name, text)
    local current_value = get_show_var(name);
    local new_value = get_number_input(text, current_value);

    log("Updating '" .. name .. "' with new numeric value: " .. new_value);
    gma.show.setvar(name, new_value);

    return new_value;
end

--- Plugin Entry Point
function main()
    --- no-op
end

function finalize()
end

return main, finalize;