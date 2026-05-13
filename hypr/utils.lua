local mainMod = "SUPER"

local function exec(cmd)
  return hl.dsp.exec_cmd(cmd)
end

local function dispatch(cmd)
  return exec("hyprctl dispatch " .. cmd)
end

local function bind(keys, dispatcher, flags)
  hl.bind(keys, dispatcher, flags)
end

local function hbind(keys, hypr_dispatch, flags)
  bind(keys, dispatch(hypr_dispatch), flags)
end

