MainMod = "SUPER"

function Exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

function Dispatch(cmd)
  return Exec("hyprctl dispatch " .. cmd)
end

function KeyBind(keys, dispatcher, flags)
  hl.bind(keys, dispatcher, flags)
end

function HKeyBind(keys, hypr_dispatch, flags)
  KeyBind(keys, Dispatch(hypr_dispatch), flags)
end
