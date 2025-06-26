require("env/not_to_sysnc")

ENV = {}

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

if IS_LINUX then
  ENV.im_select = {
    default_im_select = "keyboard-us",
    default_command = "fcitx5-remote",
  }

  ENV.delta_path = "/usr/bin/delta"

  ENV.rime_shared_data_dir = "/usr/share/rime-data"
else
  ENV.im_select = {
    default_im_select = "com.apple.keylayout.ABC",
    default_command = "im-select",
  }

  ENV.delta_path = "/opt/homebrew/bin/delta"

  ENV.rime_shared_data_dir = "/Library/Input Methods/Squirrel.app/Contents/SharedSupport"
end
