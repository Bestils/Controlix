#!/usr/bin/env bash
checkIFLogsAreActive(){
       if [[ -f "LOGS.txt" ]];
    then
    echo "there is another process in background"
        exit 0
    fi
}
addNewTask(){
     rm -f tasks.data
    mv tasks.data.new tasks.data
}
createTasksIfNotExists(){
        if [[ ! -f "tasks.data" ]]
    then
        touch tasks.data
    fi
}
_main() {
    cd $(find / -name "Controlix" -print 2>/dev/null)/Controlix
 
createTasksIfNotExists


    secondsSinceEpoch=$(date "+%s")
    touch tasks.data.new
    while read line
    do
        if [[ $line =~ [0-9]+[[:space:]][0-9]+[[:space:]].* ]]
        then
            IFS=' ' read -a line <<< $line~S
            if [[ line[0]+line[1] -le secondsSinceEpoch ]]
            then
                echo -e "Wykonuję ${line[@]:2}"
                eval "${line[@]:2}"
                echo -e "${line[0]} ${secondsSinceEpoch} ${line[@]:2} \n" >> tasks.data.new
            else
                echo -e "${line[@]} \n" >> tasks.data.new
            fi
        fi
    done < tasks.data
    
    exit 0
}

checkIFLogsAreActive
 source ./logsCreator.sh -c
_main "$@"
 source ./logsCreator.sh -r