#!/bin/bash

#moze jednak lepiej zrobic petle?
#czy nie warto?
function getTotalInfo(){
    loadAverage=`cut -d ' ' -f 1 /proc/loadavg`
    RAMTotal=(`free -m | awk '/Pamięć/{print $2 " " $3 " " $4 " " $5 " " $6 " " $7}'`)
    SWAPTotal=(`free -m | awk '/Wymiana/{print $2 " " $3 " " $4}'`)
    CPUTotal=(`mpstat | awk '/all/{print $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9 " " $10 " " $11 " " $12}' | tr ',' '.'`)
    echo -n $loadAverage";"${RAMTotal[0]}";"${RAMTotal[1]}";"${RAMTotal[2]}";"${RAMTotal[3]}";"${RAMTotal[4]}";"${RAMTotal[5]}";"${SWAPTotal[0]}";"${SWAPTotal[1]}";"${SWAPTotal[2]}";"
    echo -n ${CPUTotal[0]}";"${CPUTotal[1]}";"${CPUTotal[2]}";"${CPUTotal[3]}";"${CPUTotal[4]}";"${CPUTotal[5]}";"${CPUTotal[6]}";"${CPUTotal[7]}";"${CPUTotal[8]}";"${CPUTotal[9]}";"$Date
    return 0
}

function getIOTotalInfo(){
    IOTotal=(`iostat sda -m -d -x | awk '/sda/' | tr ',' '.'`)
    echo -n "/dev/"${IOTotal[0]}";"${IOTotal[2]}";"${IOTotal[8]}";"${IOTotal[20]}";"$Date
    return 0
}

