--region ColorPool

color_preset_pool = 4;
color_white_index = 1;
color_red_index = 2;
color_orange_index = 3;
color_yellow_index = 4;
color_green_index = 5;
color_sea_index = 6;
color_cyan_index = 7;
color_blue_index = 8;
color_avender_index = 9;
color_violet_index = 10;
color_magenta_index = 11;
color_pink_index = 12;
color_black_index = 13;

ColorPool = {}

function ColorPool:prepare()
    Log:info("Preparing Color pool")

    ColorPool.store(color_white_index, "WHITE");
    ColorPool.store(color_red_index, "RED");
    ColorPool.store(color_orange_index, "ORANGE");
    ColorPool.store(color_yellow_index, "YELLOW");
    ColorPool.store(color_green_index, "GREEN");
    ColorPool.store(color_sea_index, "SEA");
    ColorPool.store(color_cyan_index, "CYAN");
    ColorPool.store(color_blue_index, "BLUE");
    ColorPool.store(color_avender_index, "AVENDER");
    ColorPool.store(color_violet_index, "VIOLET");
    ColorPool.store(color_magenta_index, "MAGENTA");
    ColorPool.store(color_pink_index, "PINK");
    ColorPool.store(color_black_index, "BLACK");
end

function ColorPool:store(index, name)
    preset_label(_G.color_preset_pool, index, name)
end

--endregion

--region BeamPool

beam_preset_pool = 5;
beam_open_index = 1;
beam_min_index = 2;
beam_max_index = 3;

BeamPool = {}

function BeamPool:prepare()
    Log:info("Preparing Beam pool")

    BeamPool:store(_G.beam_open_index, "OPEN");
    BeamPool:store(_G.beam_min_index, "MIN");
    BeamPool:store(_G.beam_max_index, "MAX");
end

function BeamPool:store(index, name)
    preset_label(_G.beam_preset_pool, index, name)
end

--endregion

--region FocusPool

focus_preset_pool = 6;
focus_narrow_index = 1;
focus_small_index = 2;
focus_normal_index = 3;
focus_large_index = 4;
focus_wide_index = 5;

FocusPool = {}

function FocusPool:prepare()
    Log:info("Preparing Focus pool")

    FocusPool:store(_G.focus_narrow_index, "NARROW");
    FocusPool:store(_G.focus_small_index, "SMALL");
    FocusPool:store(_G.focus_normal_index, "NORMAL");
    FocusPool:store(_G.focus_large_index, "LARGE");
    FocusPool:store(_G.focus_wide_index, "WIDE");
end

function FocusPool:store(index, name)
    preset_label(_G.focus_preset_pool, index, name)
end

--endregion

--- Plugin Entry Point
function main()
    clear_all()

    -- Set plugin name for logging
    _G.plugin_name = "Prepare";

    ColorPool.prepare();
    BeamPool.prepare();
    FocusPool.prepare();
end

function finalize()
end

return main, finalize;
