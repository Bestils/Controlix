#!/bin/bash
#!/usr/bin/env/bash

checkIfPathIsFilled(){
if [ -z $path ]; then 
echo "you have to put a name argument !"
./logsCreator.sh -r
exit 0
 fi 
}
checkIfNameIsFilled(){
if [ -z $name ]; then 
echo "you have to put a name argument !"
./logsCreator.sh -r
exit 0
 fi
}
usage()
{
    echo "usage: check -h to see help"
}
checkIfNumberIsADigit(){
 if [[ ! $number =~ [[:digit:]]+ ]];
        then
          echo "$typeOfBackup przyjmuje tylko wartość w sekundach"
          exit 1
        fi 
}

_main() {
  backupLogs='logs.txt'
BACKUPFILE=backup-$(date +%m-%d-%Y)
# archive=${1:-$BACKUPFILE}
  IFS=','
while [ "$1" != "" ]; do
    case $1 in
      '-h' | '--help')
        help
        ./logsCreator.sh -r
        exit 0
         ;;
      '-v' | '--version')
       info
       ./logsCreator.sh -r
        exit 0 
        ;;
      --ext=) shift 
      ext=$@
     extData= "find ./ -name $@ + |"
      ;;
      --name=)  shift
    name="$1"
      ;;
      --path=) shift
      path=$1
    ;;
    --full-interval=)
    full_interval=$1
    typeOfBackup="--full-interval"
    full="full"
   shift
    ;;
    --inc-interval=) shift
    inc="inc"
     typeOfBackup="--inc-interval"
      inc_interval=$1
    ;;
    --gzip) 
    gzip=".gz";;
    --backup-dir=) shift
    backupDir=$1
    ;;
      * )   
      echo $1 "doesn't exist"
      usage
      ./logsCreator.sh -r
      exit 1
    esac
    shift
done
}
_main "$@"
checkIfPathIsFilled
checkIfNameIsFilled
 if [-n $execute ];

 then
if [[ -n $inc || -n $full ]]; then
if [[ -n $inc && -n $full ]]; then 
echo "You can't give both arguments for incremental and full backup"

 fi

 if [[ -z $inc && -n $full ]]; then 
 tar -cvzp -f $backupDir/$name"_"$inc$full"_"$dateOfSnar.tar$gzip  $path -f $backupDir/$name"_"$inc$fu   >> tasks.data
./logsCreator.sh -r -f $backupDir/$name"_"$inc$fu
echo 1
exit 0 
 fi
 if [[ -n $inc && -z $full ]]; then 
 tar -cvzp -f $backupDir/$name"_"$inc$full"_"$dateOfSnar.tar$gzip  $path  $typeOfBackup"="$name".snar"  >> tasks.data
./logsCreator.sh -r

exit 0 
 fi
 else
echo "You have to give type of backup"
./logsCreator.sh -r
exit 0
 fi
else 
echo -e $full_interval  $inc_interval  $@ 
echo "task created !"
./logsCreator.sh -r
exit 0




fi 
echo chuj
exit 0