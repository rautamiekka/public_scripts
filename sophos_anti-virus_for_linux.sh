#!/usr/bin/env sh
##Tested 2019-12-09 on Xubuntu 18.04.3 LTS x64, this script prepares the system for the full installation of Sophos Anti-Virus for Linux.
##The way the installation is made, some of the installation options will need to be given during the main installer.

##START This needs to be kept up-to-date.
SAVIFILE=sav-linux-free-9.tgz
##END

[ -f ./${SAVIFILE} ] && {
    tar -xvf ./${SAVIFILE} || return
    cd sophos-av || return
}

##If the required files aren't present, quit.
[ ! -f ./install.sh ] && { echo "The SAV installation files weren't found."; exit 1; }
[ ! -f ./sav.tar ] && { echo "The SAV installation files weren't found."; exit 1; }
[ ! -f ./talpa.tar ] && { echo "The SAV installation files weren't found."; exit 1; }
[ ! -f ./uncdownload.tar ] && { echo "The SAV installation files weren't found."; exit 1; }
[ ! -f "/boot/System.map-$(uname -r)" ] && { echo "The 'System.map' file for the current kernel $(uname -r) wasn't found."; exit 1; }

##Ubuntu/Debian: install the necessary packages for Talpa (Sophos realtime scanner kernel module) compilation.
sudo apt install gcc make linux-headers-generic libelf-dev

sudo ./install.sh /opt/sophos-av/ --acceptlicence --autostart=True --enableOnBoot=True --live-protection=True --preferFanotify=False
