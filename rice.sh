#!/bin/sh
set -e

if [ "$EUID" -ne 0 ]
  then printf "The script has to be run as root.\n"
  exit
fi

cd ..
userhome=$(pwd)

pkg install -y dbus xorg-server xorg-minimal xrdb setxkbmap xinit libxinerama libxft feh unclutter unzip xauth font-awesome hack-font ncurses pkgconf sndio
echo 'dbus_enable="YES"' >> /etc/rc.conf
service dbus start
printf "installed dependencies\n"

mkdir /usr/local/etc/rice
mv $userhome/bsdrice/rice.zip /usr/local/etc/rice
mv $userhome/bsdrice/dots.zip /$userhome
printf "moved zips\n"


cd /$userhome
unzip dots.zip
cd /usr/local/etc/rice
unzip rice.zip
printf "unzipped\n"

cd /usr/local/etc/rice/dwm
make clean install
printf "installed dwm\n"
cd /usr/local/etc/rice/dmenu
make clean install
printf "installed dmenu\n"
cd /usr/local/etc/rice/slstatus
make clean install
printf "installed slstatus\n"
cd /usr/local/etc/rice/st
make clean install
printf "installed st\n"


printf "Install finished.\n"