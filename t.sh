#!/bin/bash

#!/usr/bin/env bash
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

_main() {
BACKUPFILE=backup-$(date +%m-%d-%Y)
# archive=${1:-$BACKUPFILE}
  name=''
  full_interval='' # format daty 'minuty godziny dni miesiące'
  inc_interval=''
  path=''
  gzip= 'false'
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
        exit 0 ;;

    '--name=')
shift
;;
        '--date=')
        shift
        ;;
      
        '--backup-dir=')
shift
;;
      
        '--out-dir=')
        shift
        ;;
      
    esac
    shift
done
  echo 'sadda' 
  # if [[ $inc_interval != '' ]]
  # then
  #   script_location=$(find $HOME -name execIncrementalBackup.sh)
  #   crontab -l > cronplik
  #   echo "*/a */b */c */d * ${script_location}" >> cronplik # format co ile minut, godzin, dni, miesiecy
  #   crontab cronplik
  #     echo 'sadda' 
  #   rm cronplik
  # fi
  # if [[ $full_interval != '' ]]
  # then
  #   script_location=$(find $HOME -name execFullBackup.sh)
  #   echo "*/a */b */c */d * ${pwd}/skrypt" >> cronplik # format co ile minut, godzin, dni, miesiecy
  #   crontab cronplik
  #   rm cronplik
  #     echo 'saddsa' 
  # fi 
  # exit 0
}

_main "$@"
echo "after main"
echo $name
echo $gzip
echo $backupDir
# sudo tar -cvpzf --listed-incremental=data.snar backup.tar.gz 
 
# sudo tar -xvpzf backup.tar.gz -C /recover 

# sudo crontab -e

 echo tar+ $name +$gzip +$backupDir + -file +"$archive.tar"
exit 0
