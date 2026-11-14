spoon.SpoonInstall.repos.PaperWM = {
  url = "https://github.com/mogenson/PaperWM.spoon",
  desc = "PaperWM.spoon repository",
  branch = "release",
}



spoon.SpoonInstall:andUse("PaperWM", {
  repo = "PaperWM",
  config = {
    screen_margin = 16,
    window_gap = 2,
    swipe_fingers = 0
  },
  start = true,
  fn = function(PaperWM)
    -- PaperWM:bindHotkeys(PaperWM.default_hotkeys)

    -- 用 ⌘ + Enter 进入 modal layer
    local modal = hs.hotkey.modal.new({ "cmd" }, "`")

    local actions = PaperWM.actions.actions()

    local swipe_enabled = false

    local function enableSwipe()
      if swipe_enabled then return end

      PaperWM.swipe_fingers = 2

      -- 直接启动 PaperWM 的内部 swipe handler
      PaperWM.events.Swipe:start(
        PaperWM.swipe_fingers,
        PaperWM.events.swipeHandler(PaperWM)
      )

      swipe_enabled = true
    end

    local function disableSwipe()
      if not swipe_enabled then return end

      PaperWM.events.Swipe:stop()
      PaperWM.swipe_fingers = 0

      swipe_enabled = false
    end

    -- switch to a new focused window in tiled grid
    modal:bind({}, "h", nil, actions.focus_left)
    modal:bind({}, "j", nil, actions.focus_down)
    modal:bind({}, "k", nil, actions.focus_up)
    modal:bind({}, "l", nil, actions.focus_right)

    -- switch windows by cycling forward/backward
    -- (forward = down or right, backward = up or left)
    modal:bind({}, "up", nil, actions.focus_prev)
    modal:bind({}, "down", nil, actions.focus_next)

    -- increase/decrease width
    modal:bind({}, "left", nil, actions.increase_width)
    modal:bind({}, "right", nil, actions.decrease_width)

    -- move windows around in tiled grid
    modal:bind({ "shift" }, "h", nil, actions.swap_left)
    modal:bind({ "shift" }, "j", nil, actions.swap_down)
    modal:bind({ "shift" }, "k", nil, actions.swap_up)
    modal:bind({ "shift" }, "l", nil, actions.swap_right)

    -- position and resize focused window
    modal:bind({}, "c", nil, actions.center_window)
    modal:bind({}, "f", nil, actions.full_width)
    modal:bind({}, "r", nil, actions.cycle_width)
    modal:bind({ "shift" }, "r", nil, actions.reverse_cycle_width)
    modal:bind({}, "t", nil, actions.cycle_height)
    modal:bind({ "shift" }, "t", nil, actions.reverse_cycle_height)
    modal:bind({ "cmd" }, "left", nil, actions.anchor_window_left)
    modal:bind({ "cmd" }, "right", nil, actions.anchor_window_right)

    -- move focused window into / out of a column
    modal:bind({}, "i", nil, actions.slurp_in)
    modal:bind({}, "o", nil, actions.barf_out)

    -- split screen focused window with left window
    modal:bind({}, "s", nil, actions.split_screen)

    -- move the focused window into / out of the tiling layer
    modal:bind({ "cmd" }, "g", nil, actions.toggle_floating)

    -- raise all floating windows on top of tiled windows
    -- modal:bind({ "cmd" }, "f", nil, actions.raise_floating)

    modal:bind({}, "escape", nil, function()
      modal:exit()
    end)

    function modal:entered()
      enableSwipe()
      hs.alert.show("PaperWM mode")
    end

    function modal:exited()
      disableSwipe()
      hs.alert.closeAll()
    end
  end
})
