#!/bin/bash

if [ $(id -u) -ne 0 ]
then 
    echo "script is not run as root, exiting..."
    exit
else
    :
fi

### variables
SERVICE_NAME=com.example_root.show
SCRIPT_NAME=example_root

echo ''


### waiting for logged in user
#echo "LOGNAME is $(logname)..."
#/bin/ls -l /dev/console | /usr/bin/awk '{ print $3 }'
#stat -f%Su /dev/console
#defaults read /Library/Preferences/com.apple.loginwindow.plist lastUserName
# recommended way
loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
NUM=0
MAX_NUM=15
SLEEP_TIME=3
# waiting for loggedInUser to be available
while [[ "$loggedInUser" == "" ]] && [[ "$NUM" -lt "$MAX_NUM" ]]
do
    sleep "$SLEEP_TIME"
    NUM=$(($NUM+1))
    loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')
done
#echo ''
#echo "NUM is $NUM..."
#echo "loggedInUser is $loggedInUser..."
if [[ "$loggedInUser" == "" ]]
then
    WAIT_TIME=$(($MAX_NUM*$SLEEP_TIME))
    echo "loggedInUser could not be set within "$WAIT_TIME"s, exiting..."
    exit
else
    :
fi


### logfile
EXECTIME=$(date '+%Y-%m-%d %T')
LOGDIR=/var/log
LOGFILE="$LOGDIR"/"$SCRIPT_NAME".log

if [[ -f "$LOGFILE" ]]
then
    # only macos takes care of creation time, linux doesn`t because it is not part of POSIX
    LOGFILEAGEINSECONDS="$(( $(date +"%s") - $(stat -f "%B" $LOGFILE) ))"
    MAXLOGFILEAGE=$(echo "30*24*60*60" | bc)
    #echo $LOGFILEAGEINSECONDS
    #echo $MAXLOGFILEAGE
    # deleting logfile after 30 days
    if [ "$LOGFILEAGEINSECONDS" -lt "$MAXLOGFILEAGE" ];
    then
        echo "logfile not older than 30 days..."
    else
        # deleting logfile
        echo "deleting logfile..."
        sudo rm "$LOGFILE"
        sudo touch "$LOGFILE"
        sudo chmod 644 "$LOGFILE"
    fi
else
    sudo touch "$LOGFILE"
    sudo chmod 644 "$LOGFILE"
fi

sudo echo "" >> "$LOGFILE"
sudo echo $EXECTIME >> "$LOGFILE"


### function
example_function() {
    
    ### loggedInUser
    echo "loggedInUser is $loggedInUser..."
    
    
    ### sourcing .bash_profile or setting PATH
    # as the script is run as root from a launchd it would not detect the binary commands and would fail checking if binaries are installed
    # needed if binary is installed in a special directory
    if [[ -e /Users/$loggedInUser/.bash_profile ]] && [[ $(cat /Users/$loggedInUser/.bash_profile | grep '/usr/local/bin:') != "" ]]
    then
        . /Users/$loggedInUser/.bash_profile
    else
        #export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
        PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
    fi
    
    
    ### script
	echo "running as root ;)"
	
}

(time example_function) 2>&1 | tee -a "$LOGFILE"
echo '' >> "$LOGFILE"
