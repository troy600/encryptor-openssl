#!/usr/bin/bash

key="$(cat ~/.config/keyfile.key)"

decrypt() {
    openssl enc -d -k $key -in "$1" -out "$2" -aes-256-ecb 2> temp.txt
    echo "$?"
    rm temp -f
}

aes() {
    openssl enc -e -k $key -in "$1" -out "$2" -aes-256-ecb 2> temp.txt
    echo " sucess i think"
    echo "$1 encrypted to $2" 
    rm temp.txt
}

help() {
    printf "usage: 
required:
    -e           for encryption method
    -d           to decrypt method
    -out         output file


full command:
    encryptor.sh -d 'filename' -out 'output file'
    encryptor.sh -e 'filename' -out 'output filename'
    encryptor.sh -dr 'encrypted file' -out 'out file(will deleted after read by vim)'
    encryptor.sh -dd 'directory/'
    encryptor.sh -ed 'directory/'



Copyright Cyrus Troy Bazar and the DSA students
    "
}

main() {
    case "$1" in
        "-d")
            if [[ $3 == -out ]]; then
                if [[ $4 == $2 ]]; then
                    decrypt "$2" "decrypted.$4"
                else
                    decrypt "$2" "$4"
                fi
            else
                echo "error. fuck u type -out "file here" first"
                help
            fi
            ;;

        "-e")
            if [[ $3 == -out ]]; then
                if [[ $2 == $4 ]]; then
                    aes "$2" "$4.enc"
                else
                    aes "$2" "$4"
                fi
            else
                echo "error. fuck you typr -out "filename here" first."
                help
            fi
            ;;

        "-ed")
            for f in $2/*; do
                files="$f"
                encfile="$f.aes"
                aes "$files" "$encfile"
                printf "$files decrypted"
            done
            ;;

        "-dr")
            if [[ $3 == -out ]]; then
                if [[ $4 == $2 ]]; then
                    decrypt "$2" "decrypted.$4"
                    vim "decrypted.$4"
                    rm "decryted.$4"
                else
                    decrypt "$2" "$4"
                    vim "$4"
                    rm "$4"
                fi
            else
                echo "error. fuck u type -out "file here" first"
                help
            fi
            ;;

        "-dd")
            for files in $2/*.aes; do
                todecrypt="$files"
                thefile=$(echo $files | sed -E 's/.aes//g')
                decrypt "$todecrypt" "$thefile"
            done
            ;;

        "-help")
            help
            ;;

        *)
            help
    esac
}



main $1 "$2" $3 "$4"
