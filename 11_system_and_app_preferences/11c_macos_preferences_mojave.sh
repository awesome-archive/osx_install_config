#!/usr/bin/env bash

###
### asking password upfront
###

# function for reading secret string (POSIX compliant)
enter_password_secret()
{
    # read -s is not POSIX compliant
    #read -s -p "Password: " SUDOPASSWORD
    #echo ''
    
    # this is POSIX compliant
    # disabling echo, this will prevent showing output
    stty -echo
    # setting up trap to ensure echo is enabled before exiting if the script is terminated while echo is disabled
    trap 'stty echo' EXIT
    # asking for password
    printf "Password: "
    # reading secret
    read -r "$@" SUDOPASSWORD
    # reanabling echo
    stty echo
    trap - EXIT
    # print a newline because the newline entered by the user after entering the passcode is not echoed. This ensures that the next line of output begins at a new line.
    printf "\n"
    # making sure builtin bash commands are used for using the SUDOPASSWORD, this will prevent showing it in ps output
    # has to be part of the function or it wouldn`t be updated during the maximum three tries
    #USE_PASSWORD='builtin echo '"$SUDOPASSWORD"''
    USE_PASSWORD='builtin printf '"$SUDOPASSWORD\n"''
}

# unset the password if the variable was already set
unset SUDOPASSWORD

# making sure no variables are exported
set +a

# asking for the SUDOPASSWORD upfront
# typing and reading SUDOPASSWORD from command line without displaying it and
# checking if entered password is the sudo password with a set maximum of tries
NUMBER_OF_TRIES=0
MAX_TRIES=3
while [ "$NUMBER_OF_TRIES" -le "$MAX_TRIES" ]
do
    NUMBER_OF_TRIES=$((NUMBER_OF_TRIES+1))
    #echo "$NUMBER_OF_TRIES"
    if [ "$NUMBER_OF_TRIES" -le "$MAX_TRIES" ]
    then
        enter_password_secret
        ${USE_PASSWORD} | sudo -k -S echo "" > /dev/null 2>&1
        if [ $? -eq 0 ]
        then 
            break
        else
            echo "Sorry, try again."
        fi
    else
        echo ""$MAX_TRIES" incorrect password attempts"
        exit
    fi
done

# setting up trap to ensure the SUDOPASSWORD is unset if the script is terminated while it is set
trap 'unset SUDOPASSWORD' EXIT

# replacing sudo command with a function, so all sudo commands of the script do not have to be changed
sudo()
{
    ${USE_PASSWORD} | builtin command sudo -p '' -k -S "$@"
    #${USE_PASSWORD} | builtin command -p sudo -p '' -k -S "$@"
    #${USE_PASSWORD} | builtin exec sudo -p '' -k -S "$@"
}



###
### documentation
###

# reading globaldomain values
# defaults read NSGlobalDomain


###
### functions
###

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
        AUTOMATED_APP=com.apple.systemevents
        sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"');"
        AUTOMATED_APP=com.apple.systempreferences
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
        AUTOMATED_APP=com.apple.systemevents
        # macos versions 10.14 and up
        if [[ $SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1 == "yes" ]]
        then
            # source app was already allowed to control app before running this script, so don`t delete the permission
            :
        else
            sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"');"
        fi
        #
        AUTOMATED_APP=com.apple.systempreferences
        if [[ $SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP2 == "yes" ]]
        then
            # source app was already allowed to control app before running this script, so don`t delete the permission
            :
        else
            sqlite3 "$DATABASE_USER" "delete from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"');"
        fi
    fi
}


###
### variables
###

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


###

echo''    
databases_apps_security_permissions
identify_terminal

if [[ $(echo $MACOS_VERSION | cut -f1,2 -d'.' | cut -f2 -d'.') -le "13" ]]
then
    # macos versions until and including 10.13 
	:
