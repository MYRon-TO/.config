#!/bin/bash

# transout=$(crow -t zh-CN $(wl-paste -p) -b)
transout=$(crow -t zh-CN $(wl-paste -p))
notify-send "$transout"
