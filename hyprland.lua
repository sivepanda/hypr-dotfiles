-- This is a Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- hl.monitor({ output = "desc:Acer Technologies XF273U W2 0x01010101", mode = "2560x1440@144.00", position = "0x0", scale = 1 })
-- hl.monitor({ output = "eDP-1", mode = "1900x1200@60", position = "2560x0", scale = 1.25 })

hl.monitor({ output = "eDP-1", mode = "1900x1200@60", position = "0x0", scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------

local terminal = "ghostty +new-window"
local fileManager = "nautilus"
local menu = "vicinae toggle"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & hyprpaper & solaar & openrgb & hypridle")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("nmcli d connect wlp8s0")
    hl.exec_cmd("bluetoothctl trust AC:BF:71:C8:79:F9")
    hl.exec_cmd("vicinae server")
    hl.exec_cmd("/home/siven/.local/bin/randwallpaper")
    hl.exec_cmd("systemctl enable --user app-com.mitchellh.ghostty.service")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal-hyprland")
    hl.exec_cmd("systemctl --user start xdg-desktop-portal")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card1:/dev/dri/card2")
hl.env("DRI_PRIME", "0")

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Keep using the generated palette shared with Hyprlock.
local palette = {}
for line in io.lines(os.getenv("HOME") .. "/.config/hypr/colors.conf") do
    local name, value = line:match("^%s*%$([%w_]+)%s*=%s*(.-)%s*$")
    if name then
        palette[name] = value
    end
end

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 3,
        border_size = 1,
        col = {
            active_border = { colors = { palette.primary, palette.secondary_dim }, angle = 45 },
            inactive_border = palette.outline_dim,
        },
        resize_on_border = true,
        allow_tearing = false,

        -- Default to dwindle on non-primary workspaces.
        layout = "dwindle",
    },
    decoration = {
        rounding = 10,
        rounding_power = 3,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        blur = {
            enabled = true,
            size = 6,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
    },
})

-- Scrolling WM on the primary workspace.
hl.workspace_rule({ workspace = "1", layout = "scrolling" })

-- Default animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("eazy", { type = "bezier", points = { { 0.17, 0.24 }, { 0.28, 1 } } })
hl.curve("bouncy", { type = "bezier", points = { { 0, 0.63 }, { 0.31, 1.11 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.5, 0.06 }, { 0.31, 0.98 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "eazy", style = "gnomed" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "bouncy", style = "gnomed" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "bouncy", style = "popin 87%" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })

hl.layer_rule({ match = { namespace = "hyprlock" }, xray = true })
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "vicinae" }, blur = true })

hl.config({
    dwindle = {
        preserve_split = true,
    },
    scrolling = {
        focus_fit_method = 1,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "caps:escape",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.6,
            tap_to_click = false,
            clickfinger_behavior = true,
        },
    },
    gestures = {
        workspace_swipe_distance = 3,
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({
    fingers = 4,
    direction = "up",
    action = function()
        hl.exec_cmd(menu)
    end,
})

local function dispatchScrollingLayout(command)
    local workspace = hl.get_active_workspace()
    if workspace and workspace.tiled_layout == "scrolling" then
        hl.dispatch(hl.dsp.layout(command))
    end
end

hl.gesture({
    fingers = 3,
    direction = "left",
    action = function()
        dispatchScrollingLayout("move +col")
    end,
})
hl.gesture({
    fingers = 3,
    direction = "right",
    action = function()
        dispatchScrollingLayout("move -col")
    end,
})
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        dispatchScrollingLayout("promote")
    end,
})

-- Example per-device config.
hl.device({
    name = "epic-mouse-v1",
    sensitivity = -0.5,
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal), { description = "Terminal" })
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu), { description = "Launcher" })
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager), { description = "Files" })
hl.bind(mainMod .. " + C", hl.dsp.window.close(), { description = "Close window" })
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("flatpak run com.discordapp.Discord"), { description = "Discord" })
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprshutdown"), { description = "Power menu" })
hl.bind(mainMod .. " + CTRL + M", hl.dsp.exit(), { description = "Exit Hyprland", locked = "true"})
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify"), { description = "Spotify" })
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("/usr/bin/zen/zen"), { description = "Browser" })
hl.bind(mainMod .. " + CTRL + Z", hl.dsp.exec_cmd("zoom"), { description = "Zoom" })
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock screen" })
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("hyprpicker -a"), { description = "Color picker" })
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/clipboard/history"), { description = "Clipboard History" })
hl.bind(mainMod .. " + CTRL + F", hl.dsp.exec_cmd("vicinae vicinae://extensions/vicinae/browser-extension/browse-tabs"), { description = "Zen Tabs" })

-- Tiling WM (Dwindle) motions.
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ workspace = "e+1" }), { description = "Next workspace", repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ workspace = "e-1" }), { description = "Prev workspace", repeating = true })

-- Scrolling WM motions.
hl.bind(mainMod .. " + P", hl.dsp.layout("promote"), { description = "Promote window" })
hl.bind(mainMod .. " + CTRL + H", hl.dsp.layout("move +col"), { description = "Move column right" })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.layout("move -col"), { description = "Move column left" })
hl.bind(mainMod .. " + period", hl.dsp.layout("swapcol r"), { description = "Swap column right" })
hl.bind(mainMod .. " + comma", hl.dsp.layout("swapcol l"), { description = "Swap column left" })
hl.bind(mainMod .. " + mouse_up", hl.dsp.layout("move +col"), { description = "Move column right" })
hl.bind(mainMod .. " + mouse_down", hl.dsp.layout("move -col"), { description = "Move column left" })

-- Motions.
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "e+1" }), { description = "Move to next workspace", repeating = true })
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "e-1" }), { description = "Move to prev workspace", repeating = true })

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + CTRL + H", hl.dsp.focus({ direction = "left" }), { description = "Focus left", repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.focus({ direction = "right" }), { description = "Focus right", repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ direction = "up" }), { description = "Focus up", repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.focus({ direction = "down" }), { description = "Focus down", repeating = true })

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }), { description = "Focus left", repeating = true })
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }), { description = "Focus right", repeating = true })
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }), { description = "Focus up", repeating = true })
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }), { description = "Focus down", repeating = true })

-- Switch workspaces and move windows with mainMod + [0-9].
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- System: lid switch and brightness.
hl.bind("switch:Lid Switch", hl.dsp.exec_cmd("loginctl lock-session"), { description = "Lock on lid close", locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s 5%+"), { description = "Brightness up", locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 1%-"), { description = "Brightness down", locked = true, repeating = true })

-- Multimedia.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { description = "Volume up", locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { description = "Volume down", locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { description = "Mute audio", locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { description = "Mute mic", locked = true, repeating = true })
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl next"), { description = "Next track", locked = true })
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl previous"), { description = "Previous track", locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play/pause", locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { description = "Play/pause", locked = true })

-- Screenshots with hyprshot.
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"), { description = "Screenshot window" })
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"), { description = "Screenshot region" })
hl.bind(mainMod .. " + SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m output"), { description = "Screenshot monitor" })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
