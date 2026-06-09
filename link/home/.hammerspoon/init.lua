hs.loadSpoon("SpoonInstall")

spoon.SpoonInstall.repos.PaperWM = {
  url = "https://github.com/mogenson/PaperWM.spoon",
  desc = "PaperWM.spoon repository",
  branch = "release",
}

spoon.SpoonInstall:andUse("PaperWM", {
  repo = "PaperWM",
  config = { screen_margin = 16, window_gap = 2 },
  start = true,
  hotkeys = {
    -- switch to a new focused window in tiled grid
    focus_left           = { { "alt", "cmd" }, "h" },
    focus_right          = { { "alt", "cmd" }, "l" },
    focus_up             = { { "alt", "cmd" }, "k" },
    focus_down           = { { "alt", "cmd" }, "j" },

    -- switch windows by cycling forward/backward
    -- (forward = down or right, backward = up or left)
    focus_prev           = { { "alt", "cmd" }, "up" },
    focus_next           = { { "alt", "cmd" }, "down" },

    -- increase/decrease width
    increase_width       = { { "alt", "cmd" }, "right" },
    decrease_width       = { { "alt", "cmd" }, "left" },

    -- move windows around in tiled grid
    swap_left            = { { "alt", "cmd", "shift" }, "h" },
    swap_right           = { { "alt", "cmd", "shift" }, "l" },
    swap_up              = { { "alt", "cmd", "shift" }, "k" },
    swap_down            = { { "alt", "cmd", "shift" }, "j" },

    -- position and resize focused window
    center_window        = { { "alt", "cmd" }, "c" },
    anchor_window_left   = { { "ctrl", "alt", "cmd" }, "," },
    anchor_window_right  = { { "ctrl", "alt", "cmd" }, "." },
    full_width           = { { "alt", "cmd" }, "f" },
    cycle_width          = { { "alt", "cmd" }, "r" },
    reverse_cycle_width  = { { "ctrl", "alt", "cmd" }, "r" },
    cycle_height         = { { "alt", "cmd", "shift" }, "r" },
    reverse_cycle_height = { { "ctrl", "alt", "cmd", "shift" }, "r" },

    -- move focused window into / out of a column
    slurp_in             = { { "alt", "cmd" }, "i" },
    barf_out             = { { "alt", "cmd" }, "o" },

    -- split screen focused window with left window
    split_screen         = { { "alt", "cmd" }, "s" },

    -- move the focused window into / out of the tiling layer
    toggle_floating      = { { "alt", "cmd", "shift" }, "escape" },
    -- raise all floating windows on top of tiled windows
    focus_floating       = { { "alt", "cmd", "shift" }, "f" },
  }
})
