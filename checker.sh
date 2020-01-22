#!/usr/bin/env bash

_main() {
    cd $(find / -name "Controlix" -print 2>/dev/null)/Controlix
    if [[ -f "monitor.lock" ]]
    then
        exit 0
    fi
    touch Controlix.lock

    if [[ ! -f "tasks.data" ]]
    then
        touch tasks.data
    fi

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

    rm -f tasks.data
    mv tasks.data.new tasks.data
    rm -f monitor.lock
    exit 0
}

_main "$@"
