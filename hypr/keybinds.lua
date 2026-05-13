KeyBind(MainMod .. " + SHIFT + Q", hl.dsp.window.close())
KeyBind(MainMod .. " + SHIFT + M", hl.dsp.exit())

-- Quick launch
KeyBind(MainMod .. " + T", Exec("kitty"))

-- Focus
for _, v in ipairs({ {"left", "l"}, {"right", "r"}, {"up", "u"}, {"down", "d"}, {"h", "l"}, {"l", "r"}, {"k", "u"}, {"j", "d"} }) do
  KeyBind(MainMod .. " + " .. v[1], hl.dsp.focus({ direction = v[2] }))
end

-- Move windows
for _, v in ipairs({ {"left", "l"}, {"right", "r"}, {"up", "u"}, {"down", "d"}, {"h", "l"}, {"l", "r"}, {"k", "u"}, {"j", "d"} }) do
  KeyBind(MainMod .. " + SHIFT + " .. v[1], hl.dsp.window.move({ direction = v[2] }))
end

-- Workspace movement
KeyBind(MainMod .. " + CTRL + j", hl.dsp.focus({ workspace = "-1" }))
KeyBind(MainMod .. " + CTRL + k", hl.dsp.focus({ workspace = "+1" }))
KeyBind(MainMod .. " + CTRL + h", hl.dsp.window.move({ workspace = "-1" }))
KeyBind(MainMod .. " + CTRL + l", hl.dsp.window.move({ workspace = "+1" }))

for i = 1, 10 do
  local key = i == 10 and "0" or tostring(i)
  KeyBind(MainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  KeyBind(MainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll through existing workspaces
KeyBind(MainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
KeyBind(MainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e+1" }))

-- Mouse move/resize
KeyBind(MainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
KeyBind(MainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Resize submap
KeyBind(MainMod .. " + SHIFT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  KeyBind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  KeyBind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  KeyBind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  KeyBind("down", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  KeyBind("h", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
  KeyBind("l", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
  KeyBind("k", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  KeyBind("j", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
  KeyBind("Escape", hl.dsp.submap("reset"))
end)

-- Fullscreen / floating / special workspace
KeyBind(MainMod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
KeyBind(MainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
KeyBind(MainMod .. " + G", hl.dsp.window.float({ action = "toggle" }))
KeyBind(MainMod .. " + P", hl.dsp.workspace.toggle_special())
KeyBind(MainMod .. " + SHIFT + P", hl.dsp.window.move({ workspace = "special" }))

-- Media / brightness
KeyBind("XF86AudioRaiseVolume", Exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
KeyBind("XF86AudioLowerVolume", Exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })
KeyBind("XF86MonBrightnessUp", Exec("brightnessctl -s +5%"))
KeyBind("XF86MonBrightnessDown", Exec("brightnessctl -s 5%-"))

-- Screenshots
KeyBind("Print", Exec([[slurp | grim -g - - | wl-copy]]))
KeyBind("SHIFT + Print", Exec([[grim - | wl-copy]]))
