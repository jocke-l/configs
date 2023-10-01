#!/bin/bash

export XSECURELOCK_AUTH_BACKGROUND_COLOR=#282A36
export XSECURELOCK_AUTH_FOREGROUND_COLOR=#F8F8F2

export XSECURELOCK_SAVER=~/.config/xsecurelock/saver.sh
export XSECURELOCK_SAVER_DELAY_MS=10

export XSECURELOCK_SHOW_USERNAME=false
export XSECURELOCK_PASSWORD_PROMPT=time

xsecurelock || kill -9 -1
