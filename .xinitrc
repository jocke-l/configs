systemctl --user import-environment DISPLAY

xss-lock -l -- ~/scripts/xsecurelock.sh &

redshift-gtk &

xrdb ~/.Xresources
xbindkeys
xmodmap -e "keycode 51 = backslash bar backslash bar dead_semivoiced_sound"

exec xmonad
