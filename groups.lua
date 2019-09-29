---
--- Group Registration Plugin
--- Register the group information of the show file to use in the other plugins
---

---
--- Groups Config
---

--- Group indexes
group_all_index = 10;
group_beams_index = 20;
group_spots_index = 30;
group_wash1_index = 40;
group_wash2_index = 50;
group_led1_index = 60;
group_led2_index = 70;
group_blinders_index = 80;
group_strobes_index = 90;
group_indexes = { group_beams_index, group_spots_index, group_wash1_index, group_wash2_index, group_led1_index, group_led2_index, group_all_index };

--- Group names
group_all_name = "ALL";
group_beams_name = "BEAMS";
group_spots_name = "SPOTS";
group_wash1_name = "WASH1";
group_wash2_name = "WASH2";
group_led1_name = "LED1";
group_led2_name = "LED2";
group_blinders_name = "BLINDERS";
group_strobes_name = "STROBES";

--- Group subgroups
group_subgroups_blinders = 1;

--- Group vars
group_vars_blinders_subgroups = "group_vars_blinders_subgroups";

---
--- GETTERS
---

--- Get the total subgroups of the blinders
---@return number Returns the number of subgroups for the blinders.
function get_subgroups_blinders()
    return tonumber(get_show_var(group_vars_blinders_subgroups));
end

--- Get the group for the given index.
---@return string The group command for the group at the given index.
function get_group(index)
    return "Group " .. _G.group_indexes[index];
end

--- Get the group for all
---@return string The all group command.
function get_group_all()
    return "Group " .. _G.group_all_index;
end

--- Get the group for blinders
---@return string The blinders group command.
function get_group_blinders()
    return "Group " .. _G.group_beams_index;
end

--- Get the group for spots
---@return string The spots group command.
function get_group_spots()
    return "Group " .. _G.group_spots_index;
end

--- Get the group for wash1
---@return string The wash1 group command.
function get_group_wash1()
    return "Group " .. _G.group_wash1_index;
end

--- Get the group for wash2
---@return string The wash2 group command.
function get_group_wash2()
    return "Group " .. _G.group_wash2_index;
end

--- Get the group for led1
---@return string The led1 group command.
function get_group_led1()
    return "Group " .. _G.group_led1_index;
end

--- Get the group for led2
---@return string The led2 group command.
function get_group_led2()
    return "Group " .. _G.group_led2_index;
end

--- Get the group for blinders
---@return string The blinders group command.
function get_group_blinders()
    return "Group " .. _G.group_blinders_index;
end

--- Get the group for strobes
---@return string The strobes group command.
function get_group_strobes()
    return "Group " .. _G.group_strobes_name;
end

---
--- GROUP CREATION FUNCTIONS
---

function create_groups()
    -- all
    create_group(group_all_index, group_all_name);
    -- beams
    create_group(group_beams_index, group_beams_name);
    -- spot
    create_group(group_spots_index, group_spots_name);
    -- wash1
    create_group(group_wash1_index, group_wash1_name);
    -- wash2
    create_group(group_wash2_index, group_wash2_name);
    -- led1
    create_group(group_led1_index, group_led1_name);
    -- led2
    create_group(group_led2_index, group_led2_name);
    -- blinders
    create_group(group_blinders_index, group_blinders_name);
    create_subgroups(group_blinders_index + 1, group_blinders_name, group_subgroups_blinders)
    -- strobes
    create_group(group_strobes_index, group_strobes_name);
end

--- Create a group at given index
---@param index number The group index
---@param name string The name of the group
function create_group(index, name)
    gma.cmd(string.format("Store Group %i /nc", index));
    gma.cmd(string.format("Assign Group %i /name=\"%s\"", index, name));
end

function create_subgroups(start_index, subgroup_name, total_subgroups)
    local index = start_index;

    for i = 1, total_subgroups, 1 do
        create_group(index, subgroup_name .. " SG " .. i)

        index = index + 1;
    end
end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    -- Set plugin name for logging
    _G.plugin_name = "Groups";

    --- Request the subgroups of the blinders
    _G.group_subgroups_blinders = show_user_var_input(_G.group_vars_blinders_subgroups, string.format("Total %s subgroups", _G.group_blinders_name));

    local handle = gma.gui.progress.start(_G.plugin_name);
    gma.gui.progress.setrange(handle, 0, 1);
    gma.gui.progress.set(handle, 1);
    gma.gui.progress.settext(handle, "creating groups");
    create_groups();

    gma.gui.progress.settext(handle, "done");
    gma.gui.progress.stop(handle);
end

function finalize()
end

return main, finalize;