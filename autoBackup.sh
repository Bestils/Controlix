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

createTasksIfNotExists
    secondsSinceEpoch=$(date "+%s")
    touch tasks.data.new
    while read line
    do
    
        if [[ $line =~ [0-9]+[[:space:]][0-9]+[[:space:]].* ]]
        then
            IFS=' ' read -a line <<< $line
            if [[ line[0]+line[1] -le secondsSinceEpoch ]]
            then
            echo ${line[@]:2}
              sh  Create/Create.sh ${line[@]:2}
               echo "asa"
                echo -e "${line[0]} ${secondsSinceEpoch} ${line[@]:2} \n" >> tasks.data.new
            else
                echo -e "${line[@]} \n" >> tasks.data.new
            fi
        fi
    done < tasks.data
   
}

checkIFLogsAreActive
  ./logsCreator.sh -c
_main "$@"
  ./logsCreator.sh -r