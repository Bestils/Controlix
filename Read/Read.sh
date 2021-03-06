#!/usr/bin/env bash
checkIfFileExists(){
     if [[ ! -d $backup_dir ]]
        then
          echo "Podany folder nie istnieje"
          exit 0
        fi 
}
checkIfFileExists(){
 if [[ -z $name ]]
  then
    echo "Brakujący argument--name"
    exit 0
  fi
}
  checkIfFileExists(){
  if [[ -z $date ]]
  then
    echo "Brakujacy argument  --date"
    exit 0
  fi
  }
  checkIfFileExists(){
  if [[ -z $backup_dir ]]
  then
    echo "Brakujacy argument --backup_dir"
    exit 0
  fi
  }
  checkIfFileExists(){
  if [[ -z $out_dir ]]
  then
    echo "Brakujacy argument  --out_dir"
    exit 0
  fi
  }
_main() {

 while [ "$1" != "" ]; do
    case "$1" in 
      --name=)
      shift
        name=$1 
        ;;
      --date=)
       shift
        IFS='_' read -a date <<< $1
        date=$(date -d "${date[0]}-${date[1]}-${date[2]} ${date[3]}:${date[4]}:00" +%s) 
    
      ;;
      --backup_dir=)
   shift
        backup_dir=$1
     ;;
      
      --out_dir=)
      shift
        out_dir=$1
        eval out_dir=$out_dir
         ;;
     esac
    shift
done
}
_main "$@"
cd $backup_dir
  #szukanie backupu do otwarcia
  for file in "$backup_dir"/*
  do
    candidate=${file##*/}
    backupFileRegex=$name"_[[:alpha:]]+_([[:digit:]]+_){4}[[:digit:]]+.*"

 
    if [[ $candidate =~ $backupFileRegex ]]
    then
      #wyciąga datę z nazwy pliku
      candidateDate=$(echo $candidate | grep -oE "([[:digit:]]+_){4}[[:digit:]]+")
      IFS='_' read -a candidateDate <<< $candidateDate
      candidateDate=$(date -d "${candidateDate[0]}-${candidateDate[1]}-${candidateDate[2]} ${candidateDate[3]}:${candidateDate[4]}:00" +%s)
      let timeDiff=$date-$candidateDate
      if [[ ($timeDiff -le $bestBackupMatchDateDiff && $timeDiff -ge 0) || -z $bestBackupMatchDateDiff ]]
      then
        bestBackupMatch=$file
        bestBackupMatchDateDiff=$timeDiff
      fi
    fi
  done
  #ekstrakcja
  if [[ -n $bestBackupMatch ]]
  then
    if [[ ! -d $out_dir ]]
    then
      mkdir $out_dir
    fi
    echo "odtwarzanie backupu $bestBackupMatch"
    tar -xvf $bestBackupMatch  -C $out_dir
  else
    echo "Nie znaleziono backupu"
  fi


