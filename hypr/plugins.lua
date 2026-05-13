-- hyprbars

hl.config{
  plugin = {
    hyprbars = {
      bar_height = 22,
      bar_color = 0x881e1e2e,
      bar_buttons_alignment = "left",
      bar_part_of_window = true,
      bar_precedence_over_border = false,
      icon_on_hover = true,
    },
  },
}

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(ff4040)",
    fg_color = "rgb(ffffff)",
    size = 13,
    icon = "󰖭",
    action = "hyprctl dispatch killactive",
})

hl.plugin.hyprbars.add_button({
    bg_color = "rgb(ffbb00)",
    fg_color = "rgb(ffffff)",
    size = 13,
    icon = "",
    action = "hyprctl dispatch fullscreen 0",
})
