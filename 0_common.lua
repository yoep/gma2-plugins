--- Log the message to the GMA console
---
---@param message string Set the message to log
function log(message)
    gma.echo("[" .. _G.plugin_name .. "]" .. ": " .. message);
end

--- Call the clear all command in MA2
function clear_all()
    gma.cmd("ClearAll");
end

--- Plugin Entry Point
function main()
    --- no-op
end

function finalize()
end

return main, finalize;