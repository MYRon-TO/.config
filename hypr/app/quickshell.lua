-- Quickshell / Noctalia
return {
  setup = function()
    KeyBind(MainMod .. " + Space", Exec("noctalia msg panel-toggle launcher"))
    KeyBind(MainMod .. " + V", Exec("noctalia msg panel-toggle clipboard"))
    KeyBind(MainMod .. " + SHIFT + V", Exec("noctalia msg panel-toggle launcher /emo"))
    KeyBind(MainMod .. " + C", Exec("noctalia msg panel-toggle launcher /calc"))
    KeyBind(MainMod .. " + SHIFT + C", Exec("noctalia msg panel-toggle launcher /tr"))
    KeyBind("XF86AudioRaiseVolume", Exec("noctalia msg volume-up"),
      { repeating = true, locked = true })
    KeyBind("XF86AudioLowerVolume", Exec("noctalia msg volume-down"),
      { repeating = true, locked = true })
    KeyBind("XF86AudioMute", Exec("noctalia msg volume-mute"), { locked = true })
  end
}
