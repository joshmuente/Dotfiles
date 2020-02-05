#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"

### Options ###
power_off=""
reboot=""
lock=""
suspend="鈴"
log_out=""
# Variable passed to rofi
options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
        #promptmenu --yes-command "systemctl poweroff" --query "Shutdown?"
        systemctl poweroff
        ;;
    $reboot)
        #promptmenu --yes-command "systemctl reboot" --query "Reboot?"
        ;;
    $lock)
        dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Pause; swaylock; dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Play
        ;;
    $suspend)
        amixer set Master mute
        systemctl suspend
        ;;
    $log_out)
        swaymsg exit
        ;;
esac

