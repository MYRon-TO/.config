#!/bin/bash
# 获取当前音量并更新 EWW 变量
current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n1)
eww update volume="$current_volume%"
