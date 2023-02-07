## General installation approach

**This is a modified version of Joco's installer script.  I modified to be used on a clean install of debian 12 bookworm (typically I use the xfce nonfree iso) download and install the bookworm iso and run all of your updating.**

**1. Install linuxcnc from terminal using apt:**


`sudo apt install linuxcnc-uspace linuxcnc-uspace-dev mesaflash`


**2. Next restart your computer**


**3. Ensure git is installed:**


`sudo apt install git`


**4. Create a directory and clone the repo to it.  Either clone or download a zip file.**


`cd ~`

`mkdir dev`

`cd dev`

`git clone https://github.com/Lcvette/qtpyvcp-bookworm-installer.git`

`cd qtpyvcp-installer`

`./install_for_qtpyvcp.sh`


**To Update QtPyVCP and Probe Basic from terminal in the installer directory file, run the following script command:**

`./updater.sh`

## For noting: Files that must be executable

install_for_qtpyvcp.sh

sudo_helper.sh

updater.sh

