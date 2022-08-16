#!/bin/sh


## Drive
#Scheduler
function Scheduler_Tweaking {
    normal_1; echo "Changing I/O Scheduler"; warn_2
    i=1
    drive=()
    disk=$(lsblk -nd --output NAME)
    diskno=$(echo $disk | awk '{print NF}')
    while [ $i -le $diskno ]
    do
	    device=$(echo $disk | awk -v i=$i '{print $i}')
	    drive+=($device)
	    i=$(( $i + 1 ))
    done
    i=1
    x=0
    disktype=$(cat /sys/block/$diskname/queue/rotational)
    if [ "${disktype}" == 0 ]; then
	    while [ $i -le $diskno ]
	    do
		    diskname=$(eval echo ${drive["$x"]})
		    echo kyber > /sys/block/$diskname/queue/scheduler
		    i=$(( $i + 1 ))
		    x=$(( $x + 1 ))
	    done
    else
	    while [ $i -le $diskno ]
	    do
		    diskname=$(eval echo ${drive["$x"]})
		    echo mq-deadline > /sys/block/$diskname/queue/scheduler
		    i=$(( $i + 1 ))
		    x=$(( $x + 1 ))
	    done
    fi
}    
