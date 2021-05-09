#!/bin/bash

#czy powinno być -B G czy -B GB ?
#zweryfikowac czy wykorzystanie tr do kasowania jest dobre!
function getFileSystemsInfo(){
    while read line
        do
            echo -n $line | tr [:blank:] ";" | tr -d "\n"
            echo ";"$Date
        done < <(df -B G -t ext4  | sed '1d' | tr -d 'G' | tr -d '%')
    return 0
}

#pliki i katalogi większe niż 200MB
function getBigFilesInfo(){
    while read line
    do
        echo -n $line | cut -d " " -f 3-8 | tr [:blank:] ";" | tr -d "\n"
        echo ";"$Date
    done < <(find / -type f -size +200M 2>/dev/null | xargs ls -l --block-size=M --time-style=long-iso 2>/dev/null)
    return 0
}

function getBigDirectoriesInfo(){
    while read line
    do
        echo -n $line | cut -d " " -f 1-4 | tr [:blank:] ";" | tr -d "\n"
        echo ";"$Date
    done < <(du -m -t 200M --time --time-style=long-iso  / 2>/dev/null | sort -rh)
    return 0
}