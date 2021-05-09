#!/bin/bash
#za kazdą tabele odpowiada osobny plik *.sh
#osobna funkcja

#TO DO
    #wypisywanie danych trwa na tyle dlugo
    #ze niektore PIDy w trakcie wykonywania skryptu potrafią zniknac
    #wiec albo zrobic na to obsluge w bash albo w oracle
    #albo pobrac liste pidow tylko, ktore zuzywaja duzo zasobow, trwaja dlugo itd itd

    #jak sensownie obsluzyc to ze PID nie jest unikalny?
        #można dodac timestamp odpalenia skryptu main.sh
    #zrobic obsługę przypadku gdzie plik jest pusty lub są puste wiersze w nim


#importuje funkcje
source functions/Processes.sh
source functions/TotalValues.sh
source functions/FileSystems.sh
source functions/Hardware.sh

#pobieram czas startu skryptu
Date=`date "+%d/%m/%Y %X"`
FileNameSuffix=`date "+%d_%m_%Y_%H_%M"`

#pobieram listę wszystkich PIDów
ListOfPIDs=(`ps -ax -o pid --no-header`)

#do funkcji nie potrzeba dodawać argumentów
#bo source jakby przenosi ciało funkcji do przestrzeni nazw pliku main.sh
#dodane tylko dla czytelności!!!
getProcesses $Date ${ListOfPIDs[*]}>processes_ps_$FileNameSuffix.csv&
ProcessesPID=$!

getProcessesCPU $Date ${ListOfPIDs[*]}>processes_CPU_$FileNameSuffix.csv&
CPUPID=$!

getProcessesRAM $Date ${ListOfPIDs[*]}>processes_RAM_$FileNameSuffix.csv&
RAMPID=$!

getProcessesSWAP $Date ${ListOfPIDs[*]}>processes_SWAP_$FileNameSuffix.csv&
SWAPPID=$!

getProcessesIO $Date>processes_IO_$FileNameSuffix.csv&
IOProcessesPID=$!

getTotalInfo $Date>TotalValues_$FileNameSuffix.csv&
TotalValuesPID=$!

getFileSystemsInfo $Date>FileSystems_$FileNameSuffix.csv&
FSPID=$!

getHardwareInfo $Date>Hardware_$FileNameSuffix.csv&
HWPID=$!

getIOTotalInfo $Date>IOTotal_$FileNameSuffix.csv&
IOTotalPID=$!

getBigFilesInfo $Date>BigFiles_$FileNameSuffix.csv&
BigFilesPID=$!

getBigDirectoriesInfo $Date>BigDirectories_$FileNameSuffix.csv&
BigDirectoriesPID=$!

#czekam aż wszystkie watki wygenerują csv a potem przenosze pliki do katalogu
#z ktorego baza pobierze pliki CSV

wait $ProcessesPID $CPUPID $RAMPID $SWAPPID $TotalValuesPID $FSPID $HWPID $IOTotalPID $IOProcessesPID $BigFilesPID $BigDirectoriesPID
#echo "przenosze pliki do katalogu docelowego"
mv processes_ps_$FileNameSuffix.csv processes_CPU_$FileNameSuffix.csv processes_RAM_$FileNameSuffix.csv processes_SWAP_$FileNameSuffix.csv TotalValues_$FileNameSuffix.csv FileSystems_$FileNameSuffix.csv Hardware_$FileNameSuffix.csv IOTotal_$FileNameSuffix.csv processes_IO_$FileNameSuffix.csv BigFiles_$FileNameSuffix.csv BigDirectories_$FileNameSuffix.csv to_load