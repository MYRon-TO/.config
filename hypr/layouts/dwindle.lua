hl.config({

  general = {
    layout = "dwindle",
  },

  dwindle = {
    -- pseudotile = true, # 不存在
    preserve_split = true,
  },
})

KeyBind(MainMod .. " + R", hl.dsp.layout("togglesplit"))

