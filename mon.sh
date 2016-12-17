#!/bin/bash

cnt=0

while [ $cnt -lt 1000 ]; do

    let ' cnt = cnt + 1 '
    dt=`date`
    tail minicom.cap > tmpf1
    diff tmpf1 tmpf2 > /dev/null 2>&1
    rc=$?
    if [ $rc -ne 0 ]; then
        echo >> logfile
        echo $dt >> logfile
        cat tmpf1 >> logfile
        echo >> logfile
        git commit -am 'update_logfile'
        git push
    fi

    if [ $cnt -lt 10 ]; then
        sleep 60
    else
        sleep 600
    fi

    cp tmpf1 tmpf2

done

echo
echo done cnt $cnt

