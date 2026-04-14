require("env/local")

ENV = {}

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH

ENV.enable_kitty_smart_splits = ENABLE_KITTY_SPLIT == true

if IS_LINUX then
  ENV.im_select = {
    default_im_select = "keyboard-us",
    default_command = "fcitx5-remote",
  }

  ENV.delta_path = "/usr/bin/delta"

else
  ENV.im_select = {
    default_im_select = "com.apple.keylayout.ABC",
    default_command = "im-select",
  }

  ENV.delta_path = "/opt/homebrew/bin/delta"

end
