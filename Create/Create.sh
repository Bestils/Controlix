#!/bin/bash
#!/usr/bin/env/bash
checkIfAnyTimeIsAdded(){
if [ -n $inc ] || [ -n $full ]; then
if [[ -n $inc && -n $full ]]; then 
echo "You can't give both arguments for incremental and full backup"
exit 0 
 fi
 else
echo "You have to give type of backup"
exit 0
 fi
}
checkIfNameIsFilled(){
if [ ! -n $name ]; then 
echo "you have to put a name argument !"
exit 0
 fi 
}
checkIfNameIsFilled(){
if [ ! -n $name ]; then 
echo "you have to put a name argument !"
exit 0
 fi
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
  name=''
  full_interval=''  # format daty 'minuty godziny dni miesiące'
  inc_interval='' 
  path=''
  ext=''
  backupDir=''
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
    $typeOfBackup= "--full-interval"
    full="full"
   shift
    ;;
    --inc-interval=) shift
    inf="inc"
     $typeOfBackup= "--inc-interval"
      inc_interval="--listed-incremental=.snar"
      echo $dateOfSnar
      cat >> incrementalBackupsDates 
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
  echo 'sadda' 
}
checkIfNameIsFilled
checkIfAnyTimeIsAdded
checkIfScriptIsRunning
 #source ./logsCreator.sh -c 
_main "$@"
echo "after main"

# sudo tar -xvpzf backup.tar.gz -C /recover 

# sudo crontab -e

echo tar -cvzp -f $backupDir/$name/$name$inc$full$date.tar$gzip  $path  $inc_interval $full_interval $archive 

# sudo tar -cv $name  $backupDir $inc_interval $archive $gzip
 # source ./logsCreator.sh -r
exit 0