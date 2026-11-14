hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.83, 0 }, { 0.17, 1 } } })
hl.curve("easeInOutSpring", { type = "spring", mass = 1, stiffness = 500, dampening = 100 })

hl.animation({ leaf = "windowsIn", enabled = true, speed = 5, spring = "default", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 5, spring = "default", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, spring = "default" })

-- hl.animation({ leaf = "fade", enabled = true, speed = 7, spring = "easeInOutSpring" })
-- hl.animation({ leaf = "fadeIn", enabled = true, speed = 7, spring = "easeInOutSpring" })
-- hl.animation({ leaf = "fadeOut", enabled = true, speed = 7, spring = "default" })
-- hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 7, spring = "default" })
-- hl.animation({ leaf = "fadeShadow", enabled = true, speed = 7, spring = "default" })
-- hl.animation({ leaf = "fadeDim", enabled = true, speed = 7, spring = "easeInOutSpring" })
-- hl.animation({ leaf = "fadeGlow", enabled = true, speed = 7, spring = "easeInOutSpring" })

hl.animation({ leaf = "border", enabled = true, speed = 3, spring = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, spring = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "easeInOutCirc", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 6, bezier = "easeInOutCirc", style = "slide" })
