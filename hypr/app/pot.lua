-- Pot
return {
  setup = function()
    KeyBind(MainMod .. " + T", Exec([[curl "127.0.0.1:60828/input_translate"]]))
    KeyBind(MainMod .. " + SHIFT + T", Exec([[wl-paste | curl -s -X POST "127.0.0.1:60828" -d @-]]))
    KeyBind(MainMod .. " + O",
      Exec(
        [[grim -g "$(slurp)" ~/.cache/com.pot-app.desktop/pot_screenshot_cut.png && curl "127.0.0.1:60828/ocr_recognize?screenshot=false"]]))
    KeyBind(MainMod .. " + SHIFT + O",
      Exec(
        [[grim -g "$(slurp)" ~/.cache/com.pot-app.desktop/pot_screenshot_cut.png && curl "127.0.0.1:60828/ocr_translate?screenshot=false"]]))
  end
}
