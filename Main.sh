#!/bin/bash
#!/usr/bin/env/bash
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
    echo "usage: sysinfo_page [[[-f file ] [-i]] | [-h]]"
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
      source "read/read.sh" $@
      exit 0 ;;

    'create')
      shift
      source "/create/create.sh" $@
      exit 0 ;;

       * )   
      usage
      exit 1
  esac
  echo "Nieznany argument"
  exit 0
}

_main "$@"

exit 0

