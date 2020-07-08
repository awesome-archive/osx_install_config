#!/bin/zsh

###
### sourcing config file
###

if [[ -f ~/.shellscriptsrc ]]; then . ~/.shellscriptsrc; else echo '' && echo -e '\033[1;31mshell script config file not found...\033[0m\nplease install by running this command in the terminal...\n\n\033[1;34msh -c "$(curl -fsSL https://raw.githubusercontent.com/tiiiecherle/osx_install_config/master/_config_file/install_config_file.sh)"\033[0m\n' && exit 1; fi
eval "$(typeset -f env_get_shell_specific_variables)" && env_get_shell_specific_variables



###
### uninstall service
###

### variables
UNINSTALL_SCRIPT_DIR="$SCRIPT_DIR"

SERVICE_NAME=com.screen_resolution.set
SERVICE_INSTALL_PATH=/Users/"$USER"/Library/LaunchAgents
SCRIPT_INSTALL_NAME=screen_resolution
SCRIPT_INSTALL_PATH=/Users/"$USER"/Library/Scripts

LOGDIR=/Users/"$loggedInUser"/Library/Logs
LOGFILE="$LOGDIR"/"$SCRIPT_INSTALL_NAME".log


### deleting display manager
if [[ -e "$PATH_TO_APPS"/display_manager ]]
then
    rm -rf "$PATH_TO_APPS"/display_manager
else
    :
fi


### deleting script
if [[ -f "$SCRIPT_INSTALL_PATH"/"$SCRIPT_INSTALL_NAME".sh ]]
then
    rm -f "$SCRIPT_INSTALL_PATH"/"$SCRIPT_INSTALL_NAME".sh
else
    :
fi


### unloading and disabling (-w) launchd service
if [[ $(launchctl list | grep "$SERVICE_NAME") != "" ]]
then
    launchctl unload "$SERVICE_INSTALL_PATH"/"$SERVICE_NAME".plist
    launchctl disable user/"$UNIQUE_USER_ID"/"$SERVICE_NAME"
    launchctl remove "$SERVICE_NAME"
else
    :
fi


### enabling launchd service
# checking if installed and disabled, if yes, enable
for i in "$SERVICE_NAME"
do
    if [[ $(launchctl print-disabled user/"$UNIQUE_USER_ID" | grep "$i" | grep true) != "" ]]
    then
        #echo "enabling "$i"..."
        launchctl disable user/"$UNIQUE_USER_ID"/"$i"
    else
        :
    fi
done


### deleting launchd service
if [[ -f "$SERVICE_INSTALL_PATH"/"$SERVICE_NAME".plist ]]
then
    rm -f "$SERVICE_INSTALL_PATH"/"$SERVICE_NAME".plist
else
    :
fi


### deleting logfile
if [[ -f "$LOGFILE" ]]
then
    rm -f "$LOGFILE"
else
    :
fi


### checking installation
if [[ $(ps aux | grep /install_"$SCRIPT_INSTALL_NAME"_and_launchdservice.sh | grep -v grep) == "" ]]
then
    echo ''
    echo "checking installation..."
    "$UNINSTALL_SCRIPT_DIR"/checking_installation.sh
    wait
else
    :
fi


#echo ''
echo "uninstalling done..."
echo ''

