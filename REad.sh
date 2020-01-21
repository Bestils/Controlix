#!/bin/bash
#!/usr/bin/env/bash
checkIfAnyTimeIsAdded(){
if [ -n $inc ] || [ -n $full ]; then
echo a
if [ -n $inc && -n $full ]; then 
echo "You can't give both arguments for incremental and full backup"
exit 0 
 fi
 else
echo "You have to give type of backup"
exit 0
 fi
}
checkIfNameIsFilled(){
if [! -n $name ]; then
echo "you have to put a name argument !"
exit 0
 fi
}
checkIfDataIsFilled(){
if [! -n $date ]; then  
echo "you have to put a name argument !"
exit 0
 fi
}
checkIfBackup_dirIsFilled(){
if [! -n $backup_dir ]; then
echo "you have to put a name argument !"
exit 0
 fi
}
checkIfNameIsFilled(){
if [! -n $out_dir ]; then
echo "you have to put a name argument !"
exit 0
 fi
}
checkIfScriptIsRunning(){
if [ -f $backupLogs ]; then
    echo $backupLogs exist. Check the logs what is wrong
     exit 0
fi
}
_main() {
  for arg in "$@"
  do
    case "$arg" in 
      --name=*)
        IFS='=' read -a splitted <<< $arg
        name=${splitted[1]} ;;
      --date=*)
        IFS='=' read -a arg <<< $arg
        IFS=',' read -a date <<< ${arg[1]}
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
  if [[ -n $bestBackupMatch ]]
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