else
    echo "setting security permissions..."
    AUTOMATED_APP=com.apple.systemevents
    if [[ $(sqlite3 "$DATABASE_USER" "select * from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"' and allowed='1');") != "" ]]
	then
	    SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1="yes"
	    #echo "$SOURCE_APP is already allowed to control $AUTOMATED_APP..."
	else
		SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP1="no"
		#echo "$SOURCE_APP is not allowed to control $AUTOMATED_APP..."
		give_apps_security_permissions
	fi
	#
	AUTOMATED_APP=com.apple.systempreferences
	if [[ $(sqlite3 "$DATABASE_USER" "select * from access where (service='kTCCServiceAppleEvents' and client='"$SOURCE_APP"' and indirect_object_identifier='"$AUTOMATED_APP"' and allowed='1');") != "" ]]
	then
	    SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP2="yes"
	    #echo "$SOURCE_APP is already allowed to control $AUTOMATED_APP..."
	else
		SOURCE_APP_IS_ALLOWED_TO_CONTROL_APP2="no"
		#echo "$SOURCE_APP is not allowed to control $AUTOMATED_APP..."
		give_apps_security_permissions
	fi
    echo ''
fi

# trap
trap 'printf "\n"; remove_apps_security_permissions_stop' SIGHUP SIGINT SIGTERM EXIT


### uuid

#uuid1=$(system_profiler SPHardwareDataType | grep "Hardware UUID" | awk -F":" '{print $2}' | awk '{gsub(/^[ \t]+|[ \t]+$/, "")}1')
#uuid1=$(/usr/sbin/system_profiler SPHardwareDataType | grep "Hardware UUID" | cut -c22-57)
uuid1=$(python  -c 'import uuid; print uuid.uuid1()')

echo "user uuid is $uuid1"
echo ''


### displayid

#displayid=$(/usr/libexec/PlistBuddy -c 'Print com.apple.AmbientDisplay.LUT' ~/Library/Preferences/ByHost/.GlobalPreferences.13C818AE-B18F-56C7-99D0-690513D860A9.plist | tail -n 4 | head -n 1 | awk -F" " '{print $1}')
#displayid=$(sudo defaults read /Library/Preferences/com.apple.windowserver.plist | grep DisplayID | head -n 1 | awk -F"=" '{print $2}' | sed 's/[ \t]//g' | sed 's/;//g')
#displayid1=$(eval echo '"'"$displayid"'"')

#echo "my displayid is $displayid1"


###
### setting preferences
###

function setting_preferences {

    ###
    ### menu bar
    ###
    
    echo "menu bar"
    
    # turning off the clock in the menu bar
    function disable_menu_bar_clock() {
    #osascript 2>/dev/null <<EOF
    osascript <<EOF
    
    tell application "System Preferences"
    	activate
    	set current pane to pane "com.apple.preference.datetime"
    	#set tabnames to (get the name of every anchor of pane id "com.apple.preference.datetime")
    	#display dialog tabnames
    	get the name of every anchor of pane id "com.apple.preference.datetime"
    	reveal anchor "ClockPref" of pane id "com.apple.preference.datetime"
    end tell
    
    delay 2
    
    tell application "System Events"
    	tell process "System Preferences"
    		delay 0.5
    		#set theCheckbox to checkbox "Datum und Uhrzeit in der Menüleiste anzeigen" of tab group 1 of window 1
		    set theCheckbox to checkbox 3 of tab group 1 of window 1
    		tell theCheckbox
    			set checkboxStatus to value of theCheckbox as boolean
    			if checkboxStatus is true then click theCheckbox
    		end tell
    		delay 1
    	end tell
    end tell
    
    delay 2
    
    tell application "System Preferences"
    	quit
    end tell
    
EOF
    }
    disable_menu_bar_clock

    # show these menu bar icons
    defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu"
    # for keyboard use TextInput.menu
    
    # adding a single entry - example vpn
    #defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/vpn.menu"
    #killall SystemUIServer -HUP
    
    sleep 2
    killall SystemUIServer
    sleep 5
    
    # hide these menu bar icons
    defaults write ~/Library/Preferences/ByHost/com.apple.systemuiserver.$uuid1.plist dontAutoLoad -array \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/User.menu"
    
    NotPreferredMenuExtras=(
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"
    "/System/Library/CoreServices/Menu Extras/Volume.menu"
    "/System/Library/CoreServices/Menu Extras/Clock.menu"
    "/System/Library/CoreServices/Menu Extras/User.menu"
    )
    
    # it seems deleting entries needs a reboot for the changes to take effect
    # killall SystemUIServer -HUP is not enough
    for varname in "${NotPreferredMenuExtras[@]}"; 
    do
        /usr/libexec/PlistBuddy -c "Delete 'menuExtras:$(defaults read ~/Library/Preferences/com.apple.systemuiserver.plist menuExtras | cat -n | grep "$varname" | awk '{print SUM $1-2}') string'" ~/Library/Preferences/com.apple.systemuiserver.plist >/dev/null 2>&1
        :
    done
    
    sleep 2
    killall SystemUIServer -HUP
    sleep 5
    
    ### menu bar battery preferences
    
    # show battery percentage in menu bar
    defaults write com.apple.menuextra.battery ShowPercent -string "YES"
    
    ## show remaining battery time in menu bar
    #defaults write com.apple.menuextra.battery ShowTime -string "NO"
    
    
    
    ###
    ### preferences - general
    ###
    
    echo "preferences general"
    
    # interface appearance
    # becomes active after logout
    # light
    #defaults write -g AppleInterfaceStyle -string "Light"
    #defaults delete -g AppleInterfaceStyle
    # dark
    #defaults write -g AppleInterfaceStyle -string "Dark"
    
    # immediate change
    # light    			
    osascript -e '
    tell application id "com.apple.systemevents"
    	tell appearance preferences
    		if dark mode is true then
    			set dark mode to false
    		end if
    	end tell
    end tell
    '
    # dark
    #osascript -e '
    #tell application id "com.apple.systemevents"
    #	tell appearance preferences
    #		if dark mode is false then
    #			set dark mode to true
    #		end if
    #	end tell
    #end tell
    #'
    
    # color (1=blue,8=graphit)
    ##
    defaults write -g AppleAquaColorVariant -int 1
    
    # highlight color
    # example green
    #defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"
    # reset to default (blue)
    #defaults delete -g AppleHighlightColor
    
    # set sidebar icon size
    # 1=small, 2=medium, 3=big
    defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 1
        
    # autohide menu bar
    # 0=no, 1=yes
    ##
    defaults write NSGlobalDomain _HIHideMenuBar -int 0
    
    # show scrollbars
    # possible values: WhenScrolling, Automatic, Always
    defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
    
    # click in the scroll bar to
    # false: jump to the next page
    # true: jump to the spot that's clicked
    defaults write -g AppleScrollerPagingBehavior -bool true
    
    # default web browser
    # see separate script defaults_open_with.sh
    
    # ask if changes of documents shall be confirmed when closing
    # false = off, true = on
    defaults write -g NSCloseAlwaysConfirmsChanges -bool true
    
    # resume apps system-wide (open windows are not restored when closing and re-opening an app)
    # true = off, false = on
    defaults write -g NSQuitAlwaysKeepsWindows -bool false
    
    # recent documents
    ##
    defaults write NSGlobalDomain NSRecentDocumentsLimit 10
    
    # setting handoff
    # false = off, true = on
    ##
    defaults write ByHost/com.apple.coreservices.useractivityd.${uuid1} ActivityAdvertisingAllowed -bool true
    defaults write ByHost/com.apple.coreservices.useractivityd.${uuid1} ActivityReceivingAllowed -bool true
    
    # Enable subpixel font rendering on non-Apple LCDs
    # 0 = standard - best for crt setting in 10.5 and earlier
    # 1 = light
    # 2 = medium - best for flat panel
    # 3 = strong
    #defaults write NSGlobalDomain AppleFontSmoothing -int 2
    
    
    
    ###
    ### preferences - screen saver and wallpaper
    ###
    
    echo "preferences wallpaper & screensaver"
    
    # setting desktop wallpaper
    # getting info
    #osascript -e 'tell application "System Events" to get properties of every desktop'
    
    # set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
    # all wallpapers are in `/Library/Desktop Pictures/`.
    # default additionally is in /System/Library/CoreServices/
    
    #rm -rf ~/Library/Application Support/Dock/desktoppicture.db
    #sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
    #sudo ln -s /Users/tom/Downloads/"nameofpictures".jpg /System/Library/CoreServices/DefaultDesktop.jpg
    #
    # or
    #
    # osascript -e 'tell application "System Events" to set picture of every desktop to ("/Users/tom/Desktop/testpicture.jpg" as POSIX file as alias)'
    
    # default dynamic
    osascript -e 'tell application "System Events" to set picture of every desktop to ("/Library/Desktop Pictures/Mojave.heic" as POSIX file as alias)' 
    # default static
    #osascript -e 'tell application "System Events" to set picture of every desktop to ("/Library/Desktop Pictures/Mojave Day.jpg" as POSIX file as alias)' 
    
    # screen saver: 
    # defaults -currentHost read com.apple.screensaver
    # defaults -currentHost read com.apple.ScreenSaver.iLifeSlideShows
    
    # non-random
    #defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName -string "iLifeSlideshows" path -string "/System/Library/Frameworks/ScreenSaver.framework/Resources/iLifeSlideshows.saver" type -int 0
    # example origami
    #defaults -currentHost write com.apple.ScreenSaver.iLifeSlideShows styleKey -string Origami
    # or 
    #defaults -currentHost write com.apple.screensaver moduleDict -dict path -string "/System/Library/Screen Savers/Flurry.saver" moduleName -string "Flurry" type -int 0

    # random
    #defaults -currentHost write com.apple.screensaver moduleDict -dict moduleName -string "Random" path -string "/System/Library/Screen Savers/Random.saver" type -int 8
    
    # idle time
    # time in seconds
    # never start = 0
    defaults -currentHost write com.apple.ScreenSaver idleTime -int 0
    
    # show clock
    defaults -currentHost write com.apple.ScreenSaver showClock -bool true

    
    
    ###
    ### preferences dock
    ###
    
    echo "preferences dock"
    
    # enable highlight hover effect for the grid view of a stack (dock)
    #defaults write com.apple.dock mouse-over-hilite-stack -bool true
    
    # set the icon size of Dock items
    defaults write com.apple.dock tilesize -int 53
    
    # magnification of dock items and size
    defaults write com.apple.dock magnification -bool true
    defaults write com.apple.dock largesize -int 72
    
    # dock position bottom, left, right
    ##
    defaults write com.apple.dock orientation -string "bottom"
    
    # minimize/maximize window effect
    # options: scale, genie
    ##
    defaults write com.apple.dock mineffect -string "genie"
    
    # prefer tabs when opening documents
    # always, fullscreen or manual
    defaults write -g AppleWindowTabbingMode -string always
    
    # double-click a window's title bar to minimize
    # true = minimize, false = zoom
    ##
    defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false
    
    # minimize windows into their applications icon
    ##
    defaults write com.apple.dock minimize-to-application -bool false
    
    # enable spring loading for all dock items
    #defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true
    
    # animate opening applications from the dock
    ##
    defaults write com.apple.dock launchanim -bool true
    
    # automatically hide and show the dock
    defaults write com.apple.dock autohide -bool true
    
    # show indicator lights for open applications in the dock
    ##
    defaults write com.apple.dock show-process-indicators -bool true
    
    # show last used applications in the dock
    #
    defaults write com.apple.dock show-recents -bool false
    
    
    ### hidden dock tweaks
    
    # add a spacer to the left side of the dock (where the applications are)
    #defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
    
    # add a spacer to the right side of the Dock (where the folders are)
    #defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'
    
    # make dock icons of hidden applications translucent
    defaults write com.apple.dock showhidden -bool true
    
    # remove the auto-hiding dock delay
    #defaults write com.apple.dock autohide-delay -float 0
    
    # remove the animation when hiding/showing the dock
    #defaults write com.apple.dock autohide-time-modifier -float 0
    
    
    
    ###
    ### preferences mission control
    ###
    
    echo "preferences mission control"
    
    # automatically rearrange spaces based on most recent use
    defaults write com.apple.dock mru-spaces -bool false
    
    # when switching applications, switch to respective space
    ##
    defaults write -g AppleSpacesSwitchOnActivate -bool true
    
    # group windows by application in mission control
    defaults write com.apple.dock expose-group-apps -bool true
    
    # monitors are using different spaces
    # false = yes, true = no
    ##
    defaults write com.apple.spaces spans-displays -bool false

    # dashboard as setting
    # 1 = disabled
    # 2 = enabled as space
    # 3 = enabled as overlay
    defaults write com.apple.dashboard db-enabled-state -int 1
    
    sleep 1
    if [ "$USER" == "wolfgang" ]
    then
        defaults write com.apple.dashboard db-enabled-state -int 2
    else
        :
    fi
    
    # disable dashboard completetly (must be reenabled on the command line, reboot and then enabled in the system preferences to work again)
    ##
    #defaults write com.apple.dashboard mcx-disabled -bool true
    
    # expose
    #
    # 32 = all windows, mission control
    # 33 = application windows
    # 36 = show desktop
    # 62 = dashboard
    # 73 = front row
    #
    # F9 = 101
    # F10 = 109
    # F11 = 103
    # F12 = 111
    #
    # 0 = no modifier
    # 131072 = Shift
    # 262144 = Control
    # 524288 = Option
    # 1048576 = Apple, cmd
    
    # disable all windows
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:32'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:enabled bool false'
    # or
    #defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "<dict><key>enabled</key><false/></dict>"
    
    # enable all windows on F9
    # doesn`t work because it does not set the data types like bool, string, integer
    #defaults write ~/Library/Preferences/com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 '{enabled = true; value = {parameters = (0, 101, 65535); type = standard; }; }'
    #
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "
      <dict>
        <key>enabled</key><true/>
        <key>value</key>
        <dict>
          <key>type</key>
          <string>standard</string>
          <key>parameters</key>
          <array>
            <integer>65535</integer>
            <integer>101</integer>
            <integer>0</integer>
          </array>
        </dict>
      </dict>
    "
    # or
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:32'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:enabled bool true'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:value:type string standard'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:value:parameters array'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:value:parameters:"Item 0" integer 0'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:value:parameters:"Item 1" integer 101'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:32:value:parameters:"Item 2" integer 65535'
    
    # disable application windows
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:33'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:enabled bool false'
    
    # enable application windows on F10
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 33 "
      <dict>
        <key>enabled</key>
        <true/>
        <key>value</key>
        <dict>
          <key>type</key>
          <string>standard</string>
          <key>parameters</key>
          <array>
            <integer>65535</integer>
            <integer>109</integer>
            <integer>0</integer>
          </array>
        </dict>
      </dict>
    "
    # or
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:33'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:enabled bool true'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:value:type string standard'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:value:parameters array'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:value:parameters:"Item 0" integer 0'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:value:parameters:"Item 1" integer 109'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:33:value:parameters:"Item 2" integer 65535'
    
    # disable show desktop
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:36'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:enabled bool false'
    
    # enable show desktop on F11
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 36 "
      <dict>
        <key>enabled</key>
        <true/>
        <key>value</key>
        <dict>
          <key>type</key>
          <string>standard</string>
          <key>parameters</key>
          <array>
            <integer>65535</integer>
            <integer>103</integer>
            <integer>0</integer>
          </array>
        </dict>
      </dict>
    "
    # or
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:36'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:enabled bool true'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:value:type string standard'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:value:parameters array'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:value:parameters:"Item 0" integer 0'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:value:parameters:"Item 1" integer 103'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:36:value:parameters:"Item 2" integer 65535'
    
    # disable dashboard
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:62'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:enabled bool false'
    
    # enable dashboard on F12
    defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 62 "
      <dict>
        <key>enabled</key><true/>
        <key>value</key><dict>
          <key>type</key><string>standard</string>
          <key>parameters</key>
          <array>
            <integer>65535</integer>
            <integer>111</integer>
            <integer>0</integer>
          </array>
        </dict>
      </dict>
    "
    # or
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Delete AppleSymbolicHotKeys:62'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:enabled bool true'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:value:type string standard'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:value:parameters array'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:value:parameters:"Item 0" integer 0'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:value:parameters:"Item 1" integer 111'
    #/usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist -c 'Add AppleSymbolicHotKeys:62:value:parameters:"Item 2" integer 65535'
    
    # hot corners
    # possible values:
    #  0: no-op
    #  2: mission control
    #  3: show application windows
    #  4: desktop
    #  5: start screen saver
    #  6: disable screen saver
    #  7: dashboard
    # 10: put display to sleep
    # 11: launchpad
    # 12: notification center
    
    # top left screen corner mission control
    #defaults write com.apple.dock wvous-tl-corner -int 2
    #defaults write com.apple.dock wvous-tl-modifier -int 0
    
    # top right screen corner desktop
    #defaults write com.apple.dock wvous-tr-corner -int 4
    #defaults write com.apple.dock wvous-tr-modifier -int 0
    
    # bottom left screen corner start screen saver
    #defaults write com.apple.dock wvous-bl-corner -int 5
    #defaults write com.apple.dock wvous-bl-modifier -int 0
    
    
    ### hidden mission control tweaks
    
    # speed up mission control animations
    defaults write com.apple.dock expose-animation-duration -float 0.1
    
    # don't show dashboard as a space
    #defaults write com.apple.dock dashboard-in-overlay -bool true
    
    
    
    ###
    ### preferences language and region
    ###
    
    echo "preferences language and region"
    
    # setup assistant language (system and login screen)
    sudo languagesetup -langspec de
    
    # set language and text formats
    # note: if you are in the US, replace `EUR` with `USD`, `Centimeters` with
    # `Inches`, `en_GB` with `en_US`, and `true` with `false`
    ##.
    defaults write NSGlobalDomain AppleLanguages -array "de-DE"
    defaults write NSGlobalDomain AppleLocale -string "de_DE"
    ##
    # 2 = monday
    # 3 = tuesday
    # ...
    defaults write NSGlobalDomain AppleFirstWeekday -array "gregorian = 2"
    ##
    # 12 hour clock
    # 12 hour clock of = 24 h clock on
    # be sure the system preferences window is not open when using this or it won`t work
    #defaults write NSGlobalDomain AppleICUForce12HourTime -bool false
    # will be set to AppleICUForce24HourTime later
    #defaults delete NSGlobalDomain AppleICUForce12HourTime
    ##
    defaults write NSGlobalDomain AppleTemperatureUnit -string "Celsius"
    ##
    defaults write NSGlobalDomain AppleLocale -string "de_DE@currency=EUR"
    ##
    defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
    ##
    defaults write NSGlobalDomain AppleMetricUnits -bool true
    ##
    # sort order phonebook german
    #defaults write NSGlobalDomain AppleCollationOrder -string "de@collation=phonebook"
    # sort order default (universal)
    defaults write NSGlobalDomain AppleCollationOrder -string "de@collation=universal"
    # or
    #defaults delete NSGlobalDomain AppleCollationOrder
    
    ###
    ### preferences - security
    ###
    
    echo "preferences security"
    
    ### security general
    
    # password required
    # 0 = no, 1 = yes
    defaults write com.apple.screensaver askForPassword -int 1
    
    # set time in seconds to wait until password after sleep or screen saver is required
    # 0 = immediatelly, e.g. 300 = 5 min
    ##
    defaults write com.apple.screensaver askForPasswordDelay -int 300
    
    # activate & define text for lockscreen
    #sudo defaults write /Library/Preferences/com.apple.loginwindow "LoginwindowText" 'yourtextgoeshere'
    
    # deactivate text for lockscreen
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow "LoginwindowText" ''
    
    #### security gate keeper
    
    # disable completely
    #sudo spctl --master-disable
    
    # enable only app store
    #sudo spctl --master-enable
    #sudo spctl --disable
    
    # enable app store and identified developers
    ##
    sudo spctl --master-enable
    sudo spctl --enable
    
    # using a gatekeeper whitelist
    #sudo spctl --add --label "GitHub" /Applications/GitHub.app
    #spctl --enable --label "GitHub"
    #spctl --disable --label "GitHub"
    
    
    #### security file vault
    
    # enabling filevault
    function enabling_filevault() {
        
        if [[ $(fdesetup isactive) == "true" ]]
        then
        	echo "filevault is already already turned on, skipping..."
        else
        	echo "enabling encryption of disk via filevault..."
        	FILEVAULT_KEYFILE="/Users/"$USER"/Desktop/filevault_key_"$USER".txt"
        	touch "$FILEVAULT_KEYFILE"
        	echo $(date) > "$FILEVAULT_KEYFILE"
        	echo "$USER" >> "$FILEVAULT_KEYFILE"
        	echo "filevault" >> "$FILEVAULT_KEYFILE"
        	TERMINALWIDTH=$(stty cbreak -echo size | awk '{print $2}')
            TERMINALWIDTH_WITHOUT_LEADING_SPACES=$(($TERMINALWIDTH-5))
		    FILEVAULTUSER="$USER"
            expect -c "
#log_user 0
#spawn sudo echo "$FILEVAULTUSER"
#expect \"Password:\"
#send \"$SUDOPASSWORD\r\"
spawn sudo fdesetup enable -user "$FILEVAULTUSER"
expect \"Password:\"
send \"$SUDOPASSWORD\r\"
expect \"Enter the password for user '$FILEVAULTUSER':\"
send \"$SUDOPASSWORD\r\"
#log_user 1
expect eof
" 2>&1 | grep key | tee -a "$FILEVAULT_KEYFILE"
# if grep from output does not work to get the key, use this alternative
#" 2>&1 | tee -a "$FILEVAULT_KEYFILE"
#sed -i '' '/^spawn sudo/d' "$FILEVAULT_KEYFILE"
#sed -i '' '/^Password:/d' "$FILEVAULT_KEYFILE"
#sed -i '' '/^Enter the/d' "$FILEVAULT_KEYFILE"

        	#sudo fdesetup enable -user "$USER" 2>&1 | tee -a "$FILEVAULT_KEYFILE"
        	# to generate and use a new key
        	#sudo fdesetup changerecovery -user "$USER" -personal >> "$FILEVAULT_KEYFILE"
        	sleep 1
        	if [[ $(cat "$FILEVAULT_KEYFILE" | grep key) == "" ]]
        	then
        	    echo "no filevault key found in keyfile, setting new key"
        	    sleep 1
        	    expect -c "
spawn sudo fdesetup changerecovery -user "$FILEVAULTUSER" -personal
expect \"Password:\"
send \"$SUDOPASSWORD\r\"
expect \"Enter the password for user '$FILEVAULTUSER':\"
send \"$SUDOPASSWORD\r\"
expect eof
" 2>&1 | grep key | tee -a "$FILEVAULT_KEYFILE"
# if grep from output does not work to get the key, use this alternative
#" 2>&1 | tee -a "$FILEVAULT_KEYFILE"
#sed -i '' '/^spawn sudo/d' "$FILEVAULT_KEYFILE"
#sed -i '' '/^Password:/d' "$FILEVAULT_KEYFILE"
#sed -i '' '/^Enter the/d' "$FILEVAULT_KEYFILE"
            else
                :
            fi
        	# to disable, run
        	#sudo fdesetup disable -user "$USER"
        	
        	# make sure the user password is set correctly
        	#sudo dscl . -passwd /Users/"$USER" "$SUDOPASSWORD"
        	
        fi
    }
    # this can not be enabled here because login will not work after a reboot if the sharing command is used after enabling_filevault (in this script done by public shared folder and sharing user)
    # this is why enabling_filevault is moved to the end of this script to avoid complications with other commands
    
    # automatic login with filevault enabled
    # enable
    #sudo defaults delete /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin
    # disable
    #sudo defaults write /Library/Preferences/com.apple.loginwindow DisableFDEAutoLogin -bool YES
    
    
    #### security firewall
    
    # turning on firewall
    sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1
    
    # disable stealth mode
    sudo defaults write /Library/Preferences/com.apple.alf stealthenabled -int 0
    
    # allow signed apps
    sudo defaults write /Library/Preferences/com.apple.alf allowsignedenabled -int 1
    
    # enable logging
    #defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true
    
    # restart firewall
    sudo launchctl unload /System/Library/LaunchAgents/com.apple.alf.useragent.plist >/dev/null 2>&1
    sudo launchctl unload /System/Library/LaunchDaemons/com.apple.alf.agent.plist >/dev/null 2>&1
    sudo launchctl load /System/Library/LaunchDaemons/com.apple.alf.agent.plist
    sudo launchctl load /System/Library/LaunchAgents/com.apple.alf.useragent.plist
    
    
    #### security privacy
    
    # disable location services
    ##
    sudo launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist
    #sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd.$uuid1 LocationServicesEnabled -int 0
    sudo defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 0
    sudo chown -R _locationd:_locationd /var/db/locationd
    sudo launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist
    #sudo -u _locationd defaults write -currentHost com.apple.locationd.plist LocationServicesEnabled -int 0

    # disable sending diagnostics data to apple
    ##
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmit -bool false
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" SeedAutoSubmit -bool false
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" AutoSubmitVersion -integer 4
    
    # disable sending diagnostics data to developers
    ##
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" ThirdPartyDataSubmit -bool false
    defaults write "/Library/Application Support/CrashReporter/DiagnosticMessagesHistory.plist" ThirdPartyDataSubmitVersion -integer 4
    
    # disable sending icloud diagnostics data
    # only has to be done one time ever in the system preferences - security - privacy
    # or go to 
    # appleid.apple.com 
    # privacy
    # settings for data privacy
    # disable share icloud analytics data
    
    # no add tracking
    # true = no tracking
    # does not stay activated
    #defaults write com.apple.AdLib.plist forceLimitAdTracking -bool true
    
    function no_add_tracking() {
    #osascript 2>/dev/null <<EOF
    osascript <<EOF
    
    tell application "System Preferences"
    	activate
    	#set panenames to (get the name of every pane)
    	#display dialog panenames
    	--return panenames
    	set current pane to pane "com.apple.preference.security"
    	get the name of every anchor of pane id "com.apple.preference.security"
    	set tabnames to (get the name of every anchor of pane id "com.apple.preference.security")
    	
    	#display dialog tabnames
    	reveal anchor "Privacy" of pane id "com.apple.preference.security"
    	delay 1
    	tell application "System Events"
    		select row 12 of table 1 of scroll area 1 of tab group 1 of window 1 of application process "System Preferences"
    	end tell
    	
    end tell
    
    delay 1
    
    tell application "System Events"
    	tell process "System Preferences"
    		# first checkbox in main window
    		#click checkbox 1 of window 1
    		# first checkbox of first group
    		# set theCheckbox to checkbox "Helligkeit automatisch anpassen" of group 1 of tab group 1 of window 1
    		if exists checkbox 1 of group 1 of tab group 1 of window 1 then
    			set theCheckbox to (checkbox 1 of group 1 of tab group 1 of window 1)
    			tell theCheckbox
    				set checkboxStatus to value of theCheckbox as boolean
    				if checkboxStatus is false then click theCheckbox
    			end tell
    		end if
    		delay 0.2
    		#click checkbox 1 of group 1 of tab group 1 of window 1
    	end tell
    end tell
    
    delay 2
    
    tell application "System Preferences"
    	quit
    end tell
    
EOF
    }
    no_add_tracking
    
    
    ### security more options
    # autologout on inactivity
    sudo defaults write /Library/Preferences/.GlobalPreferences.plist com.apple.autologout.AutoLogOutDelay -int 0
    
    # require an administrator password to access system-wide preferences
    sudo security authorizationdb read system.preferences > /tmp/system.preferences.plist
    sleep 0.5
    # enabled = false
    # disabled = true
    #sudo /usr/libexec/PlistBuddy -c "Add :shared bool" /tmp/system.preferences.plist
    sudo /usr/libexec/PlistBuddy -c "Set :shared false" /tmp/system.preferences.plist
    sleep 0.5
    #defaults read /tmp/system.preferences.plist
    # exec or "$SHELL" -c work around
    # Error Domain=NSCocoaErrorDomain Code=3840 "Cannot parse a NULL or zero-length data" UserInfo={NSDebugDescription=Cannot parse a NULL or zero-length data}
    # that occurs due to the changed sudo command
    ${USE_PASSWORD} | exec sudo -p '' -S "$SHELL" -c "security authorizationdb write system.preferences < /tmp/system.preferences.plist"    
    #sudo security authorizationdb read system.preferences"
    sleep 0.5

    ###
    ### preferences spotlight
    ###
    
    # see separate script
    
    
    
    ###
    ### preferences - notifications
    ###
    
    # disable notification center
    #sudo launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
    
    # reenable notification center
    #sudo launchctl load -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist
    # a reboot is required for this to work again
    
    
    ### per app notification settings
    # see seperate script
    
    
    ### hidden notification center tweaks
    
    # changing notification banner persistence time (value in seconds)
    #defaults write com.apple.notificationcenterui bannerTime 15
    
    # resetting default notification banner persistence time
    #defaults delete com.apple.notificationcenterui bannerTime
    
    
    
    ###
    ### preferences - monitor
    ###
    
    echo "preferences monitor"
    
    # nnable HiDPI display modes (requires restart) for non retina displays
    #sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
    
    # settings display scale factor (1 = 100%)
    # does not work for me in 10.11
    #defaults write NSGlobalDomain AppleDisplayScaleFactor 0.75
    
    # automatic brightness
    function automatic_brightness() {
    #osascript 2>/dev/null <<EOF
    osascript <<EOF
    
    tell application "System Preferences"
    	activate
    	#set panenames to (get the name of every pane)
    	#display dialog panenames
    	--return panenames
    	set current pane to pane "com.apple.preference.displays"
    	#get the name of every anchor of pane id "com.apple.preference.displays"
    	#set tabnames to (get the name of every anchor of pane id "com.apple.preference.displays")
    	#display dialog tabnames
    	reveal anchor "displaysDisplayTab" of pane id "com.apple.preference.displays"
    end tell
    
    delay 1
    
    tell application "System Events"
    	tell process "System Preferences"
    		# first checkbox in main window
    		#click checkbox 1 of window 1
    		# first checkbox of first group
    		# set theCheckbox to checkbox "Helligkeit automatisch anpassen" of group 1 of tab group 1 of window 1
    		if exists checkbox 1 of group 1 of tab group 1 of window 1
    		    set theCheckbox to (checkbox 1 of group 1 of tab group 1 of window 1)
    		    tell theCheckbox
    			    set checkboxStatus to value of theCheckbox as boolean
    			    if checkboxStatus is false then click theCheckbox
    		    end tell
    		end if
    		delay 0.2
    		#click checkbox 1 of group 1 of tab group 1 of window 1
    	end tell
    end tell
    
    delay 2
    
    tell application "System Preferences"
    	quit
    end tell
    
EOF
    }
    automatic_brightness
    
    # display - automatically adjust brightness
    ##
    #sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Display Enabled" -bool false
    
    # show monitor sync options in menu bar if available
    ##
    defaults write com.apple.airplay showInMenuBarIfPresent -bool true
    
    # night shift
    # controlled in /S*/L*/PrivateFrameworks/CoreBrightness.framework/CoreBrightness
    # https://github.com/jenghis/nshift
    # https://github.com/leberwurstsaft/nshift      (binary)
    # binary usage
    # nshift.dms strength (0-100)
    # nshift.dms on
    # nshift.dms off
    # nshift.dms reset
    # or
    # https://justgetflux.com
    
    

    ###
    ### preferences - energy
    ###
    
    echo "preferences energy"
    
    # checking current settings
    #pmset -g
    #sudo systemsetup -getsleep
    #sudo systemsetup -getwakeonnetworkaccess
    
    # automatic graphics switching
    # 0 = integrated (less powerfull)
    # 1 = dedicated (separate graphics card)
    # 2 = auto switch (default)
    if [[ $USER == "tom" ]]
    then
        sudo pmset -a gpuswitch 2
    else
        :
    fi
    
    # set standbydelay on battery and ac power delay to 10 min (default is 3 hours = 10800), set in seconds
    #sudo pmset -a standbydelay 600
    
    # halfdim - display sleep will use an intermediate half-brightness state between full brightness and fully off (boolean)
    # 0 = off
    # 1 = on
    
    # on battery
    sudo pmset -b sleep 20 disksleep 15 displaysleep 10 halfdim 1
    
    # on power adapter
    sudo pmset -c sleep 20 disksleep 15 displaysleep 10 halfdim 1
    
    # disable automatic sleep when display off on battery (should only be used with disksleep 0)
    #sudo pmset -b sleep 0
    
    # disable disc sleep on ac power on battery (should only be used with sleep 0)
    #sudo pmset -b disksleep 0
    
    # slightly turn down display brightness when on battery
    # 1=yes, 0=no
    sudo pmset -b lessbright 0
    
    # activate powernap on battery power
    # 1=yes, 0=no
    #sudo pmset -b darkwakes 1
    #sudo /usr/libexec/PlistBuddy -c 'Set "Custom Profile":"Battery Power":DarkWakeBackgroundTasks bool true' /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist
    
    # disable automatic sleep when display off on ac power (should only be used with disksleep 0)
    #sudo pmset -c sleep 0
    
    # disable disc sleep on ac power on ac power (should only be used with sleep 0)
    #sudo pmset -c disksleep 0
    
    # wake on lan over on ac power
    #sudo pmset -c womp 0
    
    # deactivate powernap on ac power
    sudo pmset -c darkwakes 0
    #sudo /usr/libexec/PlistBuddy -c 'Set "Custom Profile":"AC Power":DarkWakeBackgroundTasks bool false' /Library/Preferences/SystemConfiguration/com.apple.PowerManagement.plist
    
    
    
    ###
    ### preferences keyboard
    ###
    
    echo "preferences keyboard"
    
    
    ### keyboard
    
    # Set keyboard repeat rate
    defaults write NSGlobalDomain InitialKeyRepeat -int 25
    defaults write NSGlobalDomain KeyRepeat -int 6
    
    # adjust keyboard brightness in low light
    ##
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Automatic Keyboard Enabled" -bool true
    
    # deactivate keyboard light if computer is inactive
    # -1 = never
    ##
    sudo defaults write /Library/Preferences/com.apple.iokit.AmbientLightSensor "Keyboard Dim Time" -int -1
    
    # if mac has touchbar, configure more settings
    if [[ $(pgrep "ControlStrip") != "" ]]
    then
        #echo "touchbar is present"
        
        # touchbar without fn keys
        # fullControlStrip
        # app
        # functionKeys
        defaults write com.apple.touchbar.agent PresentationModeGlobal -string functionKeys
        
        # touchbar when pressing fn
        # fullControlStrip
        # app
        defaults write com.apple.touchbar.agent PresentationModeFnModes -dict-add functionKeys -string fullControlStrip
        
        # activating settings
        killall ControlStrip
        
    else
        #echo "no touchbar present"
        :
    fi
    
    
    # use all F1, F2, etc. keys as standard function keys
    # 1=yes, 0=no
    defaults write NSGlobalDomain com.apple.keyboard.fnState -int 1
    
    
    ### text
    
    # auto-correct spelling
    defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
    
    # auto capitalization
    defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
    
    # substitute double space with dot and space
    defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
    
    # smart quotes
    defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
    
    # smart dashes
    defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
    
    
    ### input sources
    update_keyboard_layout() {
        for CONFIG_VALUE in $KEYBOARD_CONFIG_VALUES
        do
            ${PLBUDDY} -c "Delete :${CONFIG_VALUE}" "$KEYBOARD_CONFIG_FILE" >/dev/null
            ${PLBUDDY} -c "Add :${CONFIG_VALUE} array" "$KEYBOARD_CONFIG_FILE"
            ${PLBUDDY} -c "Add :${CONFIG_VALUE}:0 dict" "$KEYBOARD_CONFIG_FILE"
            ${PLBUDDY} -c "Add :${CONFIG_VALUE}:0:InputSourceKind string 'Keyboard Layout'" "$KEYBOARD_CONFIG_FILE"
            ${PLBUDDY} -c "Add :${CONFIG_VALUE}:0:'KeyboardLayout ID' integer ${KEYBOARD_LAYOUT}" "$KEYBOARD_CONFIG_FILE"
            ${PLBUDDY} -c "Add :${CONFIG_VALUE}:0:'KeyboardLayout Name' string '${KEYBOARD_LOCALE}'" "$KEYBOARD_CONFIG_FILE"
        done
    }
    
    # variables
    KEYBOARD_LOCALE="German"
    # 3 = QUERTZ
    KEYBOARD_LAYOUT="3"
    
    # system
    PLBUDDY='sudo /usr/libexec/PlistBuddy'
    KEYBOARD_CONFIG_FILE="/Library/Preferences/com.apple.HIToolbox.plist"
    KEYBOARD_CONFIG_VALUES="AppleDefaultAsciiInputSource AppleEnabledInputSources"
    update_keyboard_layout "$KEYBOARD_CONFIG_FILE" "${KEYBOARD_LOCALE}" "${KEYBOARD_LAYOUT}"
    #sudo chmod 644 "$KEYBOARD_CONFIG_FILE"
    #sudo chown root:wheel "$KEYBOARD_CONFIG_FILE"
    
    # user
    PLBUDDY='/usr/libexec/PlistBuddy'
    KEYBOARD_CONFIG_FILE="/USERS/$USER/Library/Preferences/com.apple.HIToolbox.plist"
    KEYBOARD_CONFIG_VALUES="AppleEnabledInputSources AppleSelectedInputSources"
    ${PLBUDDY} -c "Delete :AppleCurrentKeyboardLayoutInputSourceID" "$KEYBOARD_CONFIG_FILE" >/dev/null
    ${PLBUDDY} -c "Add :AppleCurrentKeyboardLayoutInputSourceID string com.apple.keylayout.${KEYBOARD_LOCALE}" "$KEYBOARD_CONFIG_FILE"
    update_keyboard_layout "$KEYBOARD_CONFIG_FILE" "${KEYBOARD_LOCALE}" "${KEYBOARD_LAYOUT}"
    #chmod 644 "$KEYBOARD_CONFIG_FILE"
    #chown $USER:staff "$KEYBOARD_CONFIG_FILE"

    
    ### dictation
    defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMMasterDictationEnabled -bool false
    # advanced dictation
    defaults write com.apple.speech.recognition.AppleSpeechRecognition.prefs DictationIMUseOnlyOfflineDictation -bool false
    # hotkeys
    # ~/Library/Preferences/com.apple.symbolichotkeys.plist
    # see dashboard above
    
    ### hidden keyboard tweaks
    
    # stop itunes from responding to the keyboard media keys
    #launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
    
    # disable press-and-hold for keys in favor of key repeat
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    
    # enable full keyboard access for all controls
    # (e.g. enable tab in modal dialogs)
    defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
    
    
    
    ###
    ### preferences mouse & trackpad keyboard, bluetooth accessories, and input
    ###
    
    echo "preferences mouse & trackpad"
    
    ### mouse
    
    # secondary click:
    # possible values: OneButton, TwoButton, TwoButtonSwapped
    defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string OneButton
        
    if [ "$USER" == "wolfgang" ]
    then
        defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode -string TwoButton
    else
        :
    fi
    
    ### trackpad
    # included in macbook is com.apple.AppleMultitouchTrackpad
    # bluetooth trackpad would be com.apple.driver.AppleBluetoothMultitouch.trackpad
    
    # trackpad secondary click

    # how to right click
    defaults write NSGlobalDomain ContextMenuGesture -int 1
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
    # 0 = two finger click
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
    # 1 = click left bottom corner of trackpad
    #defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 1
    # eventually this is needed to deactivate two finder click
    #defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
    # 2 = click right bottom corner of trackpad
    #defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    # eventually this is needed to deactivate two finder click
    #defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false

    # trackpad: enable tap to click for this user and for the login screen
    #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
    #defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
    # 0 = disbled
    # 1 = enabled
    defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
    
    # trackpad: map bottom right corner to right-click
    #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    #defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    #defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
    #defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
    
    # disable "natural" scrolling
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
    
    # use scroll gesture with the Ctrl (^) modifier key to zoom
    #defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
    #defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
    # follow the keyboard focus while zoomed in
    #defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
    
    # force click and haptic feedback
    #defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true
    #defaults write com.AppleMultitouchTrackpad ActuateDetents -bool true
    # true = force klick off
    # fallse = force klick on
    defaults write com.apple.AppleMultitouchTrackpad ForceSuppressed -bool true
    
    # haptic feedback for force touch
    # 0 = light
    # 1 = medium
    # 2 = firm
    defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 1
    defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 1
    
    # trackpad cursor speed
    defaults write NSGlobalDomain com.apple.trackpad.scaling -float 0.875
    
    # mouse cursor speed
    # 0-5 with 5 being the fastest
    defaults write -g com.apple.mouse.scaling 0.875
    # default mouse cursor speed
    # defaults delete -g com.apple.mouse.scaling
    
    # disable smooth scrolling
    #defaults write -g AppleScrollAnimationEnabled -bool false
    #defaults write -g NSScrollAnimationEnabled -bool false
    
    
    ###
    ### preferences - sound
    ###
    
    echo "preferences sound"
    
    ### select an alert sound "Sosumi"
    #/usr/bin/defaults write com.apple.systemsound 'com.apple.sound.beep.sound' -string '/System/Library/Sounds/Sosumi.aiff'
    
    ### play user interface sound effects
    #/usr/bin/defaults write com.apple.systemsound 'com.apple.sound.uiaudio.enabled' -int 0
    
    # feedback sound when changing volume
    # 1 = yes, 0 = no
    defaults write NSGlobalDomain com.apple.sound.beep.feedback -integer 1
    
    # ambient noice reduction
    #defaults write NSGlobalDomain 646F6E7A_00000000_00000001_6E7A6361_696D6963 -integer 1
    
    
    ### hidden sound tweaks
    
    # increase sound quality for Bluetooth headphones/headsets
    #defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
    
    
    
    ###
    ### preferences software update
    ###
    
    echo "preferences mac app store"
    
    # to enable the checkbox "automatically update my mac" just set all options below to true 
    
    # enable or disbale automatic update check
    sudo softwareupdate --schedule on
    #sudo softwareupdate --schedule off
    # or
    #sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
    #sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool false
    
    # download updates automatically in the background
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool false
    
    # install app updates from appstore automatically
    ##
    sudo defaults write /Library/Preferences/com.apple.commerce AutoUpdate -bool false
    
    # install macos updates automatically
    ##
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticallyInstallMacOSUpdates -bool false
    
    # install system and security updates automatically
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool false
    sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool false
    
    ### appstore
    
    # automatically install bought apps on other macs
    # sets the correct value but doesn`t set the marker in the gui
    # don`t know if setting this value is enough for it to work
    # seems like the setting is only to set once on one mac in the gui and is send to other macs connected to the same icloud account automatically so it doesn`t have to be set for a clean reinstall
    #APPSTOREACCOUNTIDS=$(defaults read com.apple.commerce.plist autopush-registered-dsids | grep -v '{' | grep -v '}' | awk '{print $1}' | cat )
    #for i in $APPSTOREACCOUNTIDS
    #do
    #	/usr/libexec/PlistBuddy -c "Set autopush-registered-dsids:${i} 0" ~/Library/Preferences/com.apple.commerce.plist
    #done
    
    # auto play appstore videos
    defaults write ~/Library/Preferences/com.apple.AppStore.plist AutoPlayVideoSetting -string "off"
    defaults write ~/Library/Preferences/com.apple.AppStore.plist UserSetAutoPlayVideoSetting -bool true
    # if this setting is needed then a reboot seems to be needed, too
    #defaults write ~/Library/Containers/com.apple.AppStore/Data/Library/Preferences/com.apple.appstore.plist AutoPlayVideoSetting -string "off"
    
    # in app reviews
    defaults write com.apple.commerce InAppReviewEnabled -bool false

    ### hidden appstore tweaks
    
    # check for software updates daily, not just once per week
    defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
    
    # enable the webkit developer tools in the mac app store
    #defaults write com.apple.appstore WebKitDeveloperExtras -bool true
    
    # enable debug menu in the mac app store
    #defaults write com.apple.appstore ShowDebugMenu -bool true
    
    
    ###
    ### preferences network
    ###
    
    # see separate script
    
    
    
    ###
    ### preferences extensions
    ###
    
    # finder
    defaults write pbs FinderActive -dict-add APPEXTENSION-com.apple.finder.CreatePDFQuickAction -bool true
    defaults write pbs FinderActive -dict-add APPEXTENSION-com.apple.finder.MarkupQuickAction -bool true
    defaults write pbs FinderActive -dict-add APPEXTENSION-com.apple.finder.RotateQuickAction -bool true
    defaults write pbs FinderActive -dict-add APPEXTENSION-com.apple.finder.TrimQuickAction -bool true
    
    
    
    ###
    ### preferences sharing
    ###
    
    echo "preferences sharing"
    
    # set computer name (as done via system preferences - sharing)
    if [ "$USER" == "tom" ]
    then
        MY_HOSTNAME="toms-macbookpro"
    else
        echo 'only numbers, characters [a-zA-Z] and '-' are allowed...'
        read -p "Enter new hostname: " MY_HOSTNAME
    fi
    
    sudo scutil --set ComputerName "$MY_HOSTNAME"
    sudo scutil --set LocalHostName "$MY_HOSTNAME"
    sudo scutil --set HostName "$MY_HOSTNAME"
    #sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$MY_HOSTNAME"
    dscacheutil -flushcache
    unset MY_HOSTNAME
    
    # screen sharing
    #sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
    #sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.screensharing.plist
    
    # turn off file sharing
    # deactivate smb file server
    ##
    if [[ $(sudo launchctl list | grep com.apple.smbd) == "" ]] > /dev/null 2>&1
    then
        :
    else
        sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist
    fi
    
    # deactivate afp file server
    ##
    if [[ $(sudo launchctl list | grep com.apple.AppleFileServer) == "" ]] > /dev/null 2>&1
    then
        :
    else
        sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.AppleFileServer.plist
    fi
    # turn off internet sharing
    #sudo launchctl unload /System/Library/LaunchDaemons/com.apple.InternetSharing.plist
    
    # removing public share
    if [[ $(sudo sharing -l | grep /Users/$USER/Public) != "" ]]
    then
        PUBLIC_SHARED_FOLDER=$(sudo sharing -l | grep "name:" | grep "$USER" | head -n 1 | cut -f 2- | perl -p -e 's/^[\ \t]//')
        #PUBLIC_SHARED_FOLDER=$(sudo sharing -l | grep "name:" | head -n 1 | cut -f 2- | perl -p -e 's/^[\ \t]//')
    	sudo sharing -r "$PUBLIC_SHARED_FOLDER"
    else
    	:
    fi
    
    function creating_sharing_user() {
        echo ''
        echo creating macos sharinguser...
        echo ''
        echo "please set sharinguser password..."
        sharinguser_password="    "
        while [[ $sharinguser_password != $sharinguser_password2 ]] || [[ $sharinguser_password == "" ]]; do stty -echo && trap 'stty echo' EXIT && printf "sharinguser password: " && read -r "$@" sharinguser_password && printf "\n" && printf "re-enter sharinguser password: " && read -r "$@" sharinguser_password2 && stty echo && trap - EXIT && printf "\n" && USE_SHARINGUSER_PASSWORD='builtin printf '"$sharinguser_password\n"''; done
        
        # deleting user (if existing)
        if [[ $(dscl . list /Users | grep sharinguser) != "" ]]
        then
        	sudo dscl . delete /Users/sharinguser
        else
        	:
        fi    
        
        # creating user
        sudo dscl . create /Users/sharinguser
        sudo dscl . create /Users/sharinguser RealName "sharinguser"
        sudo dscl . create /Users/sharinguser hint "none"
        #sudo dscl . create /Users/sharinguser picture "/Path/To/Picture.png"
        sudo dscl . passwd /Users/sharinguser $sharinguser_password
        export LastID=`dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1`
        export NextID=$((LastID + 1))
        #echo $NextID
        sudo dscl . create /Users/sharinguser UniqueID $NextID
        sudo dscl . create /Users/sharinguser PrimaryGroupID 20
        sudo dscl . create /Users/sharinguser UserShell /usr/bin/false
        sudo dscl . create /Users/sharinguser NFSHomeDirectory /dev/null     
        
        ### defining smb shares
        echo ''
        echo defining macos smb shares...
        
        # listing shares
        #sudo sharing -l
        # creating shared folder with ownership and permissions
        #rm -rf /Users/$USER/Desktop/files/vbox_shared
        mkdir -p /Users/$USER/Desktop/files/vbox_shared
        sudo chown -R sharinguser:admin /Users/$USER/Desktop/files/vbox_shared
        sudo chmod 770 /Users/$USER/Desktop/files/vbox_shared
        # removing possible exiting share
        sudo sharing -r /Users/$USER/Desktop/files/vbox_shared
        # creating share
        sudo sharing -a /Users/$USER/Desktop/files/vbox_shared -S vbox_shared -s 001 -g 000
        # listing shares
        #sudo sharing -l
        # status if sharing is enabled is given by "shared" (0=disabled, 1=enabled)
        # sudo sharing -r /Users/$USER/Desktop/files/vbox_shared
        sudo chmod -R +a "staff allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" /Users/$USER/Desktop/files/vbox_shared
        # both sethashtypes commands have to be run for the login to work (bug?)
        # if it is not working run the second one incl. -a and -p twice
        sudo pwpolicy -u sharinguser -sethashtypes SMB-NT on
        sudo pwpolicy -u sharinguser -a sharinguser -p $sharinguser_password -sethashtypes SMB-NT on
        sudo pwpolicy -u sharinguser -gethashtypes
        
        # enabling sharing
        #echo enabling macos smb sharing...
        #sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.smbd.plist
        # use /Applications/smb_enable.app
        
        # disabling sharing
        #sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.smbd.plist
        # use /Applications/smb_disable.app
            
        unset sharinguser_password
        unset sharinguser_password2
    }
    
    ### separate user for smb sharing    
    if [ "$USER" == "tom" ]
    then
        #creating_sharing_user
        :
    else
        :
    fi

    # printer sharing
    # cupsctl --share-printers
    # cupsctl --no-share-printers
    # sets preferences in 
    # /etc/cups/cupsd.conf
    # /etc/cups/printers.conf
    # check
    # system_profiler SPPrintersDataType | grep "Printer Sharing"
    # system_profiler SPPrintersDataType | grep Shared
    
    # remote login
    #sudo systemsetup -setremotelogin on
    #sudo systemsetup -setremotelogin off
    # check
    #sudo systemsetup -getremotelogin
    
    # remote management
    # screen sharing has to be enabled additionally for this to work
    #sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate
    #sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -deactivate -stop
    
    # remote apple events
    #sudo systemsetup -setremoteappleevents on
    #sudo systemsetup -setremoteappleevents off
    #sudo launchctl unload -w /System/Library/LaunchDaemons/eppc.plist
    # check
    #sudo systemsetup -getremoteappleevents | grep "Apple Events"
    
    # internet sharing
    # disable
    #sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.nat NAT -dict Enabled -int 0
    # check
    #sudo defaults read /Library/Preferences/SystemConfiguration/com.apple.nat | grep -i Enabled
    
    # bluetooth sharing
    # needs logout / reboot
    #defaults -currentHost write com.apple.bluetooth PrefKeyServicesEnabled -bool true
    #defaults -currentHost write com.apple.bluetooth PrefKeyServicesEnabled -bool false
    
    # content caching
    #sudo AssetCacheManagerUtil activate
    #sudo AssetCacheManagerUtil deactivate
    
    
    
    ###
    ### preferences users & groups
    ###
    
    echo "preferences users & groups"
    
    # disable guest account login
    # fals = disabled
    ##
    sudo /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
    
    # disable allowing guests to connect to shared folders
    #sudo /usr/bin/defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool no
    #sudo /usr/bin/defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool no
    
    
    ### login options
    
    # disable automatic login
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow.plist autoLoginUser 0
    sudo defaults delete /Library/Preferences/com.apple.loginwindow.plist autoLoginUser
    
    # display login window as name and password
    ##
    sudo /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool false
    
    # show buttons on loginwindow
    # false = show, true = do not show
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow ShutDownDisabled -bool false
    sudo defaults write /Library/Preferences/com.apple.loginwindow RestartDisabled -bool false
    sudo defaults write /Library/Preferences/com.apple.loginwindow SleepDisabled -bool false
    
    # show input sources on loginwindow
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool false
    
    # password hints
    # disable
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 0
    # enable
    #sudo /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow RetriesUntilHint -int 3
    
    # menu for fast user switching
    ##
    sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
    
    # use voiceover on loginwindow
    ##
    sudo defaults write /Library/Preferences/com.apple.loginwindow UseVoiceOverAtLoginwindow -bool false
    
    
    ### current user
    
    # setting new user password
    # dscl . -passwd /Users/$USER
    
    # user is allowed to reset password with appleid from icloud
    # this is an option you select when activating filevault in preferences gui
    #sudo dscl . delete /Users/$USER AuthenticationAuthority ";AppleID;YOUR_APPLE_ID"
    #sudo dscl . append /Users/$USER AuthenticationAuthority ";AppleID;YOUR_APPLE_ID"
    # check
    #dscl . -read /Users/$USER AuthenticationAuthority
    
    # clicking the button in the system preferences modifies /var/db/dslocal/nodes/Default/users/$USER.plist
    # this checking won`t work with command above, it completele removes the button after appending and brings it back with deleting
    #sudo plutil -p /var/db/dslocal/nodes/Default/users/$USER.plist
    #sudo /usr/libexec/PlistBuddy -c "Print :'LinkedIdentity':'0'" /var/db/dslocal/nodes/Default/users/$USER.plist
    
    # user is admin
    # this option has to be selected when creating a user account
    # dscl . -merge /Groups/admin GroupMembership $USER
    
    # parental control
    # con not be enabled for an admin user account
    # add a non-admin user account and setup parental control
    
    
    ### current user startup items
    
    # listing startup-items
    #osascript -e 'tell application "System Events" to get the name of every login item' | tr "," "\n" | sed 's/^ *//'
    
    # deleting startup-items
    # osascript -e 'tell application "System Events" to delete login item "itemname"'
    
    # deleting all startup items
    if [[ $(osascript -e 'tell application "System Events" to get the name of every login item' | tr "," "\n" | sed 's/^ *//') != "" ]]
    then
        osascript -e 'tell application "System Events" to get the name of every login item' | tr "," "\n" | sed 's/^ *//' | while read -r autostartapp
        do
        	IFS=$'\n'
        	echo deleting autostartentry for $autostartapp
        	osascript -e 'tell application "System Events" to delete login item "'$autostartapp'"'
        	unset IFS
        done
    else
        :
    fi
    
    # adding startup-items
    # osascript -e 'tell application "System Events" to make login item at end with properties {name:"name", path:"/path/to/itemname", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"Bartender 3", path:"/Applications/Bartender 3.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"AudioSwitcher", path:"/Applications/AudioSwitcher.app", hidden:false}'
    # autostart at login activated inside overflow 3 app, this way the overflow window does not open when starting the app on login
    #osascript -e 'tell application "System Events" to make login item at end with properties {name:"Overflow 3", path:"/Applications/Overflow 3.app", hidden:true}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"KeepingYouAwake", path:"/Applications/KeepingYouAwake.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"Alfred 4", path:"/Applications/Alfred 4.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"GeburtstagsChecker", path:"/Applications/GeburtstagsChecker.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"AppCleaner Helper", path:"/Applications/AppCleaner Helper.app", hidden:false}'
    #osascript -e 'tell application "System Events" to make login item at end with properties {name:"SMARTReporter", path:"/Applications/SMARTReporter.app", hidden:false}'
    #osascript -e 'tell application "System Events" to make login item at end with properties {name:"TotalFinder", path:"/Applications/TotalFinder.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"XtraFinder", path:"/Applications/XtraFinder.app", hidden:false}'
    #osascript -e 'tell application "System Events" to make login item at end with properties {name:"iStat Menus", path:"/Applications/iStat Menus.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"witchdaemon", path:"/Users/'$USER'/Library/PreferencePanes/Witch.prefPane/Contents/Helpers/witchdaemon.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"Quicksilver", path:"/Applications/Quicksilver.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"Oversight", path:"/Applications/OverSight.app/Contents/Library/LoginItems/OverSight Helper.app", hidden:false}'
    #osascript -e 'tell application "System Events" to make login item at end with properties {name:"Virus Scanner Plus", path:"/Applications/VirusScannerPlus.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"Better", path:"/Applications/Better.app", hidden:false}'
    osascript -e 'tell application "System Events" to make login item at end with properties {name:"AdGuard for Safari", path:"/Applications/AdGuard for Safari.app", hidden:false}'
    
    # adding some more startup-items for specified user if script is run on multiple macs with different users
    if [[ "$USER" == "tom" ]]
    then
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"VirtualBox Menulet", path:"/Applications/VirtualBox Menulet.app", hidden:false}'
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"run_on_login_signal", path:"/Users/'$USER'/Library/Scripts/run_on_login_signal.app", hidden:false}'
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"run_on_login_whatsapp", path:"/Users/'$USER'/Library/Scripts/run_on_login_whatsapp.app", hidden:false}'
    	#osascript -e 'tell application "System Events" to make login item at end with properties {name:"Unified Remote", path:"/Applications/Unified Remote.app", hidden:false}'
    	#osascript -e 'tell application "System Events" to make login item at end with properties {name:"run_on_network_change_login", path:"/Users/'$USER'/Library/Scripts/run_on_network_change_login.app", hidden:true}'
    else
    	:
    fi
    
    if [[ "$USER" == "wolfgang" ]]
    then
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"Firefox", path:"/Applications/Firefox.app", hidden:false}'
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"Mail", path:"/Applications/Mail.app", hidden:true}'
        osascript -e 'tell application "System Events" to make login item at end with properties {name:"PV Guard", path:"/Users/$USER/Library/Application Support/Oracle/Java/Deployment/cache/6.0/bundles/PVGuard.app", hidden:true}'
    else
    	:
    fi
    
    if [[ $(sysctl hw.model | grep "iMac11,2") != "" || $(sysctl hw.model | grep "iMac12,1") != "" ]] && [[ $(system_profiler SPStorageDataType | grep "Medium Type" | grep SSD) != "" ]]
    #if [[ $(system_profiler SPHardwareDataType | grep "Model Identifier" | grep "iMac11,2") != "" ]]
    then
    	osascript -e 'tell application "System Events" to make login item at end with properties {name:"Macs Fan Control", path:"//Applications/Macs Fan Control.app", hidden:false}'
    else
    	:
    fi
    
    
    ###
    ### preferences - siri
    ###
    
    echo "preferences siri"
    # config files
    # /Users/tom/Library/Preferences/com.apple.assistant.support.plist
    # /Users/tom/Library/Preferences/com.apple.assistant.backedup.plist
    # /Users/tom/Library/Preferences/com.apple.Siri.plist
    
    # enable / disable siri 
    defaults write com.apple.assistant.support "Assistant Enabled" -boolean false
    
    # if enabled (true), settings
    # language
    defaults write com.apple.assistant.backedup "Session Language" -string de-DE
    
    # output voice language
    if [[ -z $(/usr/libexec/PlistBuddy -c "Print :'Output Voice':Custom" ~/Library/Preferences/com.apple.assistant.backedup.plist) ]] > /dev/null 2>&1
    then
        /usr/libexec/PlistBuddy -c "Add :'Output Voice':Custom bool" ~/Library/Preferences/com.apple.assistant.backedup.plist
    	/usr/libexec/PlistBuddy -c "Set :'Output Voice':Custom YES" ~/Library/Preferences/com.apple.assistant.backedup.plist
    else
    	/usr/libexec/PlistBuddy -c "Set :'Output Voice':Custom YES" ~/Library/Preferences/com.apple.assistant.backedup.plist
    fi
    if [[ -z $(/usr/libexec/PlistBuddy -c "Print :'Output Voice':Language" ~/Library/Preferences/com.apple.assistant.backedup.plist) ]] > /dev/null 2>&1
    then
        /usr/libexec/PlistBuddy -c "Add :'Output Voice':Language string" ~/Library/Preferences/com.apple.assistant.backedup.plist
    	/usr/libexec/PlistBuddy -c "Set :'Output Voice':Language de-DE" ~/Library/Preferences/com.apple.assistant.backedup.plist
    else
    	/usr/libexec/PlistBuddy -c "Set :'Output Voice':Language de-DE" ~/Library/Preferences/com.apple.assistant.backedup.plist
    fi
    if [[ -z $(/usr/libexec/PlistBuddy -c "Print :'Output Voice':Name" ~/Library/Preferences/com.apple.assistant.backedup.plist) ]] > /dev/null 2>&1
    then
        /usr/libexec/PlistBuddy -c "Add :'Output Voice':Name string" ~/Library/Preferences/com.apple.assistant.backedup.plist
        /usr/libexec/PlistBuddy -c "Set :'Output Voice':Name com.apple.speech.synthesis.voice.custom.helena" ~/Library/Preferences/com.apple.assistant.backedup.plist
    else
        /usr/libexec/PlistBuddy -c "Set :'Output Voice':Name com.apple.speech.synthesis.voice.custom.helena" ~/Library/Preferences/com.apple.assistant.backedup.plist
    fi
    if [[ -z $(/usr/libexec/PlistBuddy -c "Print :'Output Voice':Gender" ~/Library/Preferences/com.apple.assistant.backedup.plist) ]] > /dev/null 2>&1
    then
        /usr/libexec/PlistBuddy -c "Add :'Output Voice':Gender integer" ~/Library/Preferences/com.apple.assistant.backedup.plist
        /usr/libexec/PlistBuddy -c "Set :'Output Voice':Gender 2" ~/Library/Preferences/com.apple.assistant.backedup.plist
    else
        /usr/libexec/PlistBuddy -c "Set :'Output Voice':Gender 2" ~/Library/Preferences/com.apple.assistant.backedup.plist
    fi
    
    # speech output
    # 2 = yes, 3 = no
    defaults write com.apple.assistant.backedup "Use device speaker for TTS" -integer 2
    
    # micro input (automatic)
    if [ -e ~/Library/Preferences/com.apple.Siri.plist ]
    then 
    	if [[ -z $(/usr/libexec/PlistBuddy -c "Print :PreferredMicrophoneIdentifier" ~/Library/Preferences/com.apple.Siri.plist) ]] >/dev/null 2>&1
    	then
    		:
    	else
    		/usr/libexec/PlistBuddy -c "Delete :PreferredMicrophoneIdentifier" ~/Library/Preferences/com.apple.Siri.plist
    	fi
    else
    	:
    fi
    
    # hotkey
    # 0 = off, 2 = hold cmd+space, 3 = hold fn+space
    defaults write com.apple.Siri HotkeyTag -integer 0
    #/usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:176:enabled NO" ~/Library/Preferences/com.apple.symbolichotkeys.plist
    
    # menu bar icon
    defaults write com.apple.Siri StatusMenuVisible -bool false
    
    # disable all siri analytics
    # done in manual preferences script later again
    for i in $(/usr/libexec/PlistBuddy -c "Print CSReceiverBundleIdentifierState" /Users/$USER/Library/Preferences/com.apple.corespotlightui.plist | grep " = " | sed -e 's/^[ \t]*//' | awk '{print $1}')
    do
	        #echo $i
		    /usr/libexec/PlistBuddy -c "Set CSReceiverBundleIdentifierState:$i false" /Users/$USER/Library/Preferences/com.apple.corespotlightui.plist
    done
    
    
    ###
    ### preferences date & time
    ###
    
    echo preferences "date & time"
    
    ### date & time
    
    # set date and time automatically
    sudo systemsetup -setusingnetworktime on
    
    # set time server
    sudo systemsetup -setnetworktimeserver "time.euro.apple.com"
    
    
    ### timezone
    
    # set time zone automatically using current location
    sudo defaults write /Library/Preferences/com.apple.timezone.auto.plist Active -bool false
    
    # set the timezone; see "systemsetup -listtimezones" for other values
    sudo systemsetup -settimezone "Europe/Berlin"
    
    
    ### clock
    
    # show date and time in menu bar
    # see "menu bar"
    
    # time options: display the time with seconds: off
    # date options: show the day of the week: on
    # date options: show date: on
    # menu bar clock format
    # "h:mm" default
    # "HH"   use a 24-hour clock
    # "a"    show AM/PM
    # "ss"   display the time with seconds
    defaults write com.apple.menuextra.clock 'DateFormat' -string 'EEE MMM d   HH:mm'
    
    # analog menu bar clock
    ##
    defaults write com.apple.menuextra.clock IsAnalog -bool false
    
    # flash the time separators
    ##
    defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
    
    # set 24 hour clock
    ##
    defaults write NSGlobalDomain AppleICUForce24HourTime -bool true
    
    # date options
    # see above, included in time options
    
    # time announcement
    if [[ ! -e ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist ]]
    then
        /usr/libexec/PlistBuddy -c "Add TimeAnnouncementPrefs:TimeAnnouncementsEnabled bool" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist > /dev/null 2>&1
    else
        :
    fi

    if [[ -z $(/usr/libexec/PlistBuddy -c "Print TimeAnnouncementPrefs:TimeAnnouncementsEnabled" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist) ]] > /dev/null 2>&1
    then
        /usr/libexec/PlistBuddy -c "Add TimeAnnouncementPrefs:TimeAnnouncementsEnabled bool" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
        /usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsEnabled false" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    else
        /usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsEnabled false" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    fi
    #/usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsIntervalIdentifier EveryHourInterval" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    #/usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsPhraseIdentifier ShortTime" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    
    # time announcement voice config
    # custom speed
    #/usr/libexec/PlistBuddy -c "Add TimeAnnouncementPrefs:TimeAnnouncementsVoiceSettings:CustomRelativeRate integer" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    #/usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsVoiceSettings:CustomRelativeRate 1" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    
    #custom volume 
    #/usr/libexec/PlistBuddy -c "Add TimeAnnouncementPrefs:TimeAnnouncementsVoiceSettings:CustomVolume integer" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    #/usr/libexec/PlistBuddy -c "Set TimeAnnouncementPrefs:TimeAnnouncementsVoiceSettings:CustomVolume 0.5" ~/Library/Preferences/com.apple.speech.synthesis.general.prefs.plist
    
     
        
    ###
    ### preferences time machine
    ###
    
    echo "preferences time machine"
    
    # disable time machine
    ##
    sudo defaults write /Library/Preferences/com.apple.TimeMachine MobileBackups -bool false
    sudo defaults write /Library/Preferences/com.apple.TimeMachine AutoBackup -bool false
    
    # run time machine backups on battery power
    # false = yes
    sudo defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower -bool false
    
    # show warning after deleting old backups
    sudo defaults write /Library/Preferences/com.apple.TimeMachine AlwaysShowDeletedBackupsWarning -bool true
    
    # show time machine in menu bar
    # see "menu bar"
    
    ### hidden time machine tweaks
    
    # prevent time machine from prompting to use new hard drives as backup volume
    defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
    
    # disable local time machine backups / snapshots
    sudo tmutil disable
    
    # delete possible snapshots
    # list localsnapshots
    #tmutil listlocalsnapshots / | cut -d'.' -f4-
    #tmutil listlocalsnapshots / | rev | cut -d'.' -f1 | rev
    #tmutil listlocalsnapshotdates | grep -v '[a-zA-Z]'
    
    if [[ $(tmutil listlocalsnapshotdates | grep -v '[a-zA-Z]') == "" ]]
    then
        # no local time machine backups found
        :
    else
        echo ''
        echo "local time machine backups found, deleting..."
        for i in $(tmutil listlocalsnapshotdates | grep -v '[a-zA-Z]')
        do
        	tmutil deletelocalsnapshots "$i"
        done
        echo ''
    fi
    
    
    
    ###
    ### cd & dvd
    ###
    
    echo "cd & dvd"
    
    # disable blank cd automatic action
    defaults write com.apple.digihub com.apple.digihub.blank.cd.appeared -dict action 1
    
    # disable music cd automatic action
    defaults write com.apple.digihub com.apple.digihub.cd.music.appeared -dict action 1
    
    # disable picture cd automatic action
    defaults write com.apple.digihub com.apple.digihub.cd.picture.appeared -dict action 1
    
    # disable blank dvd automatic action
    defaults write com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict action 1
    
    # disable video dvd automatic action
    defaults write com.apple.digihub com.apple.digihub.dvd.video.appeared -dict action 1
    
    
    
    ###
    ### more hidden tweaks
    ###
    
    echo "more hidden tweaks"
    
    # reopen all windows after next login
    # false = disable, true = enable
    defaults write com.apple.loginwindow TALLogoutSavesState -bool false
    
    # expand save panel by default
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
    
    # expand print panel by default
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
    
    # save to disk (not to icloud) by default
    # false = save to disk, true = save to icloud
    defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
    
    # automatically quit printer app once the print jobs complete
    defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
    
    # disable the "are you sure you want to open this application?" dialog
    #defaults write com.apple.LaunchServices LSQuarantine -bool false
    
    # increase window resize speed for cocoa applications
    #defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
    
    # remove duplicates in the open with menu (also see `lscleanup` alias)
    #echo removing duplicate entries in open with menu, this can take a while...
    #/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user
    
    # display ascii control characters using caret notation in standard text views
    # try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
    #defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true
    
    # disable transparency in the menu bar and elsewhere
    #defaults write com.apple.universalaccess reduceTransparency -bool true
    
    # disable automatic termination of inactive apps
    #defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true
    
    # disable the crash reporter
    #defaults write com.apple.CrashReporter DialogType -string "none"
    
    # turning crash reporter back on
    #defaults write com.apple.CrashReporter DialogType -string "crashreport"
    
    # set help viewer windows to non-floating mode
    #defaults write com.apple.helpviewer DevMode -bool true
    
    # reveal ip address, hostname, os version, etc. when clicking the clock in the login window
    #sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
    
    # restart automatically if the computer freezes
    #sudo systemsetup -setrestartfreeze on
    
    # use encrypted virtual memory
    #defaults write com.apple.virtualMemory UseEncryptedSwap -bool YES
    
    
    ### screenshots
    
    # save screenshots to the desktop
    defaults write com.apple.screencapture location -string "${HOME}/Desktop"
    
    # save screenshots in png format
    # other options: bmp, gif, jpg, pdf, tiff
    defaults write com.apple.screencapture type -string "jpg"
    
    # disable shadow in screenshots
    # true = shadow disabled
    defaults write com.apple.screencapture disable-shadow -bool true
    
    
    ###
    ### macbook pro touchbar
    ###
    
    # always display full control strip (ignoring app Controls)
    #defaults write com.apple.touchbar.agent PresentationModeGlobal fullControlStrip
    
    
    
    ###
    ### finder                                                                    
    ###
    
    echo "finder"
    
    ### general
    
    # show icons for hard drives, servers, and removable media on the desktop
    defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
    defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
    defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
    
    # open cmd+doubleclicked folders in new tab
    defaults write com.apple.Finder FinderSpawnTab -bool true
    
    
    ### sidebar
    
    # system items
    defaults write com.apple.sidebarlists systemitems -dict-add ShowEjectables -bool true
    defaults write com.apple.sidebarlists systemitems -dict-add ShowRemovable -bool true
    defaults write com.apple.sidebarlists systemitems -dict-add ShowServers -bool true
    defaults write com.apple.sidebarlists systemitems -dict-add ShowHardDisks -bool true
    
    
    ### advanced
    
    # show all filename extensions
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    
    # warning when changing a file extension
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool true
    
    # warning before deleting from icloud drive
    defaults write com.apple.finder FXEnableRemoveFromICloudDriveWarning -bool true
    
    # warning before emptying the Trash
    defaults write com.apple.finder WarnOnEmptyTrash -bool false
    
    # delete items in trash after 30 days automatically
    defaults write com.apple.finder FXRemoveOldTrashItems -bool false
    
    # sort folders on top
    defaults write com.apple.finder _FXSortFoldersFirst -bool false
    
    # when performing a search, search the current folder by default
    defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
    
    
    ### more finder tweaks
    
    # empty trash securely by default
    defaults write com.apple.finder EmptyTrashSecurely -bool false
    
    # allow quitting via cmd + Q; doing so will also hide desktop icons
    #defaults write com.apple.finder QuitMenuItem -bool true
    
    # disable window animations and get info animations
    #defaults write com.apple.finder DisableAllAnimations -bool true
    
    # set default location for new finder windows
    # for other paths, use `PfLo` and `file:///full/path/here/`
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"
    
    # show hidden files by default
    #defaults write com.apple.finder AppleShowAllFiles -bool true
    
    # show recent tags
    # see separate finder sidebar script
    #defaults write com.apple.finder ShowRecentTags -bool false
    
    # show side bar
    defaults write com.apple.finder ShowSidebar -bool true
    
    # show status bar
    ##
    defaults write com.apple.finder ShowStatusBar -bool false
    
    # show path bar
    ##
    defaults write com.apple.finder ShowPathbar -bool false
    
    # show tab bar
    ##
    defaults write com.apple.finder ShowTabView -bool false
    
    # show preview pane
    #defaults write com.apple.finder ShowPreviewPane -bool false
    
    # allow text selection in quick look
    defaults write com.apple.finder QLEnableTextSelection -bool true
    
    # display full posix path as finder window title
    ##
    defaults write com.apple.finder _FXShowPosixPathInTitle -bool false
    
    # do not reopen finder windows after reboot
    defaults write com.apple.finder NSQuitAlwaysKeepsWindows -bool false
    
    # enable spring loading for directories
    #defaults write NSGlobalDomain com.apple.springing.enabled -bool true
    
    # remove the spring loading delay for directories
    #defaults write NSGlobalDomain com.apple.springing.delay -float 0
    
    # avoid creating .DS_Store files on network volumes
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
    
    # disable disk image verification
    #defaults write com.apple.frameworks.diskimages skip-verify -bool true
    #defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    #defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
    
    # automatically open a new finder window when a volume is mounted
    #defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
    #defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
    #defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true
    
    # show item info near icons on the desktop and in other icon views
    #/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" ~/Library/Preferences/com.apple.finder.plist
    
    # show item info to the right of the icons on the desktop
    #/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" ~/Library/Preferences/com.apple.finder.plist
    
    # enable snap-to-grid for icons on the desktop and in other icon views
    #/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    
    # increase grid spacing for icons on the desktop and in other icon views
    #/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" ~/Library/Preferences/com.apple.finder.plist
    
    # increase the size of icons on the desktop and in other icon views
    #/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    #/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" ~/Library/Preferences/com.apple.finder.plist
    
    # set default view in all finder windows by default
    # Four-letter codes for the view modes: `icnv`, `clmv`, `Flwv`, "Nlsv"
    defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
    
    # enable airdrop over ethernet and on unsupported macs
    #defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
    
    ### show the ~/Library folder
    # show extended attributes
    #ls -la@e ~/
    #xattr ~/Library
    #xattr -p com.apple.FinderInfo ~/Library
    #xattr -l ~/Library
    # show extended attributes to copy / paste for restore with xattr -wx
    #xattr -px com.apple.FinderInfo ~/Library
    # delete all extended attributes
    #xattr -c ~/Library
    # delete specific extended attribute
    if [[ $(xattr -l ~/Library | grep com.apple.FinderInfo) == "" ]]
    then
        :
    else
        xattr -d com.apple.FinderInfo ~/Library
    fi
    # set folder flag to not hidden
    chflags nohidden ~/Library
    
    ### undo show the ~/Library folder
    # set extended attribute
    #xattr -wx com.apple.FinderInfo "00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00
    #00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00" ~/Library
    #xattr -l ~/Library
    #chflags hidden ~/Library
    #ls -la@e ~/
    
    # remove dropbox‚ set green checkmark icons in finder
    #file=/Applications/Dropbox.app/Contents/Resources/emblem-dropbox-uptodate.icns
    #[ -e "${file}" ] && mv -f "${file}" "${file}.bak"
    
    # expand the following file info panes (cmd + i)
    defaults write com.apple.finder FXInfoPanesExpanded -dict \
    	General -bool true \
    	OpenWith -bool true \
    	Privileges -bool true


    
    ###
    ### launchpad
    ###
    
    echo "launchpad"
    
    
    # disable the launchpad gesture (pinch with thumb and three fingers)
    #defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
    
    # reset launchpad, but keep the desktop wallpaper intact
    #find "${HOME}/Library/Application Support/Dock" -name "*-*.db" -maxdepth 1 -delete
    
    # add ios simulator to launchpad
    #sudo ln -sf "/Applications/Xcode.app/Contents/Developer/Applications/iOS Simulator.app" "/Applications/iOS Simulator.app"
    
    
    
    ###
    ### safari & webkit                                                           
    ###
    
    echo "safari & webkit"
    
    SAFARI_PREFERENCES_FILE="/Users/$USER/Library/Containers/com.apple.Safari/Data/Library/Preferences/com.apple.Safari.plist"
    
    ### safari general
    
    # safari opens with: a new window
    ##
    defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool false
    
    # new windows open with: empty page
    ##
    defaults write com.apple.Safari NewWindowBehavior -int 1
    
    # new tabs open with: empty page
    ##
    defaults write com.apple.Safari NewTabBehavior -int 1
    
    # set safaris home page to `about:blank` for faster loading
    defaults write com.apple.Safari HomePage -string "about:blank"
    
    # days of keeping history
    defaults write com.apple.Safari HistoryAgeInDaysLimit -int 1
    
    # in favorites
    # FavoritesViewCollectionBookmarkUUID       # big string uuid
    
    # topsites arrangement / display
    # 0 = 6 sites
    # 1 = 12 sites
    # 2 = 24 sites
    defaults write com.apple.Safari TopSitesGridArrangement -int 0
    
    # set safari download path
    defaults write com.apple.Safari AlwaysPromptForDownloadFolder -bool false
    if [[ "$loggedInUser" == "tom" ]]
    then
        mkdir -p "/Users/$loggedInUser/Desktop/files"
        defaults write com.apple.Safari DownloadsPath -string "/Users/$loggedInUser/Desktop/files"
        #defaults write com.apple.Safari DownloadsPath -string "~/Desktop/files"
    else
        defaults write com.apple.Safari DownloadsPath -string "/Users/$loggedInUser/Downloads"
    fi
    
    # remove downloads list items
    # 0 = manually
    # 1 = when safari quits
    # 2 = upon successful download
    # 3 = after on day
    ##
    defaults write com.apple.Safari DownloadsClearingPolicy -int 3
    
    # open safe files after download
    ##
    defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
    
    
    ### safari tabs
    
    # open pages in tabs instead of windows
    # 0 = never
    # 1 = automatically
    # 2 = always
    ##
    defaults write com.apple.Safari TabCreationPolicy -int 1
    
    # command-clicking a link creates tabs
    ##
    defaults write com.apple.Safari CommandClickMakesTabs -bool true
    
    # make new tabs open in foreground
    ##
    defaults write com.apple.Safari OpenNewTabsInFront -bool false
    
    # command+1 through 9 switches tabs
    ##
    defaults write com.apple.Safari Command1Through9SwitchesTabs -bool false
    
    # show icons in tabs
    ##
    defaults write com.apple.Safari ShowIconsInTabs -bool false
    
    
    ### safari autofill
    
    # autofill using info from my contacts card
    ##
    defaults write com.apple.Safari AutoFillFromAddressBook -bool false
    
    # autofill user names and passwords
    ##
    defaults write com.apple.Safari AutoFillPasswords -bool false
    
    # autofill credit cards
    ##
    defaults write com.apple.Safari AutoFillCreditCardData -bool false
    
    # autofill other forms
    ##
    defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
    
    
    ### safari passwords
    # already done above, sets both to true or false
    #defaults write com.apple.Safari AutoFillPasswords -bool false
    
    
    ### safari search
    
    # default search engine (google)
    # reading values
    # defaults read -g NSPreferredWebServices
    ##
    defaults write -g NSPreferredWebServices '{NSWebServicesProviderWebSearch = { NSDefaultDisplayName = Google; NSProviderIdentifier = "com.google.www"; }; }';
    #defaults write -g NSPreferredWebServices '{NSWebServicesProviderWebSearch = { NSDefaultDisplayName = Startpage; NSProviderIdentifier = "com.startpage"; }; }';
    
    # don't send search queries to Apple and do not use spotlight suggestions
    defaults write com.apple.Safari UniversalSearchEnabled -bool false
    defaults write com.apple.Safari SuppressSearchSuggestions -bool true
    
    # quick website search
    defaults write com.apple.Safari WebsiteSpecificSearchEnabled -bool false
    
    # preload top hit in the background
    ##
    defaults write com.apple.Safari PreloadTopHit -bool false
    
    # show favorites under smart search field
    defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false
    
    
    ### safari security
    
    # warn about fraudulent websites
    ##
    defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
    
    # enable java
    ##
    defaults write com.apple.Safari WebKitJavaEnabled -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool true
    
    # enable javaScript
    ##
    defaults write com.apple.Safari WebKitJavaScriptEnabled -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptEnabled -bool true
    
    # block pop-up windows
    # option does no longer exist
    # false = yes
    ##
    #defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
    #defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
        
    
    ### safari privacy
    
    # try to prevent cross-site tracking
    # 0 = no
    # 1 = yes
    defaults write com.apple.Safari WebKitStorageBlockingPolicy -int 1
    
    # do not get tracked
    defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
    
    # block new cookies and website data
    # 0 = yes
    # 2 = no
    ##
    defaults write com.apple.Safari BlockStoragePolicy -int 3
    
    # allow websites to check if applepay is enabled
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2ApplePayCapabilityDisclosureAllowed -bool true
        
    
    ### safari websites
    
    WEBSITE_SAFARI_DATABASE="/Users/$USER/Library/Safari/PerSitePreferences.db"
    
    # general preferences
    # /Users/$USER/Library/Safari/PerSitePreferences.db
    # sqlite3 /Users/$USER/Library/Safari/PerSitePreferences.db
    # .tables
    # .headers ON
    # select * from default_preferences;
    # id|preference|default_value
    # xx|PerSitePreferencesCamera|1
    # xx|PerSitePreferencesAutoplay|0
    # xx|PerSitePreferencesUseReader|0
    # xx|PerSitePreferencesContentBlockers|0
    # xx|PerSitePreferencesMicrophone|0
    # example
    # UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesCamera';
    # select * from default_preferences;
    # .quit
    
    # per site preferences
    # /Users/$USER/Library/Safari/PerSitePreferences.db
    # sqlite3 /Users/$USER/Library/Safari/PerSitePreferences.db
    # .tables
    # .headers ON
    # select * from preference_values;
    # id|domain|preference|preference_value|timestamp
    # 1|watch.nba.com|PerSitePreferencesAutoplay|0|
    # example
    # UPDATE preference_values SET preference_value='0' WHERE (preference='PerSitePreferencesAutoplay' and domain='watch.nba.com');
    # select * from preference_values;
    # .quit
    
    # checking values
    # sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;"
    # sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from preference_values;"
    
    # resetting / deleting values
    # sqlite3 "$WEBSITE_SAFARI_DATABASE" "delete from default_preferences WHERE preference='PerSitePreferencesMicrophone';"
    # sqlite3 "$WEBSITE_SAFARI_DATABASE" "delete from preference_values WHERE preference='PerSitePreferencesMicrophone';"
    
    # use reader
    # off = 0
    # on = 1
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesUseReader") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesUseReader', '0');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='0' WHERE preference='PerSitePreferencesUseReader'"
    fi
    
    # use content blocker
    # off = 0
    # on = 1
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesContentBlockers") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesContentBlockers', '1');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesContentBlockers'"
    fi
    
    # autoplay media
    # allow automatic autoplay for all = 0
    # stop media with sound = 1
    # never autoplay = 2
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesAutoplay") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesAutoplay', '1');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesAutoplay'"
    fi
    # per site preferences
    sqlite3 "$WEBSITE_SAFARI_DATABASE" "delete from preference_values WHERE preference='PerSitePreferencesAutoplay';"
    sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into preference_values (domain, preference, preference_value) values ('watch.nba.com', 'PerSitePreferencesAutoplay', '0');"
    
    # default page zoom
    # 1 = 100%, 1.25 = 125%, etc.
    defaults write com.apple.Safari DefaultPageZoom -integer 1
    
    # allow camera
    # ask = 0
    # do not allow = 1
    # allow = 2
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesCamera") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesCamera', '1');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesCamera'"
    fi
    
    # allow microphone
    # ask = 0
    # do not allow = 1
    # allow = 2
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesMicrophone") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesMicrophone', '1');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesMicrophone'"
    fi
    
    # website use of location services
    # location services in system preferences have to be enabled if option shall be enabled
    # 0 = deny without prompting
    # 1 = prompt for each website once each day
    # 2 = prompt for each website one time only
    ##
    defaults write com.apple.Safari SafariGeolocationPermissionPolicy -int 0
    
    # notifications
    # allow asking about the push notifications
    defaults write com.apple.Safari CanPromptForPushNotifications -bool false
    
    # plugins
    # enable plug-ins
    ##
    defaults write com.apple.Safari WebKitPluginsEnabled -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool true
    
    # popups
    # block and notify = 0
    # block = 1
    # allow = 2
    if [[ $(sqlite3 "$WEBSITE_SAFARI_DATABASE" "select * from default_preferences;" | grep "PerSitePreferencesPopUpWindow") == "" ]]
    then
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "insert into default_preferences (preference, default_value) values ('PerSitePreferencesPopUpWindow', '1');"
    else
        sqlite3 "$WEBSITE_SAFARI_DATABASE" "UPDATE default_preferences SET default_value='1' WHERE preference='PerSitePreferencesPopUpWindow'"
    fi
    
    # all plugins but flash are no longer allowed and are not working any more
    # enable / disable plugins individually
    # flash player
    /usr/libexec/PlistBuddy -c "Set :PlugInInfo:'com.macromedia.Flash Player.plugin':plugInCurrentState NO" "$SAFARI_PREFERENCES_FILE"
    
    # plugin policies
    # on = PlugInPolicyAllowWithSecurityRestrictions
    # off = PlugInPolicyBlock
    # ask = PlugInPolicyAsk
    
    # flash player
    /usr/libexec/PlistBuddy -c "Set :ManagedPlugInPolicies:'com.macromedia.Flash Player.plugin':PlugInFirstVisitPolicy PlugInPolicyAllowWithSecurityRestrictions" "$SAFARI_PREFERENCES_FILE"


    ### safari extensions
    
    # enable extensions
    ##
    defaults write com.apple.Safari ExtensionsEnabled -bool true
    
    # update extensions automatically
    ##
    defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
    
    
    ### safari advanced
    
    # show full url
    ##
    defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool false
    
    # do not use font size smaller than x
    # 0 = off
    # any other number for the respective font size
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2MinimumFontSize -int 0

    # press tab to highlight each item on a webpage
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool false
    
    # automatically save for offline reading
    defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool false
    
    # stop internet plug-ins to save power
    defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool false
    
    # user style sheet
    defaults write com.apple.Safari UserStyleSheetEnabled -bool false
    
    # set default encoding
    defaults write com.apple.Safari WebKitDefaultTextEncodingName -string 'iso-8859-1'
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DefaultTextEncodingName -string 'iso-8859-1'
    
    # enable the developer menu and the web inspector
    defaults write com.apple.Safari IncludeDevelopMenu -bool true
    defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
    defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true
    
    
    ### more safari settings
    
    # always show tab bar
    ##
    defaults write com.apple.Safari AlwaysShowTabBar -bool true
    
    # allow hitting the backspace key to go to the previous page in history
    #defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
    
    # show safaris bookmarks bar by default
    #defaults write com.apple.Safari ShowFavoritesBar -bool true
    ##
    defaults write com.apple.Safari ShowFavoritesBar-v2 -bool true
    
    # show sidebar by default
    ##
    defaults write com.apple.Safari ShowSidebarInNewWindows -bool false
    
    # hide safaris sidebar in top sites
    #defaults write com.apple.Safari ShowSidebarInTopSites -bool false
    
    # disable safaris thumbnail cache for history and top sites
    #defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
    
    # enable safaris debug menu
    #defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
    
    # search with contains instead of starts with
    defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
    
    # show status bar
    ##
    defaults write com.apple.Safari ShowStatusBar -bool true
    
    # disable hyperlick auditing / tracking
    defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2HyperlinkAuditingEnabled -bool false
    #defaults delete com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2HyperlinkAuditingEnabled
    
    
    
    ###
    ### mail
    ###
    
    echo "mail"
    
    MAIL_PREFERENCES_FILE="~/Library/Containers/com.apple.mail/Data/Library/Preferences/com.apple.mail.plist"


    ### general
    
    # setting time to check for messages
    # -1 = automatic
    defaults write com.apple.mail PollTime -int -1
    
    # no sound for new mails
    defaults write com.apple.mail MailSound -string ""
    
    # play sound for other mail actions
    defaults write com.apple.mail PlayMailSounds -bool true
    
    # show unread messages in dock
    # 1 = inboxes only
    # 2 = all mailboxes
    defaults write com.apple.mail MailDockBadge -int 1
    
    # notification for new messages
    # 1 = inboxes only
    # 2 = vips only
    # 3 = contacts
    # 5 = all mailboxes
    defaults write com.apple.mail MailUserNotificationScope -int 1
    
    # delete not edited attachment downloads
    # each attachment that is opened gets "downloaded" (pop3 and imap)
    # files are stored in "~/Library/Containers/com.apple.mail/Data/Library/Mail Downloads/"
    # never
    #   DeleteAttachmentsAfterHours   0
    #   DeleteAttachmentsEnabled      false
    # when mail quits
    #   DeleteAttachmentsAfterHours   0
    #   DeleteAttachmentsEnabled      true
    # when respective mail gets deleted
    #   DeleteAttachmentsAfterHours   2147483647
    #   DeleteAttachmentsEnabled      true
    defaults write com.apple.mail DeleteAttachmentsAfterHours -int 0
    defaults write com.apple.mail DeleteAttachmentsEnabled -bool true
    
    # add invitations to calendar app automatically
    # adds entry to ~/Library/Mail/V6/MailData/UnsyncedRules.plist
    
    # try sending later automatically if server for sending is offline
    defaults write com.apple.mail SuppressDeliveryFailure -bool false
    
    # when in full screen mode prefer split mode
    defaults write com.apple.mail FullScreenPreferSplit -bool true
    
    # when searching, seach in trash, chunk, decrypted messages
    defaults write com.apple.mail IndexTrash -bool true
    defaults write com.apple.mail IndexJunk -bool true
    defaults write com.apple.mail IndexDecryptedMessages -bool true
    
    
    ### junk mails
    
    # filter for junk mails
    # sets values in
    # ~/Library/Mail/V6/MailData/RulesActiveState.plist
    # ~/Library/Mail/V6/MailData/UnsyncedRules.plist
    
    
    ### fonts and fonts colors
    
    # use non proportional font for pure text emails
    defaults write com.apple.mail AutoSelectFont -bool false
    
    # show quoted text in colors
    defaults write com.apple.mail ColorQuoterColorIncoming -bool true

    
    ### view
    
    # display emails in threaded mode, sorted by date
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "DisplayInThreadedMode" -string "yes"
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortedAscending" -string "yes"
    defaults write com.apple.mail DraftsViewerAttributes -dict-add "SortOrder" -string "received-date"
    
    # show from/to/cc label in mail list
    defaults write com.apple.mail EnableToCcInMessageList -bool false
    
    # show contact pictures in mail list
    defaults write com.apple.mail EnableContactPhotos -bool false
    
    # number of displayed lines
    defaults write com.apple.mail NumberOfSnippetLines -int 0
    
    # show unread messages in bold
    defaults write com.apple.mail ShouldShowUnreadMessagesInBold -bool false
    
    # copy email addresses as "foo@example.com" instead of "Foo Bar <foo@example.com>" in mail.app
    # false = copy without name
    defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false
    
    # load content from remote urls (content and pictures)
    # load content = false
    # do not load content = true
    defaults write com.apple.mail-shared DisableURLLoading -bool true
    
    # highlight non grouped messages from conversations
    defaults write com.apple.mail HighlightCurrentThread -bool true
    
    # include corresponding messages in conversations
    defaults write com.apple.mail ConversationViewSpansMailboxes -bool true
    
    # mark all messages as read when opening conversation
    defaults write com.apple.mail ConversationViewMarkAllAsRead -bool false
    
    # sort order in the conversation, latest on top
    defaults write com.apple.mail ConversationViewSortDescending -bool true
    
    
    ### writing and sending
    
    # text format
    # formatted = MIME
    # plain = Plain
    defaults write com.apple.mail SendFormat -string MIME
    
    # spell checking
    # during typing = InlineSpellCheckingEnabled
    # when clicking send = SpellCheckingOnSendEnabled
    # never = NoSpellCheckingEnabled
    defaults write com.apple.mail SpellCheckingBehavior -string InlineSpellCheckingEnabled
    
    # send copy to myself
    # copy
    defaults write com.apple.mail ReplyToSelf -bool false
    # blind copy
    defaults write com.apple.mail BccSelf -bool false

    # show all recipients when sending an email to a group
    defaults write com.apple.mail-shared ExpandPrivateAliases -bool true
    
    # highlight adresses that do not match pattern
    defaults write com.apple.mail-shared AlertForNonmatchingDomains -bool false
    
    # using the same format to rely (plain or formatted)
    defaults write com.apple.mail AutoReplyFormat -bool false

    # quote received message on reply
    defaults write com.apple.mail ReplyQuotesOriginal -bool true

    # quote in multiple levels
    # enabled = false
    # disabled = true
    defaults write com.apple.mail SupressQuoteBarsInComposeWindows -bool false
    
    # always include complete original message in quote (not just highlighted text)
    defaults write com.apple.mail AlwaysIncludeOriginalMessage -bool true
    
    
    ### signature
    
    # place signature above quoted text
    defaults write com.apple.mail SignaturePlacedAboveQuotedText -bool true
    
    # use default system font for signature
    # for enabling set SignatureIsRich -bool true in
    # ~/Library/Mail/V6/MailData/Signatures/AllSignatures.plist
    # ~/Library/Mail/V6/MailData/Signatures/SignaturesByAccount.plist  


    ### more mail tweaks
    
    # disable send and reply animations
    #defaults write com.apple.mail DisableReplyAnimations -bool true
    #defaults write com.apple.mail DisableSendAnimations -bool true
    
    # disable inline attachments (just show the icons)
    defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
    
    # always add attachments at the end of messages
    defaults write com.apple.mail AttachAtEnd -bool true
    
    # always send attachments windows friendly
    defaults write com.apple.mail SendWindowsFriendlyAttachments -bool true
    
    # flag color to display
    # 1=orange
    defaults write com.apple.mail FlagColorToDisplay -int 1

    # grammar checking
    defaults write com.apple.mail WebGrammarCheckingEnabled -bool false
    
    # spelling checking
    defaults write com.apple.mail WebContinuousSpellCheckingEnabled -bool true
    
    # automatic spelling correction
    defaults write com.apple.mail WebAutomaticSpellingCorrectionEnabled -bool false
    
    
    
    ###
    ### terminal                                                  
    ###
    
    echo "terminal"
    
    # only use utf-8 in terminal
    defaults write com.apple.terminal StringEncodings -array 4
    
    # enable "focus follows mouse" for Terminal.app and all X11 apps, i.e. hover over a window and start typing in it without clicking first
    #defaults write com.apple.terminal FocusFollowsMouse -bool true
    #defaults write org.x.X11 wm_ffm -bool true
    
    # install the solarized dark theme for iTerm
    #open "${HOME}/init/Solarized Dark.itermcolors"
    
    # don't display the annoying prompt when quitting iTerm
    #defaults write com.googlecode.iterm2 PromptOnQuit -bool false
    
    # secure keyboard entry
    defaults write com.apple.terminal SecureKeyboardEntry -bool true
    # check
    #defaults read -app Terminal SecureKeyboardEntry

    
    
    ###
    ### activity monitor
    ###
    
    echo "activity monitor"
    
    
    # show the main window when launching activity monitor
    defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
    
    # visualize cpu usage in the activity monitor dock icon
    defaults write com.apple.ActivityMonitor IconType -int 5
    
    # show all processes in activity monitor
    defaults write com.apple.ActivityMonitor ShowCategory -int 0
    
    # sort activity monitor results by cpu usage
    defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
    defaults write com.apple.ActivityMonitor SortDirection -int 0
    
    
    
    ###
    ### contacts
    ###
    
    echo "contacts"
    
    # enable the debug menu in contacts
    #defaults write com.apple.addressbook ABShowDebugMenu -bool true
    
    # enable dashboard dev mode (allows keeping widgets on the desktop)
    #defaults write com.apple.dashboard devmode -bool true
    
    # show first name
    # 1 = before last name
    # 2 = following last name
    defaults write NSGlobalDomain NSPersonNameDefaultDisplayNameOrder -integer 2
    
    # sort by
    ##
    defaults write ~/Library/Preferences/com.apple.AddressBook ABNameSortingFormat -string "sortingLastName sortingFirstName"
    
    # short name format
    # 0 = full name
    # 1 = first name & last initial
    # 2 = first initial & last name
    # 3 = first name only
    # 4 = last name only
    defaults write NSGlobalDomain NSPersonNameDefaultShortNameFormat -integer 0
    
    # prefer nicknames
    # 1=yes, 0=no
    ##
    defaults write NSGlobalDomain NSPersonNameDefaultShouldPreferNicknamesPreference -integer 0
    
    # show contacts found in siri / mail
    ##
    defaults write com.apple.suggestions.plist SuggestionsShowContactsFoundInMail -bool false
    
    # address format
    ##
    defaults write ~/Library/Preferences/com.apple.AddressBook ABDefaultAddressCountryCode -string "de"
    
    # vcard format
    # false = 3.0
    # true = 2.1
    defaults write ~/Library/Preferences/com.apple.AddressBook ABUse21vCardFormat -bool false
    
    # enable private me card
    ##
    defaults write ~/Library/Preferences/com.apple.AddressBook ABPrivateVCardFieldsEnabled -bool false
    
    # export notes in vcards
    ##
    defaults write ~/Library/Preferences/com.apple.AddressBook ABIncludeNotesInVCard -bool true
    
    # export photos in vcards
    ##
    defaults write ~/Library/Preferences/com.apple.AddressBook ABIncludePhotosInVCard -bool true
    
    
    ###
    ### text edit
    ###
    
    echo "text edit"
    
    # use plain text mode for new textedit documents
    #defaults write com.apple.TextEdit RichText -int 0
    
    # show page breaks in new documents by default
    defaults write com.apple.TextEdit ShowPageBreaks -bool false
    
    # window size for new documents default
    defaults write com.apple.TextEdit HeightInChars -int 50
    defaults write com.apple.TextEdit WidthInChars -int 120
    
    # open and save files as utf-8 in textedit
    defaults write com.apple.TextEdit PlainTextEncoding -int 4
    defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4
    
    # check spelling while typing
    defaults write com.apple.TextEdit CheckSpellingWhileTyping -bool true   
    
    # check spelling and grammar
    defaults write com.apple.TextEdit CheckGrammarWithSpelling -bool false
    
    # correct spelling automatically
    defaults write com.apple.TextEdit CorrectSpellingAutomatically -bool false
    
    # check show ruler
    defaults write com.apple.TextEdit ShowRuler -bool true
    
    # data detection
    defaults write com.apple.TextEdit DataDetectors -bool false
    
    # smart substitutions of quotes and dashes only in formatted documents
    defaults write com.apple.TextEdit SmartSubstitutionsEnabledInRichTextOnly -bool true
    
    # smart copy paste
    defaults write com.apple.TextEdit SmartCopyPaste -bool true
    
    # disable smart quotes in textedit
    defaults write com.apple.TextEdit SmartQuotes -bool false
    #defaults write ~/Library/Containers/com.apple.TextEdit/Data/Library/Preferences/com.apple.TextEdit.plist SmartQuotes -bool false

    # disable smart dashes in textedit
    defaults write com.apple.TextEdit SmartDashes -bool false
    #defaults write ~/Library/Containers/com.apple.TextEdit/Data/Library/Preferences/com.apple.TextEdit.plist SmartDashes -bool false

    # enable smart links in textedit
    defaults write com.apple.TextEdit SmartLinks -bool true
    #defaults write ~/Library/Containers/com.apple.TextEdit/Data/Library/Preferences/com.apple.TextEdit.plist SmartLinks -bool true
    
    # text replacement
    defaults write com.apple.TextEdit TextReplacement -bool true
    
    
    ###
    ### preview
    ###
    
    echo "preview"
    
    # antialias preview of documents (text and lines)
    #defaults write ~/Library/Containers/com.apple.Preview/Data/Library/Preferences/com.apple.Preview.plist PVPDFAntiAliasOption -bool false
    
    # when opening multiple images open
    # all in same window = 0
    # groups in same window = 1
    # every file in separate window = 2
    defaults write com.apple.Preview PVImageOpeningMode -int 0

    
    
    ###
    ### disk utility
    ###
    
    echo "disk utility"
    
    
    # enable the debug menu in disk utility
    #defaults write com.apple.DiskUtility advanced-image-options -bool true
    
    # show all devices
    defaults write com.apple.DiskUtility SidebarShowAllDevices -bool true
    
    
    ###
    ### calendar
    ###
    
    echo "calendar"
    
    ### accepting privacy policy
    defaults write com.apple.iCal "privacyPaneHasBeenAcknowledgedVersion" -int 4


    ### general
    
    # show 7 days
    ##
    defaults write com.apple.iCal "n days of week" -int 7
    
    # week starts on monday
    ##
    defaults write com.apple.iCal "first day of week" -int 1
    
    # in weekly view scroll by week
    # week = 1, day = 0
    ##
    defaults write com.apple.iCal "scroll by weeks in week view" -integer 1
    
    # work day starts at
    # 480 = 8 a.m.
    defaults write com.apple.iCal "first minute of work hours" -integer 480
    
    # work day ends at
    # 1.020 = 5 p.m.
    defaults write com.apple.iCal "last minute of work hours" -integer 1020
    
    # number of hours displayed
    defaults write com.apple.iCal "number of hours displayed" -integer 12
    
    # default calendar
    defaults write com.apple.iCal "CalDefaultCalendar" -string "UseLastSelectedAsDefaultCalendar"
    
    # display birthdays calendar
    ##
    defaults write com.apple.iCal "display birthdays calendar" -bool true
    
    # display holiday calendar
    defaults write com.apple.iCal "add holiday calendar" -bool false
    
    # display "found in siri / apps" calendar
    defaults write com.apple.suggestions.plist SuggestionsShowEventsFoundInMail -bool false
    
    # show alternate calendar
    #defaults write com.apple.iCal "CALPrefOverlayCalendarIdentifier" -string "chinese"
    
    
    ### notifications
    
    # time to leave
    defaults write com.apple.iCal "TimeToLeaveEnabled" -bool false
    
    # invitations of shared calendars in notifications
    # enabled = false
    # disabled = true
    defaults write com.apple.iCal "SharedCalendarNotificationsDisabled" -bool true

    # invitations in notifications
    # enabled = false
    # disabled = true
    defaults write com.apple.iCal "InvitationNotificationsDisabled" -bool false

    
    ### advanced
    
    # time zone support
    ##
    defaults write com.apple.iCal "TimeZone support enabled" -bool false
    
    # show events in year view
    defaults write com.apple.iCal "Show heat map in Year View" -bool false
    
    # show week numbers
    defaults write com.apple.iCal "Show Week Numbers" -bool false
    
    # open events in new windows
    defaults write com.apple.iCal "OpenEventsInWindowType" -bool false
    
    # warn before sending invitations
    defaults write com.apple.iCal "WarnBeforeSendingInvitations" -bool true
    
    
    ### more calendar settings
    
    # show sidebar
    defaults write com.apple.iCal "CalendarSidebarShown" -bool true
    
    # show event times
    defaults write com.apple.iCal "Show time in Month View" -bool true
    
    
    
    ###
    ### archive utility
    ###
    
    echo "archive utility"
    
    # move archives to trash after extraction
    #defaults write com.apple.archiveutility "dearchive-move-after" -string "~/.Trash"
    
    # don't reveal extracted items
    #defaults write com.apple.archiveutility "dearchive-reveal-after" -bool false
    
    
    
    ###
    ### xcode
    ###
    
    echo "xcode"
    
    # backup and restore other xcode preferences from ~/Library/Developer/Xcode/UserData
    
    # agree to xcode system wide
    #sudo xcodebuild -license
    
    # always use spaces for indenting
    #defaults write com.apple.dt.Xcode DVTTextIndentUsingTabs -bool false
    
    # show tab bar
    #defaults write com.apple.dt.Xcode AlwaysShowTabBar -bool true
    
    # show line numbers
    defaults write com.apple.dt.Xcode DVTTextShowLineNumbers -boolean true
    
    
    
    ###
    ### messages
    ###
    
    echo "messages"
    
    # disable automatic emoji substitution (i.e. use plain text smileys)
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false
    
    # disable smart quotes as it is annoying for messages that contain code
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false
    
    # disable continuous spell checking
    #defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false
    
    
    
    ###
    ### pages
    ###
    
    echo "pages"
    
    defaults write com.apple.iWork.Pages TSWPAutomaticSpellingCorrection -bool false
    #defaults write com.apple.iWork.Pages NSDocumentSuppressTempVersionStoreWarning -bool true
    
    
    
    ###
    ### photos
    ###
    
    # preventing photos from opening automatically when devices are plugged in
    defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
    
        
    
    ###
    ### mojave specific app changes
    ###
    


    ###
    ### links to core service utilities
    ###
    
    # lining core service utilities to /Applications/Utilities
    
    echo "creating links from core service apps..."
    
    for CORE_SERVICE_APP_PATH in /System/Library/CoreServices/Applications/*
    do
        CORE_SERVICE_APP=$(basename -- "$CORE_SERVICE_APP_PATH")
        #echo "$CORE_SERVICE_APP"
        if [[ ! -e /Applications/Utilities/"$CORE_SERVICE_APP" ]]
        then
            sudo ln -s /System/Library/CoreServices/Applications/"$CORE_SERVICE_APP" /Applications/Utilities/"$CORE_SERVICE_APP"
        else
            :
        fi
        #echo ''
    done
    
    if [[ ! -e "/Applications/Finder.app" ]] && [[ -e "/System/Library/CoreServices/Finder.app" ]]
    then
        ln -s "/System/Library/CoreServices/Finder.app" "/Applications/Finder.app"
    else
        :
    fi
    
    # ios simulator
    #sudo ln -s "/Applications/Xcode.app/Contents/Applications/iPhone Simulator.app" "/Applications/iOS Simulator.app"
    
    echo "done linking"
    
    
    
    ###
    ### repairing permissions
    ###
    
    # seems to no longer work from 10.11 on
    
    #sudo diskutil verifyvolume /Volumes/macintosh_hd
    #sudo diskutil repairvolume /Volumes/macintosh_hd
    
    
    
    ###
    ### enabling filevault
    ###
    
    # this can not be done before using the sharing command or login will not work after a reboot if the sharing command is used after enabling_filevault (in this script done by public shared folder and sharing user)
    # this is why enabling_filevault is moved to the end of this script to avoid complications with other commands, leave it to ensure maximum compatibility
    enabling_filevault
    sleep 3
    
    # destroying filevault key when going to standby
    sudo pmset -a destroyfvkeyonstandby 1
    # check
    # 1 = on / yes
    #pmset -g | grep DestroyFVKeyOnStandby
    
    
    ### removing security permissions
    remove_apps_security_permissions_stop
    
    
    ###
    ### killing affected applications
    ###
    
    echo "restarting affected apps"
    
    for app in "Activity Monitor" "Calendar" "Contacts" "cfprefsd" "blued" "Dock" "Finder" "Mail" "Messages" "System Preferences" "Safari" "SystemUIServer" "TextEdit" "ControlStrip" "Photos"; do
    	killall "${app}" > /dev/null 2>&1
    done
    
}

FILE_NAME=$(basename "$BASH_SOURCE")

setting_preferences 2>&1 | tee "$HOME"/Desktop/"$FILE_NAME"_log.txt

echo "done ;)"
echo "a few changes need a reboot or logout to take effect"
echo "initializing reboot"

osascript -e 'tell app "loginwindow" to «event aevtrrst»'       # reboot
#osascript -e 'tell app "loginwindow" to «event aevtrsdn»'       # shutdown
#osascript -e 'tell app "loginwindow" to «event aevtrlgo»'       # logout

###
### unsetting password
###

unset SUDOPASSWORD


