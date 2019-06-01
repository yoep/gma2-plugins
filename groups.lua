---
--- Group Registration Plugin
--- Register the group information of the show file to use in the other plugins
---

---
--- Groups Config
---

--- Global vars
plugin_name = "groups";

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


function create_groups()

end

--- Plugin Entry Point
function main()
    gma.cmd("ClearAll");

    --- Request the subgroups of the blinders
    _G.group_subgroups_blinders = show_user_var_input(_G.group_vars_blinders_subgroups, string.format("Total %s subgroups", _G.group_name_blinders));

    create_groups();
end

function finalize()
end

return main, finalize;