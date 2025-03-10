#!/bin/bash

# manpage
# https://developer.apple.com/library/mac/documentation/Darwin/Reference/ManPages/man8/networksetup.8.html

# to reset all the network settings completely do
#sudo rm -rf /Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist
#sudo rm -rf /Library/Preferences/SystemConfiguration/com.apple.network.identification.plist
#sudo rm -rf /Library/Preferences/SystemConfiguration/com.apple.wifi.message-tracer.plist
#sudo rm -rf /Library/Preferences/SystemConfiguration/NetworkInterfaces.plist
#sudo rm -rf /Library/Preferences/SystemConfiguration/preferences.plist
#sudo reboot

# a few commands
# networksetup -detectnewhardware
# networksetup -listallhardwareports
# networksetup -listallnetworkservices
# networksetup -listlocations



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
### configuring network
###

# names of devices
# networksetup -listallhardwareports
ETHERNET_DEVICE="USB 10/100/1000 LAN"
WLAN_DEVICE="Wi-Fi"

# deleting all network locations
#echo please ignore error about missing preferences.plist file, it will be created automatically
sudo rm -rf /Library/Preferences/SystemConfiguration/preferences.plist >/dev/null 2>&1
sleep 2

# creating new location automatic
echo adding location automatic
sudo networksetup -createlocation "Automatisch" populate >/dev/null 2>&1
sleep 2
sudo networksetup -switchtolocation "Automatisch"
sleep 2
sudo networksetup -setv6off "$ETHERNET_DEVICE"
#sudo networksetup -setv6automatic "$ETHERNET_DEVICE"
sleep 2
sudo networksetup -setv6off "$WLAN_DEVICE"
#sudo networksetup -setv6automatic "$WLAN_DEVICE"
echo ""
sleep 2

# creating new location office_lan
echo adding location office_lan
sudo networksetup -createlocation "office_lan"
sleep 2
sudo networksetup -switchtolocation "office_lan"
echo ""
sleep 2
sudo networksetup -createnetworkservice "$ETHERNET_DEVICE" "$ETHERNET_DEVICE"
sleep 2
sudo networksetup -setmanual "$ETHERNET_DEVICE" 172.16.1.4 255.255.255.0 172.16.1.1
sleep 2
sudo networksetup -setdnsservers "$ETHERNET_DEVICE" 172.16.1.1
sleep 2
sudo networksetup -setv6off "$ETHERNET_DEVICE"
#sudo networksetup -setv6automatic "$ETHERNET_DEVICE"
sleep 2
sudo networksetup -createnetworkservice "$WLAN_DEVICE" "$WLAN_DEVICE"
sleep 2
sudo networksetup -setv6off "$WLAN_DEVICE"
sleep 2

# creating new location wlan only dhcp
echo adding location wlan
sudo networksetup -createlocation "wlan"
sleep 2
sudo networksetup -switchtolocation "wlan"
echo ""
sleep 2
sudo networksetup -createnetworkservice "$WLAN_DEVICE" "$WLAN_DEVICE"
sleep 2
sudo networksetup -setv6off "$WLAN_DEVICE"
#sudo networksetup -setv6automatic "$WLAN_DEVICE"
sleep 2

# echo script finished
#echo ""
echo "all network locations created ;)"

# changing to automatic location
echo "changing to location wlan" 
sudo networksetup -switchtolocation "wlan"
sleep 2
echo ''


