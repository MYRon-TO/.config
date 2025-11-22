#!/bin/bash

# 获取当前宽度值（移除可能存在的换行符）
width=$(waydroid prop get persist.waydroid.width | tr -d '\n')

if [[ "$width" == "1920" ]]; then
    waydroid prop set persist.waydroid.height 1920
    waydroid prop set persist.waydroid.width 1080
else
    waydroid prop set persist.waydroid.height 1080
    waydroid prop set persist.waydroid.width 1920
fi

waydroid session stop

# 通常需要重启服务（根据Waydroid实际需求选择）
# systemctl restart waydroid-container  # 如果需要的话
