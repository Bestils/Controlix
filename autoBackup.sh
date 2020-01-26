
#!/usr/bin/env Bash

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
    secondsSinceEpoch=$(date "+%s")

    while read line
    do

        if [[ $line =~ [0-9]+[[:space:]][0-9]+[[:space:]].* ]]
        then

            IFS=' ' read -a line <<< $line
            if [[ ${line[0]}+${line[1]} -le $secondsSinceEpoch ]]
            then
                echo -e ${line[0]} $secondsSinceEpoch  ${line[@]:2}  >> tasks.data.new
                addNewTask
                ./logsCreator.sh -r
                  source  Create/Create.sh ${line[@]:2}
            else
            
                echo -e "${line[@]} \n" >> tasks.data.new
            fi
        fi
    done < tasks.data
   
}
# cd $HOME/Bash/Controlix
 cd $(find / -name "Controlix" -print 2>/dev/null)

createTasksIfNotExists
checkIFLogsAreActive
  ./logsCreator.sh -c
_main "$@"

exit 0
