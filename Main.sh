#!/bin/bash
#!/usr/bin/env/bash
help() {
 cat help.txt
}
info() {
  echo '3.14 COPYRIGHT: PATRYK KIRSZENSTEIN LICENSE: MIT'
}
usage()
{
    echo "usage: sysinfo_page [[[-f file ] [-i]] | [-h]]"
}
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
_main() {
  LogFileNameAndDest='logs.txt'

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
     extData= "find ./someDir -name "*.php" -o -name "*.html" + | "
      ;;

      --name=)  shift
    name=$1
      ;;

      --path=) shift
      path=$1
    ;;

    --full-interval=)
   shift
      path=$1
    ;;
    --inc-interval=) shift
      path=$1
    ;;
    --gzip) 
    gzip=true;;
    --backup-dir=) shift
    backupDir="--file $1"
    ;;
 --inc-interval=) shift
    ;;
      * )   
      usage
      exit 1
    esac
    shift
done
  echo 'sadda' 
}
 sh ./logsCreator.sh -c -h
_main "$@"
echo "after main"
echo $name
echo $gzip
echo $backupDir

if [ -n $gzip ]; then 
echo sudo tar -cvpzf --listed-incremental=data.snar backup.tar.gz 
else
echo sudo tar -cvpf --listed-incremental=data.snar backup.tar
fi

# sudo tar -xvpzf backup.tar.gz -C /recover 

# sudo crontab -e

 echo $extData tar $name $gzip $backupDir  -file "$archive.tar"


exit 0

