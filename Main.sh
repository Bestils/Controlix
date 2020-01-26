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
  echo '3.14 COPYRIGHT: PATRYK KIRSZENSTEIN '
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
      exit 0
      ;;

    'create')
      shift
      source "Create/Create.sh" $@
  ;;
    'cron')
      shift
      echo "Wpisz to do konsoli aby dodac taski do crona"
     echo "(crontab -l 2>/dev/null; echo "* * * * * /home/death/Bash/Controlix") | crontab -"
      echo "taski przypisane do crona "
  ;;
       * )   
      usage
      ./logsCreator.sh -r
      exit 1
  esac
}

checkIFLogsAreActive

_main "$@"
./logsCreator.sh -c
./logsCreator.sh -r
exit 0

