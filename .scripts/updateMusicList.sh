#!/usr/bin/env sh

IFS=$'\n'
echo -n "" > /home/Myron/Music/.playlist
for i in `ls /home/Myron/Music/`
do
    if [ ! -d "/home/Myron/Music/$i" ]; then
        echo "/home/Myron/Music/${i}" >> /home/Myron/Music/.playlist
    fi
done
