#!/bin/bash

export MAGICK_OCL_DEVICE=true

magick <(scrot -) \
    -scale 25% \
    -blur 0x10 \
    -resize 400%  - | \
        feh --window-id "${XSCREENSAVER_WINDOW}" -
