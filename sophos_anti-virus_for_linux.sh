#!/usr/bin/env sh
{
    echo "SAV Free for Linux is dead for 4 months by now (2020-11-07). Those Micro\$oft capitalist fanboys killed another product that had **some** use for Linux so that they can get more money to give M\$. All other free Linux antiviruses that I've found are worthless. Don't even get me started on ClamAV."
    echo 'If you wanna use this script you need to remove this notice from the script.'
    echo "It was fun while it lasted. I were writing more code when I found out the software's dead."
    echo 'See you in Hell, Sophos. --rautamiekka, 2020-11-07'
    return
}

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
