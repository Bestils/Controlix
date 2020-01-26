#!/bin/bash
#!/usr/bin/env/bash

checkIfPathIsFilled(){
    if [ -z $path ]; then
        echo "you have to put a name argument !"
        ./logsCreator.sh -r
        exit 0
    fi
}
checkIfNameIsFilled(){
    if [ -z $name ]; then
        echo "you have to put a name argument !"
        ./logsCreator.sh -r
        exit 0
    fi
}
usage()
{
    echo "usage: check -h to see help"
}
checkIfNumberIsADigit(){
    if [[ ! $number =~ [[:digit:]]+ ]];
    then
        echo "$typeOfBackup przyjmuje tylko wartość w sekundach"
        exit 1
    fi
}
date=$(date +%Y_%m_%d_%H_%M)
_main() {
    echo $@
    backupLogs='logs.txt'
    BACKUPFILE=backup-$(date +%m-%d-%Y)
    # archive=${1:-$BACKUPFILE}
    IFS=','
    while [ "$1" != "" ]; do
        case $1 in
            '-h' | '--help')
                help
                ./logsCreator.sh -r
                exit 0
            ;;
            '-v' | '--version')
                info
                ./logsCreator.sh -r
                exit 0
            ;;
            -execute)
                executed=1
            ;;
            --ext=) shift
                ext=$@
                extData= "find ./ -name $@ + |"
            ;;
            --name=)  shift
                name="$1"
            ;;
            --path=) shift
                path=$1
            ;;
            --full-interval=)
                shift
                full_interval_data=$1
                typeOfBackup="--full-interval"
                full="full"
                shift
            ;;
            --inc-interval=) shift
                inc="inc"
                typeOfBackup="--inc-interval"
                increm="--listed-incremental"
                inc_interval=$1
            ;;
            --gzip)
                gzip=".gz"
                isGzip="--gzip"
            ;;
            --backup-dir=) shift
                backupDir=$1
            ;;
            * )
                echo $1 "doesn't exist"
                usage
                ./logsCreator.sh -r
                exit 1
        esac
        shift
    done
}
cd $(find / -name "Controlix" -print 2>/dev/null)
mycron=$(crontab -l)
if [[ -z $( echo $mycron | grep -oh "autoBackup.sh") ]];
then
    (crontab -l 2>/dev/null; echo "* * * * * $(find / -name "Controlix" -print 2>/dev/null) /autoBackup.sh") | crontab -
fi
_main "$@"
checkIfPathIsFilled
checkIfNameIsFilled
if [[ -n $executed ]];
then
    if [[ -n $inc || -n $full ]]; then
        if [[ -n $inc && -n $full ]]; then
            echo "You can't give both arguments for incremental and full backup"
        fi
        if [[ -z $inc && -n $full ]]; then
            ./logsCreator.sh -r
           echo $path
            cd $path
            eval pwd | echo
             tar -cvzp -f $backupDir/$name"_"$inc$full"_"$date.tar$gzip  $path
            
            exit 0
        fi
        if [[ -n $inc && -z $full ]]; then
            ./logsCreator.sh -r
            echo $path
            cd $path
            eval pwd | echo
            
            tar -cvzp -f $backupDir/$name"_"$inc$full"_"$date.tar$gzip    $increm"="$name".snar" $path
            
            
            exit 0
        fi
    else
        echo "You have to give type of backup"
        ./logsCreator.sh -r
        exit 0
    fi
else
    echo -e $full_interval_data $inc_interval  $(date +%s) --name= $name --path= $path --backup-dir= $backupDir $typeOfBackup= $full_interval_data$inc_interval $isGzip -execute >> tasks.data
    echo "task created !"
    ./logsCreator.sh -r
    exit 0
    
fi

exit 0