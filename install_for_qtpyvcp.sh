#!/bin/bash

echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m               ___  ____ ____ ___  ____    ___  ____ ____ _ ____               \e[0m"
echo -e "\e[1;34m               |__] |__/ |  | |__] |___    |__] |__| [__  | |                  \e[0m"
echo -e "\e[1;34m               |    |  \ |__| |__] |___    |__] |  | ___] | |___               \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m                        _ _  _ ____ ___ ____ _    _                            \e[0m"
echo -e "\e[1;34m                        | |\ | [__   |  |__| |    |                            \e[0m"
echo -e "\e[1;34m                        | | \| ___]  |  |  | |___ |___                         \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m        https://github.com/kcjengr/probe_basic   By @Lcvette  2023             \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"


export SUDO_ASKPASS=`pwd`/sudo_helper.sh

which zenity &>/dev/null
if [ $? -gt 0 ]
then
   sudo -A apt install -y zenity
fi
echo -e "\e[1;34mDebian Bookworm dependencies Install started\e[0m"

# Install deps line from the offical QTpyvcp doc site.  There is overlap with the above line.  But that doesn't matter and it is simpler to just add the
# required line in totallaty than to try and get cute and edit out duplicates.  Apt solves all that for us.
sudo -A apt install -y python3-pyqt5 python3-dbus.mainloop.pyqt5 python3-pyqt5.qtopengl python3-pyqt5.qsci python3-pyqt5.qtmultimedia \
python3-pyqt5.qtquick qml-module-qtquick-controls gstreamer1.0-plugins-bad libqt5multimedia5-plugins pyqt5-dev-tools python3-dev \
python3-setuptools python3-wheel python3-pip python3-six python3-docopt python3-qtpy python3-pyudev python3-psutil python3-markupsafe \
python3-opengl python3-vtk9 python3-pyqtgraph python3-simpleeval python3-jinja2 python3-deepdiff python3-sqlalchemy python3-distro git

zenity --notification \
	--window-icon="info" \
	--text="If none of the following makes sense then the User is advised to take the RED pill."


# Ask the user if they want to install a developer version of qtpyvcp
zenity --question --text="Is this a USER or DEVELOPER install?" --no-wrap --ok-label="USER" --cancel-label="DEVELOPER"
DEVELOPER=$?
# Developer = 1 for DEVELOPER install
# Developer = 0 for USER install

if [ $DEVELOPER -eq 1 ]
then

	echo -e "\e[1;34mDeveloper QtPyVCP install started\e[0m"

	# get qtpyvcp
	# create dev directory just in case the user missed this step
	mkdir -p ~/dev
	cd ~/dev
	git clone https://github.com/kcjengr/qtpyvcp.git -b master
	cd qtpyvcp
	python3 -m pip install --editable .
	cp scripts/.xsessionrc ~/
	
	# Install Qt desirner:
	sudo -A apt install -y qttools5-dev-tools

	# install the QTDesigner plugins just in case someone needs to use it
	cd ~/dev/qtpyvcp/pyqt5designer/Qt5.15.4-64bit/python3.10/
	sudo -A ./install.sh

	# copy the qtpyvcp sims into place. People can delete them later if they want
	cp -r ~/dev/qtpyvcp/linuxcnc ~/
	export PATH=$HOME/.local/bin:$PATH
else
	echo -e "\e[1;34mUser QtPyVCP install started\e[0m"
	cd qtpyvcp/
	python3 -m pip install .
fi

# Install probe basic
zenity --question --text="Install ProbeBasic user interface.\n\nINSTALL Yes or No?" --no-wrap --ok-label="yes" --cancel-label="no"
CHOICE=$?

if [ $CHOICE -eq 0 ]
then
	if [ $DEVELOPER -eq 0 ]
	then
		# user install
		echo -e "\e[1;34mUser ProbeBasic install started\e[0m"
	else
		# developer install
		echo -e "\e[1;34mDeveloper ProbeBasic install started\e[0m"
		cd ~/dev
		git clone https://github.com/kcjengr/probe_basic.git -b python3  # clone python3 branch directly 
		git clone https://github.com/kcjengr/qtpyvcp.conversational-gcode.git -b python3  # clone python3 branch directly 
		
		cd ~/dev/probe_basic

		qcompile .
		python3 -m pip install --no-deps -e .
		cp -r ~/dev/probe_basic/config/probe_basic/ ~/linuxcnc/configs/
		
		cd ~/dev/qtpyvcp.conversational-gcode

		python3 -m pip install -e .
	fi
fi


zenity --info \
	--title="Installation Finished" \
	--text="The system will now log you out.\nPlease log back in and perform any tests you feel necessary\nto check the install." \
	--no-wrap
xfce4-session-logout --logout
