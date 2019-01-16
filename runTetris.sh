#!/bin/bash
gnatmake ./tetris.adb
stty -echo
tput civis
./tetris
stty echo
tput cnorm
