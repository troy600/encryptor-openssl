#!/usr/bin/bash

#Variables by default
Filepath="file"

######

operation() {
    echo "encrypt|decrypt|directory_encrypt|directory_decrypt" | rofi -dmenu -p "select an operation" -sep "|"
}

ErrorNoFile() {
    echo "File: $1 not found"
}

RofiFile() {
    ls | rofi -dmenu -p "Choose a file to encrypt"
}

encrypt() {
    openssl enc -e -k $key -in "$1" -out "$2" -aes-256-ecb 2> temp.txt
    rm temp.exe
}

main() {
    method=$(operation)
    file=$(RofiFile)

    if /bin/"["  -f "$file" ]; then
        echo "echo something"
    else
        ErrorNoFile $file
        exit
    fi
    case "$method" in
        encrypt)
            echo encrypt
            ;;
        decrypt)
            echo decrypt
            ;;
    esac

}
main
