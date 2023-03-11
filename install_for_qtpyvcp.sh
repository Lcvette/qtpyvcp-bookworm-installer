#!/bin/bash

export PATH=$HOME/.local/bin:$PATH
export SUDO_ASKPASS=`pwd`/sudo_helper.sh
USERNAME=$(whoami)

echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m   _______   _________   _______   ______    ____    ____  ____  ____  ____    \e[0m"
echo -e "\e[1;34m   |  __  \  |   ___/    \___  |  /  __  \   |   \  /   |  |__|  |  |  |  |    \e[0m"
echo -e "\e[1;34m   |  |_\ /  |   |__      ___| |  | /  \ |   |    \/    |  ____  |  |  |  |    \e[0m"
echo -e "\e[1;34m   |  ___ \  |   __/     /  ___/  | |  | |   |  |\  /|  |  |  |  |  |  |  |    \e[0m"
echo -e "\e[1;34m   |  |__\ | |  |       |  /___   | \__/ |   |  | \/ |  |  |  |  |  |  |  |    \e[0m"
echo -e "\e[1;34m   |_______/ |__|       |______|  \______/   |__|    |__|  |__|  |__|  |__|    \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"
echo -e "\e[1;34m          https://github.com/joco-nz/bf20_mill      By @Joco 2023              \e[0m"
echo -e "\e[1;34m                                                                               \e[0m"


echo -e "\e[1;34mDebian Bookworm dependencies Install started\e[0m"

# Install deps line from the offical QTpyvcp doc site.  There is overlap with the above line.  But that doesn't matter and it is simpler to just add the
# required line in totallaty than to try and get cute and edit out duplicates.  Apt solves all that for us.

sudo -A apt install -y python3-venv python3-pyqt5 python3-dbus.mainloop.pyqt5 python3-pyqt5.qtopengl python3-pyqt5.qsci python3-pyqt5.qtmultimedia python3-pyqt5.qtquick qml-module-qtquick-controls gstreamer1.0-plugins-bad libqt5multimedia5-plugins pyqt5-dev-tools python3-dev python3-setuptools python3-wheel python3-pip python3-six python3-docopt python3-qtpy python3-pyudev python3-psutil python3-markupsafe python3-opengl python3-vtk9 python3-pyqtgraph python3-simpleeval python3-jinja2 python3-deepdiff python3-sqlalchemy python3-distro git qttools5-dev-tools
SUDO_ERROR=$?

if [ $SUDO_ERROR -eq 1 ]
then
	exit 1
fi

# Ask the user if they want to install qtpyvcp or qtpyvcp and bf20_mill
zenity --question --text="Install qtpyvcp or qtpyvcp and BF20 Mill" --no-wrap --ok-label="QTPYVCP" --cancel-label="BOTH"

BOTH=$?
# BOTH = 1 for BOTH install
# QTPYVCP = 0 for USER install

if [ $BOTH -eq 1 ]
then
	echo -e "\e[1;34mQtPyVCP and BF20 Mill install started\e[0m"

	# get qtpyvcp
	# create dev directory just in case the user missed this step
	mkdir -p ~/dev
	cd ~/dev

	git clone https://github.com/kcjengr/qtpyvcp.git
	git clone https://github.com/Lcvette/bf20_mill.git -b main

	python3 -m venv --system-site-packages venv
	source venv/bin/activate

	pip install hiyapyco

	cd qtpyvcp
	pip install -e .

	qcompile .
	cp scripts/.xsessionrc ~/

	# copy the qtpyvcp sims into place. People can delete them later if they want
	cp -r ~/dev/qtpyvcp/linuxcnc ~/

	cd ../bf20_mill

	pip install -e .
	qcompile .

	cp -r ~/dev/bf20_mill/config/bf20_mill/ ~/linuxcnc/configs/

	# check freedesktop variables for user paths
	test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs

	# copy launchers in place
	cp /home/$USERNAME/dev/bf20_mill/dev_launchers/BF20\ Mill.desktop  ${XDG_DESKTOP_DIR:-$HOME/Desktop}/BF20\ Mill.desktop
	cp /home/$USERNAME/dev/bf20_mill/dev_launchers/Designer\ for\ BF20\ Mill.desktop  ${XDG_DESKTOP_DIR:-$HOME/Desktop}/Designer\ for\ BF20\ Mill.desktop


	# replace "username" with real username in desktop launchers
	sed -i "s/username/$USERNAME/g" ${XDG_DESKTOP_DIR:-$HOME/Desktop}/Designer\ for\ BF20\ Mill.desktop
	sed -i "s/username/$USERNAME/g" ${XDG_DESKTOP_DIR:-$HOME/Desktop}/BF20\ Mill.desktop


	# ensure icons and fonts paths exist
	mkdir -p /home/$USERNAME/.local/share/icons/
	mkdir -p /home/$USERNAME/.local/share/fonts/

	# copy icons
	cp /home/$USERNAME/dev/bf20_mill/dev_launchers/bf20_mill_icon.png /home/$USERNAME/.local/share/icons/bf20_mill_icon.png
	cp /home/$USERNAME/dev/bf20_mill/dev_launchers/qtpyvcp_icon.png /home/$USERNAME/.local/share/icons/qtpyvcp_icon.png

	# copy fonts
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/3270-Regular.ttf /home/$USERNAME/.local/share/fonts/3270-Regular.ttf
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/BebasKai.ttf /home/$USERNAME/.local/share/fonts/BebasKai.ttf
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/Hack-Regular.ttf /home/$USERNAME/.local/share/fonts/Hack-Regular.ttf
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/SourceCodePro-Medium.ttf /home/$USERNAME/.local/share/fonts/SourceCodePro-Medium.ttf 
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/SourceCodePro-Regular.ttf /home/$USERNAME/.local/share/fonts/SourceCodePro-Regular.ttf
	cp /home/$USERNAME/dev/bf20_mill/bf20_mill/fonts/Anonymous\ Pro.ttf /home/$USERNAME/.local/share/fonts/Anonymous\ Pro.ttf

else
	echo -e "\e[1;34mQtPyVCP install started\e[0m"
	# create dev directory just in case the user missed this step
	mkdir -p ~/dev
	cd ~/dev
	git clone https://github.com/kcjengr/qtpyvcp.git

	python3 -m venv --system-site-packages venv
	source venv/bin/activate

	pip install hiyapyco

	cd qtpyvcp

	pip install -e .
	qcompile .

	cp scripts/.xsessionrc ~/

fi

# Create a zenity dialog box to ask the user if they want to reboot
if zenity --question --text="Do you want to reboot the system?"; then
    # If the user clicked "Yes", reboot the system
    xfce4-session-logout --reboot
else
    # If the user clicked "No" or closed the dialog box, exit the script
    exit 0
fi
