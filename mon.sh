#!/bin/bash

cnt=0
pushcnt=0

while [ $cnt -lt 1000 ]; do

    let ' cnt = cnt + 1 '
    dt=`date`
    tail minicom.cap > tmpf1
    diff tmpf1 tmpf2 > /dev/null 2>&1
    rc=$?
    if [ $rc -ne 0 ]; then
        let 'pushcnt = pushcnt +1'
        echo >> logfile
        echo $dt >> logfile
        echo cnt $cnt >> logfile
        echo pushcnt $pushcnt >> logfile
        cat tmpf1 >> logfile
        echo >> logfile
        git commit -am 'update_logfile'
        git push
    fi

    echo
    echo '======================================'
        echo cnt $cnt
        echo pushcnt $pushcnt 
        echo 
    if [ $cnt -lt 10 ]; then
        echo sleep 60
        sleep 60
    else
        echo sleep 600
        sleep 600
    fi

    cp tmpf1 tmpf2

done

echo
echo done cnt $cnt

