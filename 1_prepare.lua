--region Beam

beam_preset_pool = 5;
beam_open_index = 1;
beam_min_index = 2;
beam_max_index = 3;

Beam = {}

function Beam:prepare()
    Log:info("Preparing Beam pool")

    Beam:store(_G.beam_open_index, "OPEN");
    Beam:store(_G.beam_min_index, "MIN");
    Beam:store(_G.beam_max_index, "MAX");
end

function Beam:store(index, name)
    preset_label(_G.beam_preset_pool, index, name)
end

--endregion

--region Focus

focus_preset_pool = 6;
focus_narrow_index = 1;
focus_small_index = 2;
focus_normal_index = 3;
focus_large_index = 4;
focus_wide_index = 5;

Focus = {}

function Focus:prepare()
    Log:info("Preparing Focus pool")

    Focus:store(_G.focus_narrow_index, "NARROW");
    Focus:store(_G.focus_small_index, "SMALL");
    Focus:store(_G.focus_normal_index, "NORMAL");
    Focus:store(_G.focus_large_index, "LARGE");
    Focus:store(_G.focus_wide_index, "WIDE");
end

function Focus:store(index, name)
    preset_label(_G.focus_preset_pool, index, name)
end

--endregion

--- Plugin Entry Point
function main()
    clear_all()

    -- Set plugin name for logging
    _G.plugin_name = "Prepare";

    Beam.prepare();
    Focus.prepare();
end

function finalize()
end

return main, finalize;
