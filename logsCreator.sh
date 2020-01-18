#!/bin/bash
#!/usr/bin/env/bash

createLogs()
{
  mkdir $backupLogs
  echo "log created" 
}
destroyLogsIfEverythingWorks()
{
  rm  $backupLogs
  echo "log destroyed" 
}
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
           esac
    shift
done
}

_main "$@"
