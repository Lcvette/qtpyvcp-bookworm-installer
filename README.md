## General installation approach

**This installer script will install QtPyVCP and Probe Basic into a virtual environment (venv) which is now a requirement for pip installations on systems running python version 3.11 which is what comes on Linux Debian 12 Bookworm.  This has been tested to work on a clean install of debian 12 bookworm using the xfce4 option and nonfree firmware cdnetinst iso. As of this read-me document update, the alpha2 image, download and install the bookworm iso from the link below for your pc type, typically the amd64 on normal pc's:** 

https://www.debian.org/devel/debian-installer/


**IMPORTANT!!!  During Linux Bookworm installation, DO NOT set a root password when prompted, just press continue to move to the next section in the visual installer.  Once installed, run all of your updating.**



**1. Download adnd Install linuxcnc from current lockdown deb file:**

https://www.linuxcnc.org/dists/bookworm/2.9-uspace/binary-amd64/linuxcnc-uspace_2.9.3_amd64.deb

`cd ~`

`cd Downloads`

`sudo dpkg -i linuxcnc-uspace_2.9.3_amd64.deb`


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

Delete can be accomplished by deleting the dev folder. because this is a venv run in place install it is removed once the directory is deleted.


**For noting: Files that must be executable:**

install_for_qtpyvcp.sh

sudo_helper.sh

updater.sh
