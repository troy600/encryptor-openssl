#!/usr/bin/bash

#Variables by default
Filepath="file"

######

ErrorNoFile() {
    echo "File: $1 not found"
}

RofiFile() {
    ls | rofi -dmenu -p "Choose a file to encrypt"
}

main() {
    cat $1
}

main $(RofiFile)
