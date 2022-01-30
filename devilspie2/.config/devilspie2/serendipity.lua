-- use `devilspie2 --debug` to enable calls to `debug_print()`
debug_print("")
debug_print(get_application_name())
debug_print("  " .. get_window_name());
debug_print(get_window_geometry())

function string.startswith(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function string.endswith(String, End)
    return End == '' or string.sub(String, -string.len(End)) == End
end

-- if (get_application_name() == "uzbl-core") then
--   -- maximize_vertically();
--   -- set_window_geometry(478, -936, 963, 900);
--   -- focus();
-- end

if (get_application_name() == "Terminal") then
  maximize();
  -- set_window_geometry(478, -936, 963, 900);
  focus();
end

-- if (get_application_name() == "nautilus") then
--   set_window_geometry(478, -936, 963, 900);
-- end

-- if (get_window_name() == "VLC media player") then
if (string.endswith(get_window_name(), "VLC media player")) then
  -- -- set_window_geometry(-1441, -936, 480, 307);
  -- set_window_geometry(1439, -1236, 472, 270);
  -- set_window_geometry(1440, -1197, 472, 270);  Sep 18, 2017
  set_window_geometry(1440, -1197, 421, 274);
  make_always_on_top();
end

if (get_window_name() == "mplayer2") then
  -- -- set_window_geometry(-1441, -936, 480, 307);
  -- set_window_geometry(1439, -1236, 472, 270);
  set_window_geometry(1440, -1197, 472, 270);
  make_always_on_top();
end

-- if (get_application_name() == "Vlc" and
--     get_window_name() == "Playlist") then
--   maximize_vertically();
--   set_window_geometry(478, -936, 963, 900);
-- end
-- 
-- if (get_application_name() == "Remote Desktop Viewer") then
--   -- maximize_vertically();
--   -- set_window_geometry(478, -936, 963, 900);
-- end
--  
-- if (get_application_name() == "Iceweasel") then
--   -- maximize_vertically();
--   -- os.execute("sleep 5");
--   -- set_window_geometry(481, -936, 963, 896);
-- end
-- 
-- if (get_application_name() == "Firefox" and
--     string.endswith(get_window_name(), " - Tor Browser")) then
-- end

undecorate_window();
