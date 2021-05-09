#!/bin/bash
#plik zawiera funkcje, ktore pobieraja dane PIDow

#moze lepiej pobrac raz dane
#a potem petla while lub for przeiterowac przez wynik?
#moze bedzie szybciej?!

function getProcesses(){
    processFields=("pid" "ppid" "ucomm" "command" "user" "uid" "group" "gid" "state" "lstart" "etime" "nice" "pri" "tty" )
    for i in ${ListOfPIDs[*]}
        do
            for j in ${processFields[*]}
                do
                    cell=`ps -p $i -o $j --no-header`";"
                    echo -n $cell
                done
            echo -n $Date
            printf "\n" 
        done
    return 0
}

function getProcessesCPU(){
    processFields=("pid" "%cpu" "cputime")
    for i in ${ListOfPIDs[*]}
        do
            for j in ${processFields[*]}
                do
                    cell=`ps -p $i -o $j --no-header`";"
                    echo -n $cell
                done
            echo -n $Date
            printf "\n" 
        done
    return 0
}

function getProcessesRAM(){
    processFields=("pid" "%mem")
    for i in ${ListOfPIDs[*]}
        do
            for j in ${processFields[*]}
                do
                    cell=`ps -p $i -o $j --no-header`";"
                    echo -n $cell
                done
            echo -n $Date
            printf "\n" 
        done
    return 0
}

#generuje plik CSV tylko jeśli ilosc wykorzystanego jest wieksza od 0, greater than
function getProcessesSWAP(){
    for i in ${ListOfPIDs[*]}
        do
            VmSwap=`awk '/VmSwap/{print $2}' /proc/$i/status 2>/dev/null`
            if [ $((VmSwap)) -gt 0 ]
                then
                    echo $i";"$VmSwap";"$Date
            fi
            unset VmSwap
        done
    return 0
}

function getProcessesIO(){
    while read line
    do
        echo -n $line | cut -d " " -f 3-5 | tr [:blank:] ";" | tr -d "\n" | tr ',' '.'
        echo ";"$Date
    done < <(pidstat -d | sed '1,3d')
    return 0
}