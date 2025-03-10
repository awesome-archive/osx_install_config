#!/usr/bin/env bash


### variables
MACOS_VERSION=$(sw_vers -productVersion)
#MACOS_VERSION=$(defaults read loginwindow SystemVersionStampAsString)

# macos 10.14 and higher
#if [[ $(echo $MACOS_VERSION | cut -f1 -d'.') == "10" ]] && [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
# macos 10.14 only
if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.') != "10.14" ]]
then
    #echo "this script is only compatible with macos 10.14 mojave and newer, exiting..."
    echo ''
    echo "this script is only compatible with macos 10.14 mojave, exiting..."
    echo ''
    exit
else
    :
fi


### functions

function databases_apps_security_permissions() {
    DATABASE_SYSTEM="/Library/Application Support/com.apple.TCC/TCC.db"
    #echo "$DATABASE_SYSTEM"
	DATABASE_USER="/Users/"$USER"/Library/Application Support/com.apple.TCC/TCC.db"
    #echo "$DATABASE_USER"
}
    
function identify_terminal() {
    if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]
    then
    	export SOURCE_APP=com.apple.Terminal
    	export SOURCE_APP_NAME="Terminal"
    elif [[ "$TERM_PROGRAM" == "iTerm.app" ]]
    then
        export SOURCE_APP=com.googlecode.iterm2
        export SOURCE_APP_NAME="iTerm"
	else
		export SOURCE_APP=com.apple.Terminal
		echo "terminal not identified, setting automating permissions to apple terminal..."
	fi
}

function give_apps_security_permissions() {
    if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
    then
        # macos versions until and including 10.13 
		:
    else
        # macos versions 10.14 and up
        # working, but does not show in gui of system preferences, use csreq for the entry to show
	    sqlite3 "$DATABASE_USER" "REPLACE INTO access VALUES('kTCCServiceAppleEvents','"$SOURCE_APP"',0,1,1,?,NULL,0,'"$AUTOMATED_APP"',?,NULL,?);"
    fi
    sleep 1
}

function remove_apps_security_permissions_start() {
    if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
    then
        # macos versions until and including 10.13 
		:
    else
        # macos versions 10.14 and up
        AUTOMATED_APP=com.apple.finder
        sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"');"
    fi
    sleep 1
}

function remove_apps_security_permissions_stop() {
    if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
    then
        # macos versions until and including 10.13 
		:
    else
        # macos versions 10.14 and up
        AUTOMATED_APP=com.apple.finder
        # macos versions 10.14 and up
        if [[ $SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1 == "yes" ]]
        then
            # source app was already allowed to control app before running this script, so don`t delete the permission
            :
        else
            sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"');"
        fi
    fi
}

ask_for_variable () {
	ANSWER_WHEN_EMPTY=$(echo "$QUESTION_TO_ASK" | awk 'NR > 1 {print $1}' RS='(' FS=')' | tail -n 1 | tr -dc '[[:upper:]]\n')
	VARIABLE_TO_CHECK=$(echo "$VARIABLE_TO_CHECK" | tr '[:upper:]' '[:lower:]') # to lower
	while [[ ! "$VARIABLE_TO_CHECK" =~ ^(yes|y|no|n)$ ]] || [[ -z "$VARIABLE_TO_CHECK" ]]
	do
		read -r -p "$QUESTION_TO_ASK" VARIABLE_TO_CHECK
		if [[ "$VARIABLE_TO_CHECK" == "" ]]; then VARIABLE_TO_CHECK="$ANSWER_WHEN_EMPTY"; else :; fi
		VARIABLE_TO_CHECK=$(echo "$VARIABLE_TO_CHECK" | tr '[:upper:]' '[:lower:]') # to lower
	done
	#echo VARIABLE_TO_CHECK is "$VARIABLE_TO_CHECK"...
}

###


databases_apps_security_permissions
identify_terminal

if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
then
    # macos versions until and including 10.13 
	:
