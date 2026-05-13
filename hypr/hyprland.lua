-- Catppuccin Mocha colors

local theme = require("theme.mocha")
require("utils.keybinding")

-- Environment
require("env")

-- Monitors
require("monitors")
require("layouts.master")

-- Variables
hl.config({

  general = {
    gaps_in = 4,
    gaps_out = 10,
    border_size = 3,
    ["col.active_border"] = theme.lavender,
    ["col.inactive_border"] = 0x881e1e2e,
    resize_on_border = true,
    hover_icon_on_border = true,
  },

  decoration = {
    rounding = 10,
    dim_inactive = true,
    dim_strength = 0.2,
    blur = {
      enabled = true,
      size = 3,
      passes = 2,
      vibrancy = 0.1696,
    },
    shadow = {
      enabled = true,
      range = 8,
      render_power = 3,
      color = 0x88313244,
      color_inactive = 0x33313244,
      offset = "3 3",
      scale = 3,
    },
  },

  misc = {
    animate_mouse_windowdragging = true,
    animate_manual_resizes = true,

    middle_click_paste = false,

    mouse_move_enables_dpms = true,
    key_press_enables_dpms = true,

    font_family = "Sarasa Mono SC",
    vrr = 0,
  },

  cursor = {
    no_hardware_cursors = true,
  },

  xwayland = {
    force_zero_scaling = true,
  },

  ecosystem = {
    no_update_news = true,
  },

  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = false,
      clickfinger_behavior = true,
    },
  },

  gestures = {
    workspace_swipe_distance = 200,
    workspace_swipe_invert = false,
  },

  animations = {
    enabled = true,
  },
})


-- Animations
require("animations")

-- Autostart
require("auto_start")

require("rules")

-- Permissions
hl.permission({
  binary = "/usr/(bin|local/bin)/hyprpm",
  type = "plugin",
  mode = "allow",
})

-- Keybinds
require("keybinds")

-- Plugins
require("plugins")

-- Apps
require("app.pot").setup()
require("app.quickshell").setup()
