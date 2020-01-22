#!/bin/bash
#!/usr/bin/env/bash

checkIfPathIsFilled(){
if [ -z $path ]; then 
echo "you have to put a name argument !"
exit 0
 fi 
}
checkIfNameIsFilled(){
if [ -z $name ]; then 
echo "you have to put a name argument !"
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
year=`date +%Y`
month=`date +%m`
day=`date +%d`
hour=`date +%H`
minute=`date +%M`
dateOfSnar=_$year"_"$month"_"$day"_"$hour"_"$minute
_main() {
  backupLogs='logs.txt'
BACKUPFILE=backup-$(date +%m-%d-%Y)
# archive=${1:-$BACKUPFILE}
  IFS=','
while [ "$1" != "" ]; do
    case $1 in
      '-h' | '--help')
        help
        exit 0
         ;;
      '-v' | '--version')
       info
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
      usage
      exit 1
    esac
    shift
done
}
_main "$@"
checkIfPathIsFilled
checkIfNameIsFilled
if [[ -n $inc || -n $full ]]; then
if [[ -n $inc && -n $full ]]; then 
echo "You can't give both arguments for incremental and full backup"

 fi
 if [[ -z $inc && -n $full ]]; then 
echo  $full_interval -e tar -cvzp -f $backupDir/$name"_"$inc$full"_"$dateOfSnar.tar$gzip  $path   >> tasks.data
exit 0 
 fi
 if [[ -n $inc && -z $full ]]; then 
echo -e  $inc_interval tar -cvzp -f $backupDir/$name"_"$inc$full"_"$dateOfSnar.tar$gzip  $path  $typeOfBackup"="$name".snar"  >> tasks.data
exit 0 
 fi
 else
echo "You have to give type of backup"
exit 0
 fi

# sudo tar -xvpzf backup.tar.gz -C /recover 

# sudo crontab -e
 
# sudo tar -cv $name  $backupDir $inc_interval $archive $gzip
 #
exit 0