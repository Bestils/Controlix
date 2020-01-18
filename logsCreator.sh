#!/bin/bash
#!/usr/bin/env/bash

createLogs()
{
  mkdir $backupLogs
}
destroyLogsIfEverythingWorks()
{
  rm -F $backupLogs
}
checkIfSomethingExist(){
if [ -f $backupLogs ]; then
    echo $backupLogs exist. Check the logs what is wrong
     exit 0
  else 
  echo "DSADS"
fi

}
echo "chuj" 
backupLogs="LOGS.txt"
_main() {
while [ "$1" != "" ]; do
    case $1 in
     '-c')
        shift
        createLogs
        ;;
     '-r')  shift
destroyLogsIfEverythingWorks
       ;;
      '-h')  shift
checkIfSomethingExist
       ;;
           esac
    shift
done
}

_main "$@"
echo "chuj" 