### vpn connections
show_vpn_in_menu_bar() {

    ### adding entry
    # show vpn in the menu bar
    if [[ $(defaults read com.apple.systemuiserver menuExtras | grep "vpn.menu") == "" ]]
    then
        defaults write com.apple.systemuiserver menuExtras -array-add "/System/Library/CoreServices/Menu Extras/vpn.menu"
        # do not show vpm connection time in menu bar
        # 0 = no
        # 1 = yes
        defaults write com.apple.networkConnect VPNShowTime 0
        # make changes take effect
        killall SystemUIServer -HUP
    else
        :
    fi

    ### deleting entry
    # it seems deleting entries needs a reboot for the changes to take effect
    # killall SystemUIServer -HUP is not enough

    #NotPreferredMenuExtras=(
    #"/System/Library/CoreServices/Menu Extras/vpn.menu"
    #)
    
    #for varname in "${NotPreferredMenuExtras[@]}"; 
    #do
    #    /usr/libexec/PlistBuddy -c "Delete 'menuExtras:$(defaults read ~/Library/Preferences/com.apple.systemuiserver.plist menuExtras | cat -n | grep "$varname" | awk '{print SUM $1-2}') string'" ~/Library/Preferences/com.apple.systemuiserver.plist >/dev/null 2>&1
    #    :
    #done
}

configure_fritz_vpn() {

    echo ''
    echo "vpn_connections..."
    echo ''

    ### loggedInUser
    loggedInUser=$(/usr/bin/python -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')


    ### checking homebrew and script dependencies
    if [[ $(sudo -u "$loggedInUser" command -v brew) == "" ]]
    then
        echo "homebrew is not installed, skipping vpn profiles installation..."
    else
        echo "homebrew is installed..."
        # checking for missing dependencies
        for formula in gnu-tar pigz pv coreutils gnupg
        do
        	if [[ $(sudo -u "$loggedInUser" brew list | grep "$formula") == '' ]]
        	then
        		echo """$formula"" is NOT installed, installing..."
                brew install "$formula"
        	else
        		#echo """$formula"" is installed..."
        		:
        	fi
        done
        
        ### configuring vpn connections
        # script uses https://github.com/halo/macosvpn
        #echo "configuring vpn connections..."
        SCRIPT_NAME="vpn_connections_network_macos_wr"
        SCRIPT_DIR_DEFAULTS_WRITE=$(echo "$(cd "${BASH_SOURCE[0]%/*}" && cd .. && cd .. && pwd)")
        SCRIPT_DIR_INPUT_KEEP="$SCRIPT_DIR_DEFAULTS_WRITE"/_scripts_input_keep
        if [[ -e "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".tar.gz.gpg ]]
        then
            echo ''
    		echo "unarchiving and decrypting vpn configuration script..."
    		
    		item="$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".tar.gz.gpg
    		OUTPUT_PATH="$SCRIPT_DIR_INPUT_KEEP"/
    		
            # pure .gpg
            #"$SHELL" -c 'cat '"$item"' | pv -s $(gdu -scb '"$item"' | tail -1 | awk "{print $1}" | grep -o "[0-9]\+") | gpg --batch --passphrase='"$SUDOPASSWORD"' --quiet -d -o '"$SCRIPT_DIR_INPUT_KEEP"/'"$SCRIPT_NAME"'.sh' && echo -e "\033[1;32mOK\033[0m" || echo -e "\033[1;31mFAILED\033[0m"'
            
            # .tar.gz.gpg
            "$SHELL" -c 'cat '"$item"' | pv -s $(gdu -scb '"$item"' | tail -1 | awk "{print $1}" | grep -o "[0-9]\+") | gpg --batch --passphrase='"$SUDOPASSWORD"' --quiet -d - | unpigz -dc - | gtar --same-owner -C '"$OUTPUT_PATH"' -xpf - >/dev/null 2>&1 && echo -e "\033[1;32mOK\033[0m" || echo -e "\033[1;31mFAILED\033[0m"'
            
            #echo ''			
    		if [[ -e "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh ]]
    		then
    		    USER_ID=`id -u`
    		    chown "$USER_ID":staff "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    		    chmod 700 "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    		    . "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    		    rm -f "$SCRIPT_DIR_INPUT_KEEP"/"$SCRIPT_NAME".sh
    		    show_vpn_in_menu_bar
    		else
    		    echo "script to configure vpn connections not found..."
            fi
        else
            echo ''
            echo "encrypted script to configure vpn connections not found..."
        fi
        echo ''
    fi
    
}
#configure_fritz_vpn




###
### unsetting password
###

unset SUDOPASSWORD


echo "done ;)" 
echo ''

