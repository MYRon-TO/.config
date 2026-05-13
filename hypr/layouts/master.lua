hl.config({

  general = {
    layout = "master",
  },

  master = {

    allow_small_split = true,
    mfact = 0.5,

    new_status = "inherit",
    new_on_top = true,

    orientation = "left",

    drop_at_cursor = true,
  },

})

local dsp = hl.dsp.layout

KeyBind(MainMod .. "+ S", dsp("swapwithmaster master"))
KeyBind(MainMod .. "+ M", dsp("focusmaster auto"))
KeyBind(MainMod .. "+ A", dsp("addmaster"))
KeyBind(MainMod .. "+ D", dsp("removemaster"))

KeyBind(MainMod .. "+ Tab",dsp("rollnext"))
KeyBind(MainMod .. "+ SHIFT + Tab",dsp("rollprev"))
