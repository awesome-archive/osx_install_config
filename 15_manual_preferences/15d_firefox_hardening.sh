#!/bin/bash


### variables
FIREFOX_PROFILE_PATH=$(find "/Users/""$USER""/Library/Application Support/Firefox/" -name "*.default*")
FIREFOX_PREFERENCES="/Users/""$USER""/Library/Application Support/Firefox"


### functions
reset_v1() {
	if [[ -e "$FIREFOX_PROFILE_PATH" ]]
	then
		# bookmarks
		mv "$FIREFOX_PROFILE_PATH"/places.sqlite /tmp/places.sqlite
		# show bookmark bar
		mv "$FIREFOX_PROFILE_PATH"/xulstore.json /tmp/xulstore.json
		# extensions
		mv "$FIREFOX_PROFILE_PATH"/extensions /tmp/extensions
		mv "$FIREFOX_PROFILE_PATH"/extensions.json /tmp/extensions.json
		mv "$FIREFOX_PROFILE_PATH"/browser-extension-data /tmp/browser-extension-data
	else
		:
	fi
	if [[ -e "/Users/""$USER""/Library/Application Support/Firefox" ]]
	then
		rm -rf "/Users/""$USER""/Library/Application Support/Firefox"
	else
		:
	fi
	#
	/Applications/Firefox.app/Contents/MacOS/firefox -CreateProfile default
	FIREFOX_PROFILE_PATH=$(find "/Users/""$USER""/Library/Application Support/Firefox" -name "*.default*")
	if [[ -e /tmp/places.sqlite ]]
	then
		mv /tmp/places.sqlite "$FIREFOX_PROFILE_PATH"/places.sqlite
		# clear history
		sqlite3 "$FIREFOX_PROFILE_PATH"/places.sqlite "DELETE FROM moz_historyvisits;"
		#
		mv /tmp/xulstore.json "$FIREFOX_PROFILE_PATH"/xulstore.json
		mv /tmp/extensions "$FIREFOX_PROFILE_PATH"/extensions
		mv /tmp/extensions.json "$FIREFOX_PROFILE_PATH"/extensions.json
		mv /tmp/browser-extension-data "$FIREFOX_PROFILE_PATH"/browser-extension-data
		find "$FIREFOX_PROFILE_PATH" -type f -print0 | xargs -0 chmod 644
		find "$FIREFOX_PROFILE_PATH" -type d -print0 | xargs -0 chmod 700
		chown -R $USER:staff "$FIREFOX_PROFILE_PATH"/*
	else
		:
	fi
}

reset_v2() {
	if [[ -e "$FIREFOX_PROFILE_PATH" ]]
	then
		cd "$FIREFOX_PROFILE_PATH"
		ls -1 "$FIREFOX_PROFILE_PATH" | \
		grep -v "^places.sqlite$" | \
		grep -v xulstore.json | \
		grep -v extensions | \
		grep -v extensions.json | \
		grep -v browser-extension-data | \
		xargs rm -rf
		cd - >/dev/null 2>&1
	
		sqlite3 "$FIREFOX_PROFILE_PATH"/places.sqlite "DELETE FROM moz_historyvisits;"
	else
		:
	fi
}


### script
read -p "do you want to Harden only or completely Reset and then harden firefox (H/r)? " CONT1
CONT1="$(echo "$CONT1" | tr '[:upper:]' '[:lower:]')"    # tolower

if [[ "$CONT1" == "r" || "$CONT1" == "reset" ]]
then
	#reset_v1
	reset_v2
else
    :
fi

# hardening
# very restrictive
curl https://raw.githubusercontent.com/pyllyukko/user.js/master/user.js > "$FIREFOX_PROFILE_PATH"/user.js
# less restrictive
#curl https://raw.githubusercontent.com/pyllyukko/user.js/relaxed/user.js > "$FIREFOX_PROFILE_PATH"/user.js
chown $USER:staff "$FIREFOX_PROFILE_PATH"/user.js
chmod 644 "$FIREFOX_PROFILE_PATH"/user.js

# custom options
echo '' >> "$FIREFOX_PROFILE_PATH"/user.js
# start with default:blank
echo "// more custom options" >> "$FIREFOX_PROFILE_PATH"/user.js
if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*browser.startup.page.*") == "" ]]
then
	echo 'user_pref("browser.startup.page", 0);' >> "$FIREFOX_PROFILE_PATH"/user.js
else
	sed -i '' 's|^user_pref.*browser.startup.page.*|user_pref("browser.startup.page", 0);|' "$FIREFOX_PROFILE_PATH"/user.js
fi
# always enable tracking protection
if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^privacy.trackingprotection.enabled.*") == "" ]]
then
	echo 'user_pref("privacy.trackingprotection.enabled", true);' >> "$FIREFOX_PROFILE_PATH"/user.js
else
	sed -i 's|^user_pref.*privacy.trackingprotection.enabled.*|user_pref("privacy.trackingprotection.enabled", true);|' "$FIREFOX_PROFILE_PATH"/user.js
fi 
# theme light
if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*lightweightThemes.selectedThemeID.*") == "" ]]
then
	echo 'user_pref("lightweightThemes.selectedThemeID", "firefox-compact-light@mozilla.org");' >> "$FIREFOX_PROFILE_PATH"/user.js
else
	sed -i '' 's|^user_pref.*lightweightThemes.selectedThemeID.*|user_pref("lightweightThemes.selectedThemeID", "firefox-compact-light@mozilla.org");|' "$FIREFOX_PROFILE_PATH"/user.js
fi
# enabling using extensions
# otherwise the extension gallery thinks the brwoser has a lower version and some extensions won`t work
if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*privacy.resistFingerprinting.*") == "" ]]
then
	echo 'user_pref("privacy.resistFingerprinting", false);' >> "$FIREFOX_PROFILE_PATH"/user.js
else
	sed -i '' 's|^user_pref.*privacy.resistFingerprinting.*|user_pref("privacy.resistFingerprinting", false);|' "$FIREFOX_PROFILE_PATH"/user.js
fi
# enabling svg elements (with disabled a lot of gui elements break)
if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*svg.disabled.*") == "" ]]
then
	echo 'user_pref("svg.disabled", false);' >> "$FIREFOX_PROFILE_PATH"/user.js
else
	sed -i '' 's|^user_pref.*svg.disabled.*|user_pref("svg.disabled", false);|' "$FIREFOX_PROFILE_PATH"/user.js
fi

if [[ "$USER" == wolfgang ]]
then
	if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*browser.startup.page.*") == "" ]]
	then
		echo 'user_pref("browser.startup.page", 1);' >> "$FIREFOX_PROFILE_PATH"/user.js
	else
		sed -i '' 's|^user_pref.*browser.startup.page.*|user_pref("browser.startup.page", 1);|' "$FIREFOX_PROFILE_PATH"/user.js
	fi
	#
	if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*browser.privatebrowsing.autostart.*") == "" ]]
	then
		echo 'user_pref("browser.privatebrowsing.autostart", false);' >> "$FIREFOX_PROFILE_PATH"/user.js
	else
		sed -i '' 's|^user_pref.*browser.privatebrowsing.autostart.*|user_pref("browser.privatebrowsing.autostart", false);|' "$FIREFOX_PROFILE_PATH"/user.js
	fi
	#
	if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*signon.rememberSignons.*") == "" ]]
	then
		echo 'user_pref("signon.rememberSignons", true);' >> "$FIREFOX_PROFILE_PATH"/user.js
	else
		sed -i '' 's|^user_pref.*signon.rememberSignons.*|user_pref("signon.rememberSignons", true);|' "$FIREFOX_PROFILE_PATH"/user.js
	fi
	#
	if [[ $(cat "$FIREFOX_PROFILE_PATH"/user.js | grep "^user_pref.*intl.accept_languages.*") == "" ]]
	then
		echo 'user_pref("intl.accept_languages", "de-DE, de");' >> "$FIREFOX_PROFILE_PATH"/user.js
	else
		sed -i '' 's|^user_pref.*intl.accept_languages.*|user_pref("intl.accept_languages", "de-DE, de");|' "$FIREFOX_PROFILE_PATH"/user.js
	fi
else
	:
fi

echo ''
echo "done ;)"
