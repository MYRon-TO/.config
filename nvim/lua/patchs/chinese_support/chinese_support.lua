Switch_Input_Method = {}
Switch_Input_Method.is_fcitx = false
local SIM = Switch_Input_Method

Switch_Input_Method.start = function(is_fcitx)
  SIM.is_fcitx = is_fcitx
  if SIM.is_fcitx then
    SIM.ToChinese = function()
      os.execute("fcitx5-remote -o")
    end

    SIM.ToEnglish = function()
      os.execute("fcitx5-remote -c")
    end

    SIM.IsChinese = function()
      return tonumber(io.popen("fcitx5-remote"):read("*all")) == 2
    end
  else
    SIM.ToChinese = function()
      os.execute("im-select com.sogou.inputmethod.sogou.pinyin")
    end

    SIM.ToEnglish = function()
      os.execute("im-select com.apple.keylayout.ABC")
    end

    SIM.IsChinese = function()
      return string.find(io.popen("im-select"):read("*all"), "sogou")
    end
  end
end

return SIM
