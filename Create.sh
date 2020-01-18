#!/bin/bash
#!/usr/bin/env/bash
checkIfAnyTimeIsAdded(){
if [ -n $inc] || [ -n $full]; then
echo a
if [ -n $inc && -n $full]; then 
echo "You can't give both arguments for incremental and full backup"
exit 0 
 fi
 else
echo "You have to give type of backup"
exit 0
 fi
}
checkIfNameIsFilled(){
if [! -n $name] 
echo "you have to put a name argument !"
exit 0
 fi
}
checkIfScriptIsRunning(){
if [ -f $backupLogs ]; then
    echo $backupLogs exist. Check the logs what is wrong
     exit 0
fi
}
_main() {
  backupLogs='logs.txt'
BACKUPFILE=backup-$(date +%m-%d-%Y)
# archive=${1:-$BACKUPFILE}
  name=''
  full_interval='' # format daty 'minuty godziny dni miesiące'
  inc_interval=''
  path=''
  ext=''
  backupDir=''
  IFS=','
while [ "$1" != "" ]; do
    case $1 in
      '-h' | '--help')
        help
        exit 0 ;;
        
      '-v' | '--version')
       info
        exit 0 
        ;;

      --ext=) shift 
      ext=$@
     extData= find ./ -name "*.php" -o -name "*.html" + | 
      ;;

      --name=)  shift
    name= "-filename=$1"
      ;;

      --path=) shift
      path=$1
    ;;

    --full-interval=)
    cron  
   shift
      
    ;;
    --inc-interval=) shift
      inc_interval= --listed-incremental=data.snar
    ;;
    --gzip) 
    gzip=true;;
    --backup-dir=) shift
    backupDir="--file $1"
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
 sh ./logsCreator.sh -c 
_main "$@"
echo "after main"


if [ -n $gzip ]; then 
echo sudo tar -cvpzf --listed-incremental=data.snar backup.tar.gz 
else
echo sudo tar -cvpf --listed-incremental=data.snar backup.tar
fi

# sudo tar -xvpzf backup.tar.gz -C /recover 

# sudo crontab -e

 echo $extData tar $name $gzip $backupDir $inc_interval -file "$archive.tar"$gzip


exit 0
