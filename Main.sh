#!/bin/bash
#!/usr/bin/env/bash
checkIFLogsAreActive(){
       if [[ -f "LOGS.txt" ]];
    then
    echo "there is another process in background"
        exit 0
    fi
}
help() 
{
 cat help.txt
}
info() 
{
  echo '3.14 COPYRIGHT: PATRYK KIRSZENSTEIN LICENSE: MIT'
}
usage()
{
    echo "You need to use create or read. For more info use -h "
}
_main() {
  IFS=','
  for arg in "$@"
  do
    case "$arg" in
      '-h' | '--help')
        help
        exit 0 
        ;;
      '-v' | '--version')
        displayInfo
        exit 0 
        ;;
    esac
  done
  case "$1" in
    'read')
      shift
      source "Read/Read.sh" $@
      ;;

    'create')
      shift
      source "Create/Create.sh" $@
  ;;

       * )   
      usage
      exit 1
  esac
}
checkIFLogsAreActive
./logsCreator.sh -c
_main "$@"
./logsCreator.sh -r
exit 0

