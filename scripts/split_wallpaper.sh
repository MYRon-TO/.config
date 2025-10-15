#!/usr/bin/env bash
# split_wallpaper.sh <input_image> <output_dir>
# 依赖: hyprctl, jq, ImageMagick 7 (magick), swww (可选)

set -e

INPUT="$1"
OUTDIR="$2"

if [[ -z "$INPUT" || -z "$OUTDIR" ]]; then
    echo "用法: $0 <壁纸文件> <输出目录>"
    exit 1
fi

mkdir -p "$OUTDIR"

# 读取 monitors 信息
MON_JSON=$(hyprctl monitors -j)

# 提取逻辑坐标、尺寸和旋转信息
readarray -t MONS < <(echo "$MON_JSON" | jq -r '.[] | "\(.name) \(.x) \(.y) \(.width) \(.height) \(.scale) \(.transform)"')

# 计算总画布逻辑边界，考虑旋转后的逻辑宽高
MIN_X=0; MIN_Y=0; MAX_X=0; MAX_Y=0
for M in "${MONS[@]}"; do
    read -r NAME X Y W H SCALE TRANSFORM <<<"$M"
    LOG_W=$(awk "BEGIN {print $W / $SCALE}")
    LOG_H=$(awk "BEGIN {print $H / $SCALE}")

    # 旋转后宽高交换
    if [[ $TRANSFORM == 1 || $TRANSFORM == 3 ]]; then
        USE_W=$LOG_H
        USE_H=$LOG_W
    else
        USE_W=$LOG_W
        USE_H=$LOG_H
    fi

    (( X < MIN_X )) && MIN_X=$X
    (( Y < MIN_Y )) && MIN_Y=$Y
    (( X+USE_W > MAX_X )) && MAX_X=$((X+USE_W))
    (( Y+USE_H > MAX_Y )) && MAX_Y=$((Y+USE_H))
done

TOTAL_W=$((MAX_X - MIN_X))
TOTAL_H=$((MAX_Y - MIN_Y))

echo "逻辑画布大小（考虑旋转）: ${TOTAL_W}x${TOTAL_H}"

# 生成总画布裁切后的图
TMPIMG="$OUTDIR/_wallpaper_canvas.png"
magick "$INPUT" -resize ${TOTAL_W}x${TOTAL_H}^ -gravity center -extent ${TOTAL_W}x${TOTAL_H} "$TMPIMG"

# 针对每个输出裁切并保存，考虑旋转
for M in "${MONS[@]}"; do
    read -r NAME X Y W H SCALE TRANSFORM <<<"$M"
    LOG_W=$(awk "BEGIN {print $W / $SCALE}")
    LOG_H=$(awk "BEGIN {print $H / $SCALE}")
    OUT="$OUTDIR/wall_${NAME}.png"

    if [[ $TRANSFORM == 1 || $TRANSFORM == 3 ]]; then
        CROP_W=$LOG_H
        CROP_H=$LOG_W
        ROTATE=$((TRANSFORM * 90))
        # 修正裁切坐标，使旋转后的竖屏位置正确
        CROP_X=$((X - MIN_X))
        CROP_Y=$((Y - MIN_Y))
    else
        CROP_W=$LOG_W
        CROP_H=$LOG_H
        ROTATE=0
        CROP_X=$((X - MIN_X))
        CROP_Y=$((Y - MIN_Y))
    fi

    echo "裁切 $NAME: ${CROP_W}x${CROP_H}+${CROP_X}+${CROP_Y} (旋转: $ROTATE°) → $OUT"
    magick "$TMPIMG" -crop ${CROP_W}x${CROP_H}+${CROP_X}+${CROP_Y} +repage "$OUT"
    swww img -o "$NAME" "$OUT"
done

# rm "$TMPIMG"
echo "完成，输出在 $OUTDIR"
