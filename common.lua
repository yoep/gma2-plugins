--- Get the executor index for the page
---@param executorIndex number The index of the executor.
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

--- Get and update the given var
---@param name string The name of the var to request the input value for.
---@param text string The text to show to the user.
function show_user_var_input(name, text)
    local current_value = get_show_var(name);
    local new_value = get_number_input(text, current_value);

    log("Updating '" .. name .. "' with new value: " .. new_value);
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