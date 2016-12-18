#!/bin/bash

cnt=0
    # loop count
cntmax=1000
    # 1000 is about 6 days

pushcnt=0
pushskipcnt=0
dt='startstring'

    function loghdr() {
        echo >> logfile
        echo -n $dt '  ' >> logfile
        echo -n cnt $cnt '  ' >> logfile
        echo -n pushcnt $pushcnt '  ' >> logfile
        echo pushskipcnt $pushskipcnt >> logfile
    }

while [ $cnt -lt $cntmax ]; do

    let ' cnt = cnt + 1 '
    dt=`date`
    tail minicom.cap > tmpf1
    diff tmpf1 tmpf2 > /dev/null 2>&1
    rc=$?
    if [ $rc -ne 0 ]; then
        let 'pushcnt = pushcnt +1'
        loghdr

        cat tmpf1 >> logfile
        echo >> logfile
    else
        let 'pushskipcnt = pushskipcnt + 1'
        loghdr
    fi
    git commit -am 'update_logfile'
    git push

    echo
    echo '======================================'
        echo cnt $cnt push pushcnt $pushcnt pushskipcnt $pushskipcnt
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

