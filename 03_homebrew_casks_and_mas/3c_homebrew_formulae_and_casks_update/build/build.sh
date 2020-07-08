#!/bin/zsh

###
### sourcing config file
###

if [[ -f ~/.shellscriptsrc ]]; then . ~/.shellscriptsrc; else echo '' && echo -e '\033[1;31mshell script config file not found...\033[0m\nplease install by running this command in the terminal...\n\n\033[1;34msh -c "$(curl -fsSL https://raw.githubusercontent.com/tiiiecherle/osx_install_config/master/_config_file/install_config_file.sh)"\033[0m\n' && exit 1; fi
eval "$(typeset -f env_get_shell_specific_variables)" && env_get_shell_specific_variables



###
### build
###

APP_NAME_VERSIONS=(
"brew_casks_update"
)

SCRIPTS_FINAL_DIR="$SCRIPT_DIR_THREE_BACK"
BUILD_DIR="$SCRIPT_DIR_ONE_BACK"
	
for APP_NAME in "${APP_NAME_VERSIONS[@]}"
do
	
	echo ''
	printf "\033[1m%s\033[00m %s\n" "processing $APP_NAME"
	echo ''
	
	# icon name
	if [[ -e "$BUILD_DIR"/icons/"$APP_NAME".icns ]]
	then
		ICON_NAME="$APP_NAME"
	else
		ICON_NAME=$(find "$BUILD_DIR"/icons -maxdepth 1 -mindepth 1 -type f -name "*.icns")
		if [[ $(echo "$ICON_NAME" | wc -l | awk '{print $1}') != "1" ]]
		then
			echo "ICON_NAME is not set correctly, exiting..."
			exit
		else
			ICON_NAME=$(basename "$ICON_NAME" .icns)
		fi
	fi
	echo "ICON_NAME is "$ICON_NAME"..."
	
	# script name
	if [[ -e "$BUILD_DIR"/shell_script/"$APP_NAME".sh ]]
	then
		SCRIPT_NAME="$APP_NAME"
	else
		SCRIPT_NAME=$(find "$BUILD_DIR"/shell_script -maxdepth 1 -mindepth 1 -type f -name "*.sh")
		if [[ $(echo "$SCRIPT_NAME" | wc -l | awk '{print $1}') != "1" ]]
		then
			echo "SCRIPT_NAME is not set correctly, exiting..."
			exit
		else
			SCRIPT_NAME=$(basename "$SCRIPT_NAME" .sh)
		fi
	fi
	echo "SCRIPT_NAME is "$SCRIPT_NAME"..."
	
	# checking dependencies
	for i in brew python3
	do
		if command -v "$i" &> /dev/null
    	then
    		# installed
    		:
    	else
    		echo ''
    		echo ""$i" is not installed, exiting..."
    		echo ''
    		exit
    	fi
    done
    
	echo ''
	# setting icons
	chmod 770 "$BUILD_DIR"/icons/icon_set_python3.py
	#sudo pip install pyobjc
	pip3 install pyobjc-framework-Cocoa | grep -v "already satisfied"
	python3 "$BUILD_DIR"/icons/icon_set_python3.py "$BUILD_DIR"/icons/"$ICON_NAME".icns "$BUILD_DIR"/app/"$APP_NAME".app
	for i in applet droplet AutomatorApplet
	do
		if [[ -e "$BUILD_DIR"/app/"$APP_NAME".app/Contents/Resources/"$i".icns ]]; then cp -a "$BUILD_DIR"/icons/"$ICON_NAME".icns "$BUILD_DIR"/app/"$APP_NAME".app/Contents/Resources/"$i".icns; else :; fi
	done
		
	echo copying content to app and setting permissions...
	# .app final configuration
	mkdir -p "$BUILD_DIR"/app/"$APP_NAME".app/Contents/custom_files
	cp -a "$BUILD_DIR"/shell_script/"$SCRIPT_NAME".sh "$BUILD_DIR"/app/"$APP_NAME".app/Contents/custom_files/
	cp -a "$BUILD_DIR"/icons/"$ICON_NAME".icns "$BUILD_DIR"/app/"$APP_NAME".app/Contents/custom_files/
	chown 501:admin "$BUILD_DIR"/app/"$APP_NAME".app
	chown -R 501:admin "$BUILD_DIR"/app/"$APP_NAME".app/Contents/custom_files/
	chmod 755 "$BUILD_DIR"/app/"$APP_NAME".app
	chmod 770 "$BUILD_DIR"/app/"$APP_NAME".app/Contents/custom_files/"$SCRIPT_NAME".sh
	# https://developer.apple.com/library/archive/qa/qa1940/_index.html
	xattr -cr "$BUILD_DIR"/app/"$APP_NAME".app
	
	# this is to suppress warning on first start
	#echo opening app...
	#open "$BUILD_DIR"/app/"$APP_NAME".app
		
	echo copying app to dmg...
	#cp -a "$BUILD_DIR"/app/"$APP_NAME".app "$PATH_TO_APPS"/
	mkdir -p "$BUILD_DIR"/dmg/"$APP_NAME"/
	if [[ -e "$BUILD_DIR"/dmg/"$APP_NAME"/app/"$APP_NAME".app ]]
	then
		rm -rf "$BUILD_DIR"/dmg/"$APP_NAME"/app/"$APP_NAME".app
	else
		:
	fi
	cp -a "$BUILD_DIR"/app/"$APP_NAME".app "$BUILD_DIR"/dmg/"$APP_NAME"/app/"$APP_NAME".app
	chmod 770 "$BUILD_DIR"/dmg/"$APP_NAME"/run_to_install.command
	
	echo building dmg...
	if [[ -e "$BUILD_DIR"/"$APP_NAME".dmg ]]
	then
		rm "$BUILD_DIR"/"$APP_NAME".dmg
	else
		:
	fi
	
	# non writable dmg
	hdiutil create -volname "$APP_NAME" -srcfolder "$BUILD_DIR"/dmg/"$APP_NAME"/ -ov -format UDZO "$BUILD_DIR"/"$APP_NAME".dmg
	
	# copy app to script dir
	echo ''
	echo "copying app to backup script dir..."
	mkdir -p "$SCRIPTS_FINAL_DIR"/07_backup_and_restore_script/update_homebrew
	if [[ -e "$SCRIPTS_FINAL_DIR"/07_backup_and_restore_script/update_homebrew/"$APP_NAME".app ]]
	then
		rm -rf "$SCRIPTS_FINAL_DIR"/07_backup_and_restore_script/update_homebrew/"$APP_NAME".app
	else
		:
	fi
	cp -a "$BUILD_DIR"/app/"$APP_NAME".app "$SCRIPTS_FINAL_DIR"/07_backup_and_restore_script/update_homebrew/"$APP_NAME".app

done

echo ''
echo "done ;)"
echo ''
