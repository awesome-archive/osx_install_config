#!/bin/zsh

###
### sourcing config file
###

if [[ -f ~/.shellscriptsrc ]]; then . ~/.shellscriptsrc; else echo '' && echo -e '\033[1;31mshell script config file not found...\033[0m\nplease install by running this command in the terminal...\n\n\033[1;34msh -c "$(curl -fsSL https://raw.githubusercontent.com/tiiiecherle/osx_install_config/master/_config_file/install_config_file.sh)"\033[0m\n' && exit 1; fi
eval "$(typeset -f env_get_shell_specific_variables)" && env_get_shell_specific_variables



###
### checking installation
###

### variables
SERVICE_NAME=com.example_user.show
SERVICE_INSTALL_PATH=/Users/$USER/Library/LaunchAgents
SCRIPT_INSTALL_NAME=example_user
SCRIPT_INSTALL_PATH=/Users/$USER/Library/Scripts

LOGDIR=/Users/"$USER"/Library/Logs
LOGFILE="$LOGDIR"/"$SCRIPT_INSTALL_NAME".log

# logfiles
logfiles_to_open=(
"$LOGFILE"
)

# launchd services
launchd_services=(
"$SERVICE_NAME"
)


### checking status of services
for i in "${launchd_services[@]}"
do
    #echo ''
    echo "checking "$i"..."
    if [[ -e "$SERVICE_INSTALL_PATH"/"$i".plist ]]
    then
        echo "$i is installed..."
    
        # checking if running
        if [[ $(launchctl list | grep "$i") != "" ]]
        then
            echo "$i is running..."
        else
            echo "$i is not running..."
        fi
        
        # checking if enabled
        #launchctl print-disabled user/"$UNIQUE_USER_ID" | grep "$i"
        #
        if [[ $(launchctl print-disabled user/"$UNIQUE_USER_ID" | grep "$i" | grep false) != "" ]]
        then
            #echo "$i is installed and enabled..."
            echo "$i is enabled..."
        else
           #echo "$i is installed but disabled..."
           echo "$i is disabled..."
        fi

    else
       echo "$i is not installed..."
    fi

    echo ''
            
done


### logfiles
#echo ''
echo "opening logfiles..."
for i in "${logfiles_to_open[@]}"
do
    if [[ -e "$i" ]]
    then
        open "$i"
    else
        echo "$i does not exist..."
    fi
done

echo ''
