---
--- Common plugin functions
---

--region Log

Log = {}

--- Log the given message to the GMA console.
---@param message   string  The message to log in the gma console.
function Log:info(message)
    Log:log(message, "INFO");
end

--- Log the given message to the GMA console.
---@param message   string  The message to log in the gma console.
function Log:warn(message)
    Log:log(message, "WARN");
end

--- Log the given message to the GMA console.
---@param message   string  The message to log in the gma console.
function Log:error(message)
    Log:log(message, "ERROR");
end

--- Log the given message to the GMA console.
---@param message   string  The message to log in the gma console.
---@param level     string  The level to print in the console.
function Log:log(message, level)
    gma.echo(level .. " --- [" .. _G.plugin_name .. "] : " .. message);
end

--endregion

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
