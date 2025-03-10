#!/bin/bash


### variables
SCRIPT_DIR=$(echo "$(cd "${BASH_SOURCE[0]%/*}" && pwd)")


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

identify_terminal
databases_apps_security_permissions


### applist
# "System Events" has to be first list entry and has to be confirmed manually
APP_LIST=(
# keep "BL Banking Launcher" and brew_casks_update after "System Events" at the beginning in this order for the clicks to work
"System Events"
"BL Banking Launcher"
"brew_casks_update															/Applications/brew_casks_update.app"
iTerm
Terminal
Finder
XtraFinder
video_720p_h265_aac_shrink
gui_apps_backup
decrypt_finder_input_gpg_progress
unarchive_finder_input_tar_gz_gpg_preserve_permissions_progress
"Overflow 3"
"Script Editor"
"System Preferences"
witchdaemon
VirtualBox
PasswordWallet
"VirtualBox Menulet"
"Bartender 3"
"Ondesoft AudioBook Converter"
"VNC Viewer"
"Commander One"
"Alfred 3"
GeburtstagsChecker
pdf_200dpi_shrink
iTunes
Mail
backup_files_tar_gz
virtualbox_backup
"run_on_login_signal														/Users/$USER/Library/Scripts/run_on_login_signal.app"
"run_on_login_whatsapp														/Users/$USER/Library/Scripts/run_on_login_whatsapp.app"
EagleFiler
"iStat Menus"
MacPass
)

### creating profiles
for APP_LINE in "${APP_LIST[@]}"
do

	sqlite3 "$DATABASE_USER" "delete from access where service='kTCCServiceAppleEvents';"

	if [[ $(echo "$APP_LINE" | awk '{gsub("\t","  ",$0); print;}' | awk -F ' \{2,\}' '{print $2}' | sed 's/^ //g' | sed 's/ $//g') == "" ]]
	then
		APP_ENTRY="$APP_LINE"
		APP_ENTRY_OPEN="$APP_LINE"
	else
		APP_ENTRY=$(echo "$APP_LINE" | awk '{gsub("\t","  ",$0); print;}' | awk -F ' \{2,\}' '{print $1}' | sed 's/^ //g' | sed 's/ $//g')
		APP_ENTRY_OPEN=$(echo "$APP_LINE" | awk '{gsub("\t","  ",$0); print;}' | awk -F ' \{2,\}' '{print $2}' | sed 's/^ //g' | sed 's/ $//g')
	fi
	echo ''	
	echo "$APP_ENTRY"
	#echo "$APP_ENTRY_OPEN"
	
	if [[ "$APP_ENTRY" == "$SOURCE_APP_NAME" ]]
	then
		:
	else
		
		sleep 0.5
		
		if [[ "$APP_ENTRY" == "System Events" ]]
		then
			:
		else
			sqlite3 "$DATABASE_USER" "REPLACE INTO access VALUES('kTCCServiceAppleEvents','"$SOURCE_APP"',0,1,1,?,NULL,0,'com.apple.systemevents',?,NULL,?);"
		fi
		
		sleep 0.5
		
		osascript -e "tell application \"$APP_ENTRY_OPEN\" to «event BATFinit»" &
		
		if [[ "$APP_ENTRY" == "BL Banking Launcher" ]]
		then
			:
		else
			sleep 1
		fi
		
		osascript <<EOF
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
		# no delay after first tries needed for "BL Banking Launcher" and brew_casks_update
		#delay 2
		
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
		delay 1
		
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
		delay 2
		
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
		delay 3
		
		try
			tell application "System Events" 
				tell process "UserNotificationCenter" 
					click button "OK" of window 1
				end tell
			end tell
		end try
		
EOF
	
	
		# special events after opening the app
		if [[ "$APP_ENTRY" == "Bartender 3" ]] || [[ "$APP_ENTRY" == "Finder" ]] || [[ "$APP_ENTRY" == "Alfred 3" ]] || [[ "$APP_ENTRY" == "GeburtstagsChecker" ]] || [[ "$APP_ENTRY" == "VirtualBox Menulet" ]] || [[ "$APP_ENTRY" == "iTerm" ]] || [[ "$APP_ENTRY" == "Terminal" ]] || [[ "$APP_ENTRY" == "Overflow 3" ]]
		then
			:
		elif [[ "$APP_ENTRY" == "XtraFinder" ]]
		then
			osascript <<EOF
			tell application "System Events"
				tell application "XtraFinder" to activate
				delay 2
				tell application "System Events"
					keystroke "w" using command down
				end tell
			end tell
EOF
		elif [[ "$APP_ENTRY" == "brew_casks_update" ]]
		then
			sqlite3 "$DATABASE_USER" "REPLACE INTO access VALUES('kTCCServiceAppleEvents','"$SOURCE_APP"',0,1,1,?,NULL,0,'com.apple.Terminal',?,NULL,?);"
			#sleep 3
			while [[ $(ps aux | grep /brew_casks_update.sh | grep -v grep) == "" ]]
			do 
			osascript <<EOF
			try
				tell application "System Events" 
					tell process "UserNotificationCenter" 
						click button "OK" of window 1
					end tell
				end tell
			end try
			delay 1
EOF
			done
			sleep 3
			while ps aux | grep /brew_casks_update.sh | grep -v grep > /dev/null;
			do 
			osascript <<EOF
			try
				tell application "Terminal"
					close (every window whose name contains "brew_casks_update")
					delay 2
					tell application "System Events"
						keystroke return
					end tell
				end tell
			end try
EOF
			done

		elif [[ "$APP_ENTRY" == "BL Banking Launcher" ]]
		then
			sqlite3 "$DATABASE_USER" "REPLACE INTO access VALUES('kTCCServiceAppleEvents','"$SOURCE_APP"',0,1,1,?,NULL,0,'com.apple.Terminal',?,NULL,?);"
			#sleep 3
			while [[ $(ps aux | grep /veracrypt_mount_blbanking.sh | grep -v grep) == "" ]]
			do 
			osascript <<EOF
			try
				tell application "System Events" 
					tell process "UserNotificationCenter" 
						click button "OK" of window 1
					end tell
				end tell
			end try
			delay 1
EOF
			done
			sleep 3
			while ps aux | grep /veracrypt_mount_blbanking.sh | grep -v grep > /dev/null;
			do 
			osascript <<EOF
			try
				tell application "Terminal"
					close (every window whose name contains "_blbanking")
					delay 2
					tell application "System Events"
						keystroke return
					end tell
				end tell
			end try
EOF
			done
		
		elif [[ "$APP_ENTRY" == "gui_apps_backup" ]] || [[ "$APP_ENTRY" == "backup_files_tar_gz" ]] || [[ "$APP_ENTRY" == "virtualbox_backup" ]]
		then
			pkill -f "$APP_ENTRY"
		else
			osascript <<EOF
			try
				tell application "$APP_ENTRY"
					quit
				end tell
			end try
EOF
		fi
		
		#sleep 1
			
		# delete entries with NULL value
		sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and indirect_object_code_identity IS NULL);"
		
		# getting values from latest entry in the database
		# client bundle id
		SOURCE_APP_ID=$(sqlite3 "$DATABASE_USER" "select client from access where service='kTCCServiceAppleEvents' order by rowid asc limit 1")
		# client csreq
		SOURCE_APP_CSREQ=$(sqlite3 "$DATABASE_USER" "select quote(csreq) from access where service='kTCCServiceAppleEvents' order by rowid asc limit 1")
		# destination bundle id
		AUTOMATED_APP_ID=$(sqlite3 "$DATABASE_USER" "select indirect_object_identifier from access where service='kTCCServiceAppleEvents' order by rowid asc limit 1")
		# destination csreq
		AUTOMATED_APP_CSREQ=$(sqlite3 "$DATABASE_USER" "select quote(indirect_object_code_identity) from access where service='kTCCServiceAppleEvents' order by rowid asc limit 1")
		
		# writing values to profile file
		# automated app
		touch "$SCRIPT_DIR"/"$APP_ENTRY".txt
		chown $USER:staff "$SCRIPT_DIR"/"$APP_ENTRY".txt
		chmod 600 "$SCRIPT_DIR"/"$APP_ENTRY".txt
		#
		echo "$APP_ENTRY" > "$SCRIPT_DIR"/"$APP_ENTRY".txt
		echo "$AUTOMATED_APP_ID" >> "$SCRIPT_DIR"/"$APP_ENTRY".txt
		echo "$AUTOMATED_APP_CSREQ" >> "$SCRIPT_DIR"/"$APP_ENTRY".txt
	
	fi

done

# writing values to profile file
# source app
touch "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt
chown $USER:staff "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt
chmod 600 "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt
#
echo "$SOURCE_APP_NAME" > "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt
echo "$SOURCE_APP_ID" >> "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt
echo "$SOURCE_APP_CSREQ" >> "$SCRIPT_DIR"/"$SOURCE_APP_NAME".txt