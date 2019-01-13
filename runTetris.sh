#!/bin/bash
stty -echo
tput civis
./tetris
stty echo
tput cnorm
