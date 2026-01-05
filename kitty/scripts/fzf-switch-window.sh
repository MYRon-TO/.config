#!/bin/bash
# 获取所有窗口的 JSON 数据
# 解析出：Tab ID, Window ID, 标题, 运行的程序
# 格式化通过 FZF 展示
target=$(kitty @ ls | jq -r '
    .[].tabs[].windows[] 
    | select(.is_focused | not) 
    | "\(.id): [\(.title)] (\(.foreground_processes[0].cmdline[0] // "shell"))"
' | fzf --prompt="🔍 Switch to: " --height=40% --layout=reverse)

# 如果选中了目标，提取 ID 并跳转
if [ -n "$target" ]; then
    window_id=$(echo "$target" | cut -d: -f1)
    kitty @ focus-window --match id:"$window_id"
fi
