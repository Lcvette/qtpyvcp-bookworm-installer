## General installation approach

**This is a modified version of Joco's installer script.  I modified to be used on a clean install of debian 12 bookworm (typically I use the xfce nonfree iso) download and install the bookworm iso.**  

**IMPORTANT!!!  During Linux Bookworm installation, DO NOT set a root password when prompted, just press continue to move to the next section in the visual installer.  Once installed, run all of your updating.**



**1. Install linuxcnc from terminal using apt:**

`sudo apt install linuxcnc-uspace linuxcnc-uspace-dev mesaflash`



**2. Next restart your computer**



**3. Ensure git is installed:**

`sudo apt install git`


**4. Ensure zenity is installed:**

`sudo apt install zenity`


**5. Create a directory and clone the repo to it.  Either clone or download a zip file.**

`cd ~`

`mkdir dev`

`cd dev`

`git clone https://github.com/Lcvette/qtpyvcp-bookworm-installer.git`

`cd qtpyvcp-bookworm-installer`

`./install_for_qtpyvcp.sh`



**To Update QtPyVCP and Probe Basic, from terminal in the installer directory file, run the following script command:**

`./updater.sh`



**To Uninstall QtPyVCP and Probe Basic, from a terminal run the lines below, once completed, delete the /dev folder:**

`#!/bin/bash`

`pip uninstall -y probe_basic qtpyvcp qtpyvcp.conversational-gcode`



# For noting: Files that must be executable

install_for_qtpyvcp.sh

sudo_helper.sh

updater.sh
