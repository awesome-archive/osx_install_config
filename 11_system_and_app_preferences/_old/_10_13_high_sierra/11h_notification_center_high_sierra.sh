#!/bin/zsh

###
### sourcing config file
###

if [[ -f ~/.shellscriptsrc ]]; then . ~/.shellscriptsrc; else echo '' && echo -e '\033[1;31mshell script config file not found...\033[0m\nplease install by running this command in the terminal...\n\n\033[1;34msh -c "$(curl -fsSL https://raw.githubusercontent.com/tiiiecherle/osx_install_config/master/_config_file/install_config_file.sh)"\033[0m\n' && exit 1; fi
eval "$(typeset -f env_get_shell_specific_variables)" && env_get_shell_specific_variables



###
### script
###

applications_to_set_values=(
""$PATH_TO_APPS"/WhatsApp.app															335"
""$PATH_TO_APPS"/Signal.app																335"
""$PATH_TO_APPS"/pdf_200dpi_shrink.app/custom_files/pdf_shrink_done.app					335"
""$PATH_TO_SYSTEM_APPS"/Reminders.app													343"
""$PATH_TO_APPS"/EagleFiler.app															335"
""$PATH_TO_APPS"/VirusScannerPlus.app													335"
)

PLIST_FILE='~/Library/Preferences/com.apple.ncprefs.plist'

# functions
getting-needed-entry() {

	NUMBER_OF_ENTRIES=$(/usr/libexec/PlistBuddy -c "Print apps" $(eval echo "$PLIST_FILE") | awk '/^[[:blank:]]*Dict {/' | wc -l)
	#echo $NUMBER_OF_ENTRIES
	# -1 because counting of items starts with 0, not with 1
	LISTED_ENTRIES=$((NUMBER_OF_ENTRIES-1))
	#echo $LISTED_ENTRIES
	
	NEEDED_ENTRY=""
	
	for i in $(seq 0 $LISTED_ENTRIES)
	do 
	    #if [[ $(/usr/libexec/PlistBuddy -c "Print apps:$i" $(eval echo "$PLIST_FILE") | grep "$BUNDLE_IDENTIFIER") != "" ]] 2> /dev/null
	   	(/usr/libexec/PlistBuddy -c "Print apps:$i" $(eval echo "$PLIST_FILE") | grep "$BUNDLE_IDENTIFIER") >/dev/null 2>&1
	   	if [ $? -eq 0 ]
	    then
	        #echo $i
	        NEEDED_ENTRY=$i
	    else
	        :
	        #echo $i
	    fi
	done
	
}

for application in "${applications_to_set_values[@]}"
do

	APP_PATH=$(echo "$application" | awk '{print $1}')
    FLAGS_VALUE=$(echo "$application" | awk '{print $2}')
    
	BUNDLE_IDENTIFIER=$(/usr/libexec/PlistBuddy -c 'Print CFBundleIdentifier' $(eval echo "$APP_PATH")/Contents/Info.plist)
	echo "setting flags for $BUNDLE_IDENTIFIER..."

	getting-needed-entry

	#echo $NEEDED_ENTRY
	if [[ $NEEDED_ENTRY != "" ]]
	then
	    /usr/libexec/PlistBuddy -c "Set apps:$NEEDED_ENTRY:flags $(eval echo "$FLAGS_VALUE")" $(eval echo "$PLIST_FILE")
	else
		echo "entry for $BUNDLE_IDENTIFIER does not exist, creating it..."
	    ITEM1=$(echo \'Item $NUMBER_OF_ENTRIES\')
	    #echo $ITEM1
	   	/usr/libexec/PlistBuddy -c "Add apps:$ITEM1:bundle-id string $BUNDLE_IDENTIFIER" $(eval echo "$PLIST_FILE")
	   	
		getting-needed-entry
		
		/usr/libexec/PlistBuddy -c "Add apps:$NEEDED_ENTRY:flags integer $(eval echo "$FLAGS_VALUE")" $(eval echo "$PLIST_FILE")
	fi

done

# applying changes without having to logout
sudo killall usernoted
sudo killall NotificationCenter
