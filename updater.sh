#!/bin/bash

# get qtpyvcp
echo "Updating Qtpyvcp"
cd ~/dev/qtpyvcp
git pull
qcompile .

# determine if PB is installed and if is installed, update
if [ -d ~/dev/probe_basic ]
then
	echo "Updating Probe Basic"
	cd ~/dev/probe_basic
	git pull
	qcompile .
fi
