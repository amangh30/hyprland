---@module 'hl'

-- ################
-- ### MONITORS ###
-- ################

hl.monitor({
    output = "HDMI-A-1",
    mode = "preferred",
    position = "0x0",
    scale = 1,
})

hl.monitor({
    output = "eDP-1",
    disabled = true,
})

-- ###################
-- ### MY PROGRAMS ###
-- ###################

local terminal = "alacritty"
local fileManager = "thunar"
local menu = "wofi --show drun"

-- #################
-- ### AUTOSTART ###
-- #################

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("~/.local/bin/awww-rotate.sh")
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("~/.local/bin/hyprsunset-fullscreen.sh")
    hl.exec_cmd("wl-gammarelay")
end)

-- #############################
-- ### ENVIRONMENT VARIABLES ###
-- #############################

hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)

-- #####################
-- ### LOOK AND FEEL ###
-- #####################

-- Load Matugen Colors at the top of the file
local colors = dofile(os.getenv("HOME") .. "/.config/hypr/colors.lua")

hl.config({
    general = {
        gaps_in = 8,
        gaps_out = 16,
        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(" .. colors.primary .. "cc)", 
                    "rgba(" .. colors.secondary .. "cc)", 
                },
                angle = 45,
            },

            inactive_border = {
                colors = {
                    "rgba(" .. colors.surface .. "88)", 
                    "rgba(" .. colors.outline .. "88)",
                },
                angle = 45,
            },
        },
        resize_on_border = true, -- Much sleeker for mouse users
        allow_tearing = false,
        layout = "dwindle",
    },
})

-- #################
-- ### DECORATION ###
-- #################

hl.config({
    decoration = {
        rounding = 16, -- Slightly softer corners for a modern UI

        active_opacity = 0.94, -- Just enough transparency for the glass effect
        inactive_opacity = 0.85,

        shadow = {
            enabled = true,
            range = 25,
            render_power = 4,
            color = "rgba(00000088)", -- Softer, deeper shadow for a floating effect
        },

        blur = {
            enabled = true,
            size = 12,
            passes = 4,
            new_optimizations = true,
            ignore_opacity = true,
            xray = false, -- Turning off xray makes the frosted glass effect richer
            vibrancy = 0.2,
            contrast = 1.1,
            brightness = 0.9,
            noise = 0.02, -- A tiny bit of noise makes the glassmorphism look highly textured
        },
    },
})

-- #################
-- ### ANIMATIONS ###
-- #################

hl.config({
    animations = {
        enabled = true,
    },
})

-- A highly fluid, modern easing curve (similar to fluent design)
hl.curve("fluent_decel", {
    type = "bezier",
    points = {
        { 0.1, 1 },
        { 0, 1 },
    },
})

hl.curve("easeOutCirc", {
    type = "bezier",
    points = {
        { 0.0, 0.55 },
        { 0.45, 1 },
    },
})

hl.curve("overshot", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.1 },
    },
})

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 6,
    bezier = "default",
})

hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "fluent_decel",
    style = "popin 80%",
})

hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 3,
    bezier = "fluent_decel",
    style = "popin 80%",
})

hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "easeOutCirc",
})

hl.animation({
    leaf = "borderangle",
    enabled = true,
    speed = 50,
    bezier = "linear",
    style = "loop", -- Adds a slow rotating gradient to active borders
})

hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "fluent_decel",
    style = "slidefade 20%",
})

-- ################
-- ### LAYOUTS ###
-- ################

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
})

-- ############
-- ### MISC ###
-- ############

hl.config({
    misc = {
        on_focus_under_fullscreen = 1,
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

-- #############
-- ### INPUT ###
-- #############

hl.config({
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        sensitivity = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

-- ################
-- ### GESTURES ###
-- ################

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

-- ###################
-- ### KEYBINDINGS ###
-- ###################

local mainMod = "SUPER"

-- ALT + TAB
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

-- Programs & Window Management
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("cp ~/Downloads/hyprland.lua ~/.config/hypr/hyprland.lua && hyprctl reload"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("cp ~/lap/hyprland.lua ~/.config/hypr/hyprland.lua && hyprctl reload"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
-- Shuffle Wallpaper and Matugen Theme
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.local/bin/awww-rotate.sh"))

-- Fullscreen (Maximize / 1)
hl.bind(
    mainMod .. " + F",
    hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }),
    { release = true }
)
-- Screen Temperature
hl.bind(mainMod .. " + Kp_Left", hl.dsp.exec_cmd("busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 6500"))
hl.bind(mainMod .. " + Kp_Begin", hl.dsp.exec_cmd("busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 4000"))
hl.bind(mainMod .. " + Kp_Right", hl.dsp.exec_cmd("busctl --user -- set-property rs.wl-gammarelay / rs.wl.gammarelay Temperature q 2500"))

-- Audio / Brightness
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl s +2% && swayosd-client --brightness +2"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 2%- && swayosd-client --brightness -2"))
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume +5"))
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume -5"))
hl.bind("CTRL + ALT + Up", hl.dsp.exec_cmd("swayosd-client --output-volume +5"))
hl.bind("CTRL + ALT + Down", hl.dsp.exec_cmd("swayosd-client --output-volume -5"))

-- Utilities
local locked_mode = false

hl.bind(mainMod .. " + L", function()
    locked_mode = not locked_mode

    if locked_mode then
        -- ENTER LOCKED MODE
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized" }))
        hl.exec_cmd("pkill waybar")

        hl.config({
            general = {
                gaps_in = 0,
                gaps_out = 0,
                border_size = 0,
            }
        })
    else
        -- EXIT LOCKED MODE
        hl.dispatch(hl.dsp.window.fullscreen({ mode = "maximized" }))
        hl.exec_cmd("waybar")

        -- RESTORE ORIGINAL CONFIG
        hl.config({
            general = {
                gaps_in = 6,
                gaps_out = 12,
                border_size = 2,
            }
        })
    end
end)

hl.bind("SUPER + PERIOD", hl.dsp.exec_cmd("sh -c 'wofi-emoji --type'"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("bash -c 'grim -g \"$(slurp)\" - | wl-copy'"))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("~/.config/waybar/scripts/launch.sh"))

-- Workspaces
for i = 1, 9 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mainMod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))

-- Mouse Binds
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ##############################
-- ### WINDOWS AND WORKSPACES ###
-- ##############################

hl.window_rule({
    name = "alacritty",
    match = { class = "^(alacritty)$" },
    opacity = "0.90 0.85",
})

hl.window_rule({
    name = "vlc",
    match = { class = "^(vlc)$" },
    opacity = "1.0 override 1.0 override",
    opaque = true,
})

hl.window_rule({
    name = "all",
    match = { class = ".*" },
    suppress_event = "maximize",
})

-- ############################
-- ### LAYER RULES / BLUR ###
-- ############################

hl.layer_rule({
    match = { namespace = "waybar" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "waybar" },
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = { namespace = "wofi" },
    blur = true,
})

hl.layer_rule({
    match = { namespace = "wofi" },
    ignore_alpha = 0.5,
})