else
    echo ''
    echo "setting security permissions..."
    AUTOMATED_APP=com.apple.finder
    if [[ $(sqlite3 "$DATABASE_USER" "select * from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"' and allowed='1');") != "" ]]
	then
	    SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1="yes"
	    #echo "$SOURCE_APP is already allowed to control $AUTOMATED_APP..."
	else
		SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1="no"
		#echo "$SOURCE_APP is not allowed to control $AUTOMATED_APP..."
		give_apps_security_permissions
	fi
    echo ''
fi

# trap
trap 'printf "\n"; remove_apps_security_permissions_stop' SIGHUP SIGINT SIGTERM EXIT


### sfltool
# sfltool restore|add-item|save-lists|test|archive|enable-modern|dump-server-state|clear|disable-modern|dump-storage|list-info [options]


### alternative to mysides
# https://github.com/robperc/FinderSidebarEditor


### mysides
# installs to /usr/local/bin/mysides
# -rwxr-xr-x    1 root  wheel  47724 14 Apr 02:07 mysides
# https://github.com/mosen/mysides
# newer version here
# https://github.com/Tatsh/mysides
MYSIDESVERSION="1.0.1"

VARIABLE_TO_CHECK="$INSTALL_UPDATE_MYSIDES"
QUESTION_TO_ASK="do you want to install / update to mysides "$MYSIDESVERSION"? (y/N) "
ask_for_variable
INSTALL_UPDATE_MYSIDES="$VARIABLE_TO_CHECK"

if [[ "$INSTALL_UPDATE_MYSIDES" =~ ^(yes|y)$ ]]
then
	echo "downloading and installing mysides..."
	MYSIDESINSTALLER="/Users/$USER/Desktop/mysides-"$MYSIDESVERSION".pkg"
	#wget https://github.com/mosen/mysides/releases/download/v"$MYSIDESVERSION"/mysides-"$MYSIDESVERSION".pkg -O "$MYSIDESINSTALLER"
	curl https://github.com/mosen/mysides/releases/download/v"$MYSIDESVERSION"/mysides-"$MYSIDESVERSION".pkg -o "$MYSIDESINSTALLER" --progress-bar
	open "$MYSIDESINSTALLER"
	echo "waiting for installer to finish..."
	while ps aux | grep 'Installer.app.*Installer' | grep -v grep > /dev/null; do sleep 1; done
	echo "removing installer file..."
	if [ -e "$MYSIDESINSTALLER" ]; then rm "$MYSIDESINSTALLER"; else :; fi
	echo "continuing setting finder sidebar entries..."
	sleep 2
else
    :
fi

echo ''
echo "clearing and setting finder sidebare items..."

# clearing out settings and removes icloud
#sfltool clear
# if everything is cleared with this command, block three (device, external drives, cds, dvds and ipods) would need a second reboot and applying settings again to work after first reboot
#sleep 5

# currently only working with latest git version, not with 1.0.0
# disable sip
# copy build file to /usr/local/bin/mysides
# sudo chown root:wheel "/usr/local/bin/mysides"
# sudo chmod 755 "/usr/local/bin/mysides"
#mysides remove all
#
#mysides remove "Alle meine Dateien"
#mysides remove myDocuments.cannedSearch
#mysides remove iCloud
#mysides add domain-AirDrop nwnode://domain-AirDrop
mysides remove domain-AirDrop >/dev/null 2>&1
mysides add Applications file:///Applications
mysides add Desktop file:///Users/${USER}/Desktop
mysides add Documents file:///Users/${USER}/Documents
mysides add Downloads file:///Users/${USER}/Downloads
mysides add Movies file:///Users/${USER}/Movies
mysides add Music file:///Users/${USER}/Music
mysides add Pictures file:///Users/${USER}/Pictures
mysides add ${USER} file:///Users/${USER}

# user specific customization
SCRIPT_NAME="finder_sidebar_$USER"
SCRIPT_DIR_DEFAULTS_WRITE=$(echo "$(cd "${BASH_SOURCE[0]%/*}" && cd .. && cd .. && pwd)")
SCRIPT_DIR_INPUT_KEEP="$SCRIPT_DIR_DEFAULTS_WRITE"/_scripts_input_keep
if [[ -e "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh ]]
then
    echo ''
    echo "user specific sidebar customization script found..."
    USER_ID=`id -u`
    chown "$USER_ID":staff "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    chmod 700 "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    . "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
else
    echo ''
    echo "user specific sidebar customization script not found......"
    :
fi
echo ''

#touch ~/Library/Preferences/com.apple.sidebarlists.plist
#if [[ -e ~/Library/Preferences/com.apple.sidebarlists.plist ]]
#then
#	rm ~/Library/Preferences/com.apple.sidebarlists.plist
#else
#	:
#fi


### run applescript to set sidebar preferences
SCRIPT_DIR=$(echo "$(cd "${BASH_SOURCE[0]%/*}" && pwd)")
#open /"$SCRIPT_DIR"/11f_script_finder_sidebar/11f_finder_sidebar.app

function enable_disable_finder_sidebar_items() {
#osascript 2>/dev/null <<EOF
osascript <<EOF

tell application "System Events"
	
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
	
	tell process "Finder"
		set frontmost to true
		#click menu item "Einstellungen …" of menu "Finder" of menu bar item "Finder" of menu bar 1
		keystroke "," using {command down}
		delay 1
		#click button "Seitenleiste" of toolbar 1 of window "Finder-Einstellungen"
		click button 3 of toolbar 1 of window 1
		delay 1
		# zugang zu meinem mac
		#set theCheckbox to checkbox "iCloud Drive" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 11 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		# computer
		set host_name to (do shell script "echo $HOSTNAME")
		--return host_name
		# last used
		#set theCheckbox to checkbox host_name of window "Finder-Einstellungen"
		set theCheckbox to checkbox 1 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		# airdrop
		#set theCheckbox to checkbox host_name of window "Finder-Einstellungen"
		set theCheckbox to checkbox 2 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		# my computer
		#set theCheckbox to checkbox host_name of window "Finder-Einstellungen"
		set theCheckbox to checkbox 12 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		# festplatten
		#set theCheckbox to checkbox "Festplatten" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 13 of window 1
		click theCheckbox
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is false then click theCheckbox
		end tell
		delay 0.2
		# externe festplatten
		#set theCheckbox to checkbox "Externe Festplatten" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 14 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is false then click theCheckbox
		end tell
		delay 0.2
		# cds, dvds, ipods
		#set theCheckbox to checkbox "CDs, DVDs und iPods" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 15 of window 1
		click theCheckbox
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is false then click theCheckbox
		end tell
		delay 0.2
		# bonjour
		#set theCheckbox to checkbox "Bonjour-Computer" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 16 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		# verbundene server
		#set theCheckbox to checkbox "Verbundene Server" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 17 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is false then click theCheckbox
		end tell
		delay 0.2
		# tags
		#set theCheckbox to checkbox "Benutzte Tags" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 18 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		#
		delay 1
		#tell application "Finder" to close window "Finder-Einstellungen"
		tell application "Finder" to close window 1
		
	end tell
	
	tell process frontAppName
		set frontmost to true
	end tell
	
end tell

EOF
}
enable_disable_finder_sidebar_items

# do not show icloud drive in drives
defaults write com.apple.finder SidebarShowingiCloudDesktop -bool false
defaults write com.apple.finder SidebarShowingSignedIntoiCloud -bool false

# show tags
defaults write com.apple.finder ShowRecentTags -bool false

# settings are in 
# ~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.FavoriteVolumes.sfl2
# and
# ~/Library/Application Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.FavoriteItems.sfl2


### restarting finder
killall cfprefsd
killall Finder

sleep 5

function enable_disable_finder_sidebar_items2() {
#osascript 2>/dev/null <<EOF
osascript <<EOF

tell application "System Events"
	
	set frontApp to first application process whose frontmost is true
	set frontAppName to name of frontApp
	
	tell process "Finder"
		set frontmost to true
		#click menu item "Einstellungen …" of menu "Finder" of menu bar item "Finder" of menu bar 1
		keystroke "," using {command down}
		delay 1
		#click button "Seitenleiste" of toolbar 1 of window "Finder-Einstellungen"
		click button 3 of toolbar 1 of window 1
		delay 1
		# icloud drive
		#set theCheckbox to checkbox "iCloud Drive" of window "Finder-Einstellungen"
		set theCheckbox to checkbox 11 of window 1
		tell theCheckbox
			set checkboxStatus to value of theCheckbox as boolean
			if checkboxStatus is true then click theCheckbox
		end tell
		delay 0.2
		#
		delay 1
		#tell application "Finder" to close window "Finder-Einstellungen"
		tell application "Finder" to close window 1
		
	end tell
	
	tell process frontAppName
		set frontmost to true
	end tell
	
end tell

EOF
}
enable_disable_finder_sidebar_items2


### removing security permissions
remove_apps_security_permissions_stop


echo "done ;)"
echo "the changes need a reboot to take effect..."
#echo "initializing reboot"
echo ""


#osascript -e 'tell app "loginwindow" to «event aevtrrst»'       # reboot
#osascript -e 'tell app "loginwindow" to «event aevtrsdn»'       # shutdown
#osascript -e 'tell app "loginwindow" to «event aevtrlgo»'       # logout