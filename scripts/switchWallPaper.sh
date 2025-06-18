#!/usr/bin/env sh

declare -A Allpaper
count=0
for name in `ls /home/Myron/Pictures/wallpaper/`; do
    Allpaper[$count]=$name
    count=$((count+1))
done

Nowpaper=`swww query | grep -oP "(?<=image: \/home\/Myron\/Pictures\/wallpaper\/).+"`

while true; do
    Newpaper=$(($RANDOM % $count))

    if [ "`echo ${Allpaper[$Newpaper]} | grep -oP "^[^.]*"`" != "`echo $Nowpaper | grep -oP "^[^.]*"`" ]; then
        break
    fi
done

# swww img /home/Myron/Pictures/wallpaper/${Allpaper[$Newpaper]} --transition-type outer --transition-pos any
swww img /home/Myron/Pictures/wallpaper/${Allpaper[$Newpaper]} --transition-type any

# while true; do
#     Newpaper=$(($RANDOM % $count))
#     echo $Newpaper
# done
