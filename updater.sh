#!/bin/bash

export SUDO_ASKPASS=`pwd`/sudo_helper.sh

# Ask the user if they want to install a developer version of qtpyvcp
zenity --question --text="Is this a USER or DEVELOPER install?" --no-wrap --ok-label="USER" --cancel-label="DEVELOPER"
DEVELOPER=$?
# Developer = 1 for DEVELOPER install
# Developer = 0 for USER install

if [ $DEVELOPER -eq 1 ]
then
	# get qtpyvcp
	echo "Updating Qtpyvcp"
	cd ~/dev/qtpyvcp
	git pull

	# determine if PB is installed and if is installed, update
	if [ -d ~/dev/probe_basic ]
	then
		echo "Updating Probe Basic and Conversational"
		cd ~/dev/probe_basic
		git pull
		qcompile .
		
		cd ~/dev/qtpyvcp.conversational-gcode
		git pull
	fi
fi
