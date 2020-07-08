#!/bin/zsh

###
### sourcing config file
###

if [[ -f ~/.shellscriptsrc ]]; then . ~/.shellscriptsrc; else echo '' && echo -e '\033[1;31mshell script config file not found...\033[0m\nplease install by running this command in the terminal...\n\n\033[1;34msh -c "$(curl -fsSL https://raw.githubusercontent.com/tiiiecherle/osx_install_config/master/_config_file/install_config_file.sh)"\033[0m\n' && exit 1; fi
eval "$(typeset -f env_get_shell_specific_variables)" && env_get_shell_specific_variables



###
### install
###

# variables
APP_NAME="unarchive_finder_input_tar_gz_gpg_preserve_permissions_progress"
DMG_DIR="$SCRIPT_DIR_ONE_BACK"

# remove old installed version
if [[ -e "$PATH_TO_APPS"/"$APP_NAME".app ]]
then
	rm -rf "$PATH_TO_APPS"/"$APP_NAME".app
else
	:
fi

# ownership and permissions
cp -a "$DMG_DIR"/app/"$APP_NAME".app "$PATH_TO_APPS"/
chown 501:admin "$PATH_TO_APPS"/"$APP_NAME".app
chmod 755 "$PATH_TO_APPS"/"$APP_NAME".app
xattr -dr com.apple.quarantine "$PATH_TO_APPS"/"$APP_NAME".app


### security permissions
APPS_SECURITY_ARRAY=(
# app name									security service											allowed (1=yes, 0=no)
"$APP_NAME                               	kTCCServiceAccessibility                             		1"
)
PRINT_SECURITY_PERMISSIONS_ENTRIES="no" env_set_apps_security_permissions


### automation
# macos versions 10.14 and up
AUTOMATION_APPS=(
# source app name							automated app name											allowed (1=yes, 0=no)
"$APP_NAME									System Events                   							1"
"$APP_NAME									Terminal                   									1"
)
PRINT_AUTOMATING_PERMISSIONS_ENTRIES="no" env_set_apps_automation_permissions


#open "$PATH_TO_APPS"/"$APP_NAME".app
