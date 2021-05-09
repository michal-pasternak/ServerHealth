#!/bin/bash

function getHardwareInfo(){
    CPU=`dmidecode -t processor | awk '/Version/{print $1 " " $2 " "$3 " "$4 " "$6 " " $7}'`
    CPU+=" "`dmidecode -t processor | awk '/Current Speed/{print $1 " " $2 " " $3 " " $4}'`
    
    RAM=`dmidecode -t memory | awk '/Size/{print $1 " " $2 " "$3}'`
    RAM=`echo $RAM | cut -d " " -f 1-3`
    
    RAM+=" "`dmidecode -t memory | awk '/Configured Memory Speed:/{print $1 " " $2 " "$3 " " $4 " " $5}'`
    RAM=`echo $RAM | cut -d " " -f 1-8`
    
    SWAP=`free -m | awk '/Wymiana/{print $2}'`" MB"

    Disk=`fdisk -l | grep "Dysk /dev/sd" | cut -d " " -f 3`" GB"

    #sprawdzam czy dysk jest typu SSD
    #0 to SSD
    #1 to HDD
    DiskType=`lsblk -d -o name,rota | awk '/sda/{print $2}'`
    if [ $((DiskType)) -eq 0 ]
    then
        DiskType="SSD"
    else
        DiskType="HDD"
    fi

    echo $CPU";"$RAM";"$SWAP";"$Disk";"$DiskType";"$Date
    return 0
}

