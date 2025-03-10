#!/bin/bash

if [ $(id -u) -ne 0 ]
then 
    echo "script is not run as root, exiting..."
    exit
else
    :
fi

### variables
SERVICE_NAME=com.hostsfile.install_update
SCRIPT_NAME=hosts_file_generator

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
hosts_file_install_update() {
    
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
	# checking modification date of /etc/hosts
    UPDATEEACHDAYS=4
    if [ "$(find /etc/* -name 'hosts' -maxdepth 0 -type f -mtime +"$UPDATEEACHDAYS"d | grep -x '/etc/hosts')" == "" ]
    then
        echo "/etc/hosts was already updated in the last "$UPDATEEACHDAYS" days, no need to update..."
        echo "exiting script..."
        exit
    else
        echo "/etc/hosts is older than "$UPDATEEACHDAYS" days, updating..."
    fi
    
    # giving the online check some time if run on laptop to switch to correct network profile on boot
    ping -c5 google.com >/dev/null 2>&1
    if [[ "$?" = 0 ]]
    then
        :
    else
        echo "not online, waiting 120s for next try..."
        sleep 120
    fi
 
    # checking if online
    ping -c5 google.com >/dev/null 2>&1
    if [[ "$?" = 0 ]]
    then
        echo "we are online, updating hosts file..."
    
        # creating installation directory
        mkdir -p /Applications/hosts_file_generator/
    
        # downloading / updating hosts file creator from git repository
        if [[ -d /Applications/hosts_file_generator/.git ]]
        then
            # updating
            echo "updating hosts file generator..."
            if [[ -d /Applications/hosts_file_generator/ ]]
            then
                cd /Applications/hosts_file_generator/
                sudo git fetch --all
                sudo git reset --hard origin/master
                sudo git pull origin master
                cd -
            else
                :
            fi
        else
            # installing
            echo "downloading hosts file generator..."
            if [[ -d /Applications/hosts_file_generator/ ]]
            then
                sudo rm -rf /Applications/hosts_file_generator/
                mkdir -p /Applications/hosts_file_generator/
                git clone --depth 5 https://github.com/StevenBlack/hosts.git /Applications/hosts_file_generator/
            else
                :
            fi
        fi
            
                   
        ### python version
        if [[ $(sudo -u $loggedInUser command -v brew) == "" ]]
        then
            echo ''
            echo "homebrew is not installed..."
            if [[ $(command -v pip) == "" ]]
            then
                echo "pip is not installed, installing..."
                sudo python -m ensurepip
                sudo easy_install pip
            else
                echo "pip is installed..."
                #:
            fi
        else
            echo ''
            echo "homebrew is installed..."
            # do not autoupdate homebrew
            export HOMEBREW_NO_AUTO_UPDATE=1
            # checking installed python versions
            if [[ $(sudo -u $loggedInUser brew list | grep "^python@2$") == '' ]]
            then
                echo "python2 is not installed via homebrew..."
                PYTHON2_INSTALLED="no"
            else
                echo "python2 is installed via homebrew..."
                PYTHON2_INSTALLED="yes"
                #sudo -u $loggedInUser brew uninstall --ignore-dependencies python@2
            fi
            if [[ $(sudo -u $loggedInUser brew list | grep "^python$") == '' ]]
            then
                # the project drops python2 support, so make sure python3 is installed
                echo "python3 is not installed via homebrew, installing..."
                PYTHON3_INSTALLED="no"
                sudo -u $loggedInUser brew install python
            else
                echo "python3 is installed via homebrew..."
                PYTHON3_INSTALLED="yes"
                #sudo -u $loggedInUser brew uninstall --ignore-dependencies python@3
            fi
            # making sure pip3 is installed
            if [[ $PYTHON_VERSION == "python3" ]]
            then
                if [[ $(command -v pip3) == "" ]]
                then
                    sudo -u $loggedInUser brew reinstall python
                else
                    :
                fi
            else
                :
            fi
        fi
        
        # listing installed python versions
        echo ''
        echo "installed python versions..."
        APPLE_PYTHON_VERSION=$(python --version 2>&1)
        printf "%-25s %-25s\n" "apple python" "$APPLE_PYTHON_VERSION"
        if [[ $PYTHON2_INSTALLED == "yes" ]]
        then
            PYTHON2_VERSION=$(python2 --version 2>&1)
            printf "%-25s %-25s\n" "python2" "$PYTHON2_VERSION"
        else
            :
        fi
        if [[ $PYTHON3_INSTALLED == "yes" ]]
        then
            PYTHON3_VERSION=$(python3 --version 2>&1)
            printf "%-25s %-25s\n" "python3" "$PYTHON3_VERSION"
        else
            :
        fi
        
        # the project is python3 only (from 2018-09), so make sure python3 is used
        if [[ $(python --version 2>&1 | awk '{print $NF}' | cut -d'.' -f1) != "3" ]] && [[ $(compgen -c python | grep "^python3$") == "" ]]
        then
            echo "python3 is not installed, exiting..."
            echo ''
            exit
        else
            PYTHON_VERSION='python3'
            PIP_VERSION='pip3'
        fi
        
        echo ''
        echo "python version used in script is $PYTHON_VERSION with $PIP_VERSION..."
        echo ''


        ### updating
        # updating pip itself
        if [[ $(command -v pip) != "" ]]
        then
            sudo pip install --upgrade pip
        else
            :
        fi
        if [[ $PIP_VERSION != 'pip' ]]
        then
            sudo -u $loggedInUser ${PIP_VERSION} install --upgrade pip
        else
            :
        fi
        
        # updating all pip modules
        if [[ $PYTHON_VERSION == 'python' ]]
        then
            # do not update internal apple site-packages to ensure compatibility
            :
        else
            ${PIP_VERSION} freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 sudo -u $loggedInUser ${PIP_VERSION} install -U
        fi
        
        # installing dependencies
        if [[ $PYTHON_VERSION == 'python3' ]]
        then
            #if [[ $(cat /Applications/hosts_file_generator/requirements.txt | grep "lxml==4.1.1") != "" ]]
            #then
            #    sed -i '' "s|lxml.*|lxml>=4.2.4|" /Applications/hosts_file_generator/requirements.txt
            #else
            #    :
            #fi
            sudo -u $loggedInUser ${PIP_VERSION} install -r /Applications/hosts_file_generator/requirements.txt
        else
            #sudo pip install -r /Applications/hosts_file_generator/requirements.txt
            sudo pip install --user -r /Applications/hosts_file_generator/requirements.txt
        fi
        
        # backing up original hosts file
        if [ ! -f /etc/hosts.orig ];
        then
            echo "backing up original hosts file..."
            sudo cp -a /etc/hosts /etc/hosts.orig
        else
            :
        fi
    
        # updating / creating hostsfile
        echo ''
        echo "updating hosts file..."
        cd /Applications/hosts_file_generator/

        # as the script is run as root from a launchd some env variables are not set, e.g. all locales
        # setting LC_ALL for root solves
        # UnicodeDecodeError: 'ascii' codec can't decode byte 0xe2 in position 13: ordinal not in range(128)
        LANG_SCRIPT=de_DE.UTF-8
        
        sudo LC_ALL=$LANG_SCRIPT ${PYTHON_VERSION} updateHostsFile.py -a -r -o alternates/gambling-porn -e gambling porn
        if [[ $? -eq 0 ]]
        then
            echo ''
            echo "updating hosts file SUCCESSFULL..."
            echo ''
        else
            echo ''
            echo "updating hosts file FAILED..."
            echo ''
        fi
        
        #sudo python updateHostsFile.py -a -n -r -o alternates/gambling-porn-social -e gambling porn social
        #sudo python updateReadme.py
        cd - >/dev/null 2>&1
    
        ### customization
        # commenting out lines
        #sudo sed -i '' '/cdn-static.liverail.com/s/^/#/g' /etc/hosts
        #or
        #sudo awk -i inplace '/cdn-static.liverail.com/ {$0="#"$0}1' /etc/hosts
        ## sport1
        #sudo sed -i '' '/probe.yieldlab.net/s/^/#/g' /etc/hosts
        # anti-adblock
        sudo sed -i '' '/0.0.0.0 prod.appnexus.map.fastly.net/s/^/#/g' /etc/hosts
        sudo sed -i '' '/0.0.0.0 acdn.adnxs.com/s/^/#/g' /etc/hosts
        ## spiegel.de
        #sudo sed -i '' '/imagesrv.adition.com/s/^/#/g' /etc/hosts        
		## google shopping
        sudo sed -i '' '/www.googleadservices.com/s/^/#/g' /etc/hosts
        sudo sed -i '' '/0.0.0.0 ad.doubleclick.net/s/^/#/g' /etc/hosts
        sudo sed -i '' '/pagead.l.doubleclick.net/s/^/#/g' /etc/hosts
        ## wimbledon
        #sudo sed -i '' '/0.0.0.0 secure.brightcove.com/s/^/#/g' /etc/hosts
        ## sma
        sudo sed -i '' '/0.0.0.0 eu.*.force.com/s/^/#/g' /etc/hosts
        #sudo sed -i '' '/0.0.0.0 eu1.*.force.com/s/^/#/g' /etc/hosts
        #sudo sed -i '' '/0.0.0.0 eu10.force.com/s/^/#/g' /etc/hosts
        
        # wimbledon test
        #for i in $(sudo cat /etc/hosts | grep "^0.*" | awk '{print $NF}' | head -n 10000)
        #do
        #    sudo sed -i '' "/$i/s/^/#/g" /etc/hosts
        #done
        
        # testing
        # open respective website in browser
        # deactivate adblocker for the website
        # open /etc/hosts in gas mask and add / delete entries
        #sudo killall -HUP mDNSResponder && sleep 2 && open -a /Applications/Firefox.app && sleep 2 && open -a /Applications/Firefox.app http://www.wimbledon.com/en_GB/video/highlights.html


        ### activating hosts file
        echo "activating hosts file..."
        # older osx versions
        #sudo dscacheutil -flushcache
        # newer macos versions
        sudo killall -HUP mDNSResponder
        
        # done
        echo ''
        echo 'done ;)'
        echo ''
        
    else
        echo "we are not not online, skipping update of hosts file, exiting script..."
    fi
	
}

(time hosts_file_install_update) 2>&1 | tee -a "$LOGFILE"
echo '' >> "$LOGFILE"
