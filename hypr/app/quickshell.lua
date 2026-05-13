-- Quickshell / Noctalia
return {
  setup = function()
    KeyBind(MainMod .. " + Space", Exec("qs -c noctalia-shell ipc call launcher toggle"))
    KeyBind(MainMod .. " + V", Exec("qs -c noctalia-shell ipc call launcher clipboard"))
    KeyBind(MainMod .. " + SHIFT + V", Exec("qs -c noctalia-shell ipc call launcher emoji"))
    KeyBind("XF86AudioRaiseVolume", Exec("qs -c noctalia-shell ipc call volume increase"),
      { repeating = true, locked = true })
    KeyBind("XF86AudioLowerVolume", Exec("qs -c noctalia-shell ipc call volume decrease"),
      { repeating = true, locked = true })
    KeyBind("XF86AudioMute", Exec("qs -c noctalia-shell ipc call volume muteOutput"), { locked = true })
  end
}
