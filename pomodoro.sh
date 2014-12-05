#!/bin/bash
# TODO Log activities
# Startup
for SEC in 0 1 2
do
    CNT=$((3-SEC))
        clear 
        figlet "$CNT" 
	say "$CNT"
done
clear
figlet "GO!"
say "Go!"

# Options
POMODORO_NUM=1
WORK_NUM=1
POMODORO="WORK"

SEC=0
MIN=0
POMODORO_TIME=25
REST_TIME=5

while :
do
        if [ "$POMODORO" == "WORK" ]
        then
            R_MIN=$((POMODORO_TIME-MIN-1))
        else
            R_MIN=$((REST_TIME-MIN-1))
        fi

        R_SEC=$((59-SEC))
        
        clear
        
        if [ "$POMODORO" == "WORK" ]
        then
	    figlet "$(printf '%s (%d): %02d:%02d' $POMODORO $WORK_NUM $R_MIN $R_SEC)"
        else
	    figlet "$(printf '%s: %02d:%02d' $POMODORO $R_MIN $R_SEC)"
        fi

	SEC=$((SEC+1))

	if [ $SEC -eq 60 ]
	then
		SEC=0
		MIN=$((MIN+1))

		if [ "$POMODORO" == "WORK" ]
		then
			if [ $MIN -eq $((POMODORO_TIME-5)) ]
			then
				say "5 minutes left" 
			fi

			if [ $MIN -eq $((POMODORO_TIME-1)) ]
			then
				say "1 minute left"
			fi

			if [ $MIN -eq $POMODORO_TIME ]
			then
                                POMODORO_NUM=$((POMODORO_NUM+1))
                                WORK_NUM=$((WORK_NUM+1))

                                if [ $POMODORO_NUM -eq 4 ]
                                then
                                        REST_TIME = 15
                                        POMODORO_NUM = 0
                                else
                                        REST_TIME = 5
                                fi

                                say "rest for $REST_TIME minutes"
                                POMODORO="REST"
                                MIN=0
                                SEC=0
			fi
		elif [ "$POMODORO" == "REST" ]
                then
			if [ $MIN -eq $REST_TIME ]
			then
				say "get back to work"
				POMODORO="WORK"
				MIN=0
				SEC=0
			fi
		fi
	fi

	sleep 1
done
