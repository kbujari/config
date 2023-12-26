#!/usr/bin/env bash

killall -q waybar

while pgrep -x waybar >/dev/null; do sleep 1; done

/usr/bin/waybar --config ~/.config/waybar/config.json
# case $(</proc/sys/kernel/hostname) in
#   "arthur")
#     /usr/bin/waybar --config $HOME/.config/waybar/config-arthur.json
#     ;;
#   "galahad")
#     /usr/bin/waybar --config $HOME/.config/waybar/config-galahad.json
#     ;;
# esac
