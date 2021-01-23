---
--- Group Registration Plugin
--- Register the group information of the show file to use in the other plugins
---

group_all_index = 1;
group_all_name = "ALL";

group_placeholder = "[PRESS ENTER WHEN DONE]";

group_vars_groups = "group_vars_groups";

--region Group

Group = {
    index = 0,
    name = ""
}

--- Create a new group object for the given index and name.
---@param index number  The index of the group.
---@param name  string  The name of the group.
---@return table Returns the new group instance.
function Group:new(index, name)
    local instance = {
        index = index,
        name = name
    }
    setmetatable(instance, Groups);
    self.__index = self
    return instance
end

--- Create the group within grandma
function Group:create()
    local index = self.index;
    local name = self.name;

    gma.cmd(string.format("Store Group %i /nc", index));
    gma.cmd(string.format("Assign Group %i /name=\"%s\"", index, name));
end

--endregion

--region Groups

Groups = {}

--- Instantiate a new Groups instance.
---@return table Returns a new Groups instance.
function Groups:new()
    local instance = {};
    setmetatable(instance, Groups);
    self.__index = self
    return instance;
end

--- Load the groups from the show.
--- If no groups are stored in the show, and empty instance will be returned.
---@return table Returns the groups of the show.
function Groups:load()
    Log:info("Loading existing groups")
    local instance = Groups:new();

    local savedGroups = gma.show.getvar(_G.group_vars_groups);

    if (savedGroups ~= nil) then
        for group in string.gmatch(savedGroups, "([^;]+)") do

        end
    end

    return instance
end

--- Request the groups from the user.
--- This method will show an input dialog to the user.
function Groups:request()
    local index = 10;
    local totalGroups = 1;
    local name = _G.group_placeholder;

    while (true)
    do
        name = gma.textinput("Enter group name (" .. totalGroups .. ")", _G.group_placeholder);

        if name == _G.group_placeholder or name == "" then
            break ;
        end

        local group = Group:new(index, name);
        table.insert(self, group);
        index = index + 10;
        totalGroups = totalGroups + 1;
    end
end

--endregion

--- Plugin Entry Point
function main()
    clear_all()

    -- Set plugin name for logging
    _G.plugin_name = "Groups";

    local groups = Groups:load();
    groups:request();
end

function finalize()
end

return main, finalize;
