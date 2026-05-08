#!/bin/bash
sleep 15  # Wait 15 seconds for the desktop to load properly
export DISPLAY=:0
LOG_FILE="$HOME/yt_usage.csv"
THRESHOLD_SECONDS=10   # Check every 10 seconds
REMINDER_COOLDOWN=1800 # Show reminder every 30 mins (1800s) if still on YT

# Initialize CSV if it doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Date,Time,Time_Spent" > "$LOG_FILE"
fi

on_youtube="false"
declare -i start_time=0
declare -i curr_time=0
start_time2=0

while true; do
    # Check if any window title contains "YouTube"
if wmctrl -l | grep -qi "YouTube"; then
    if [[ "$on_youtube" = "false" ]];then
            start_time=$(date +%s)
            start_time2=$(date)
            on_youtube="true"
            response="None"
            
           if zenity --question --text="Do you really want to waste time on YouTube?" --timeout=10 --width=500 --height=300; then
           response="y"
           fi
    
            if [[ $response != "y" ]] ;then
                    wmctrl -c "YouTube"
                    
                    on_youtube="false"
                    start_time2=0
                	start_time=0
                	curr_time=0
                	sleep 3
            fi
         #pkill terminal
	else
		declare -i last=$(echo $(./browser_history.sh | head -n 5 | tail -n3 | tail -n 1)| cut -f 2 -d " "  | cut -f2 -d":")
		declare -i second_last=$(echo $(./browser_history.sh | head -n 5 | tail -n3 | head -n 1)| cut -f 2 -d " "  | cut -f2 -d":")
		
		time=$((last-second_last))
		
		if [[ $time -le "5" ]];then
		zenity --warning --text="Close Shorts Right Now" --width=500 --height=300
		fi

        fi
        
else
        if [[ "$on_youtube" = "true" ]]; then
                on_youtube="false"
                date=$(date +%d/%m/%y)
                curr_time=$(date +%s)
                secs=$((curr_time-start_time))
                #echo $secs
                hrs=$((secs/3600))
                mins=$(( ($secs%3600)/60 ))
                secs=$((secs%60))
                time="${hrs}_Hours_${mins}_Minutes_${secs}_Seconds"
                echo "$date,$start_time2,$time" >> $LOG_FILE
                
                start_time2=0
                start_time=0
                curr_time=0
                #echo "YouTube Window Closed....still running on standby"
                #sleep 2
               # pkill terminal
        fi
    fi





    sleep $THRESHOLD_SECONDS
done
                                                                             
