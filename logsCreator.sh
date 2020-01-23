#!/bin/bash
#!/usr/bin/env/bash
createLogs()
{
  touch $backupLogs
  echo "Process Started" 
}
destroyLogsIfEverythingWorks()
{
  rm  -f $backupLogs
  echo "Process Ended" 
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
