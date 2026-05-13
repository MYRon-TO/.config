-- Window rules
hl.window_rule({ match = { class = "pot" }, float = true })
hl.window_rule({ match = { class = "pot" }, move = "5 50" })
hl.window_rule({ match = { title = "Minecraft(.*)" }, float = true })
hl.window_rule({ match = { class = "Krita" }, float = true })
hl.window_rule({ match = { class = "Waydroid(.*)" }, float = true })
hl.window_rule({ name = "float-pot-window", match = { class = "(pot)", title = "(Translator|OCR|PopClip|Screenshot Translate)" }, float = true })

-- Layer rules
hl.layer_rule({
  name = "noctalia",
  match = { namespace = "noctalia-background-.*$" },
  ignore_alpha = 0.5,
  blur = true,
  blur_popups = true,
})
