#!/usr/bin/env bash

_main() {
  # --name= 'położenie pliku z backupami'
  # --date= 'początek nazwy pliku z backupem'
  # --backup_dir= 'czas, na który odtworzyć backup (lub najbliższy w przeszłości zawierający backup);
  #     format daty: rok_miesiąc_dzień_godzina_minuta_sekunda'
  # --out_dir='katalog, do którego wypakować backup'
  
  #zbieranie argumentów z CLI
  for arg in "$@"
  do
    case "$arg" in 
      --name=*)
        IFS='=' read -a splitted <<< $arg
        name=${splitted[1]} ;;

      --date=*)
        IFS='=' read -a arg <<< $arg
        IFS='_' read -a date <<< ${arg[1]}
        date=$(date -d "${date[0]}-${date[1]}-${date[2]} ${date[3]}:${date[4]}:${date[5]}" +%s) ;;
      
      --backup_dir=*)
        IFS='=' read -a splitted <<< $arg
        backup_dir=${splitted[1]} 
        eval backup_dir=$backup_dir
        if [[ ! -d $backup_dir ]]
        then
          echo "Podany backup_dir nie istnieje"
          exit 0
        fi ;;
      
      --out_dir=*)
        IFS='=' read -a splitted <<< $arg
        out_dir=${splitted[1]}
        eval out_dir=$out_dir ;;
    esac
  done

  if [[ -z $name ]]
  then
    echo "Musisz podać --name"
    exit 0
  fi
  if [[ -z $date ]]
  then
    echo "Musisz podać --date"
    exit 0
  fi
  if [[ -z $backup_dir ]]
  then
    echo "Musisz podać --backup_dir"
    exit 0
  fi
  if [[ -z $out_dir ]]
  then
    echo "Musisz podać --out_dir"
    exit 0
  fi

  #szukanie backupu do otwarcia
  for file in "$backup_dir"/*
  do
    candidate=${file##*/}
    backupFileRegex=$name"_[[:alpha:]]+_([[:digit:]]+_){4}[[:digit:]]+.*" #$name_cokolwiek_data_colokwiek wystarczy
    #regex czy to jest backup
    if [[ $candidate =~ $backupFileRegex ]]
    then
      #wyciąga datę z nazwy pliku
      candidateDate=$(echo $candidate | grep -oE "([[:digit:]]+_){4}[[:digit:]]+")
      IFS='_' read -a candidateDate <<< $candidateDate
      candidateDate=$(date -d "${candidateDate[0]}-${candidateDate[1]}-${candidateDate[2]} ${candidateDate[3]}:${candidateDate[4]}:00" +%s)
      let timeDiff=$date-$candidateDate
      if [[ ($timeDiff -ge $bestBackupMatchDateDiff && $timeDiff -le 0) || -z $bestBackupMatchDateDiff ]]
      then
        bestBackupMatch=$file
        bestBackupMatchDateDiff=$timeDiff
      fi
    fi
  done

  #ekstrakcja
  if [[ $bestBackupMatch ]]
  then
    if [[ ! -d $out_dir ]]
    then
      mkdir $out_dir
    fi
    echo "odtwarzanie backupu $bestBackupMatch"
    tar -xvf $bestBackupMatch -C $out_dir
  else
    echo "Nie znaleziono backupu"
  fi
}

_main "$@"
