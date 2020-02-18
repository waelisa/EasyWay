#!/bin/bash
##################################################################
#
# GNU GENERAL PUBLIC LICENSE
# Version 2, June 1991
# Copyright (C) 2006,2007 Free Software Foundation, Inc.
# 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#
# Script made by Wael Isa
# # https://www.wael.name/
# Version: 1
# Release Date: 16 / 2 / 2020
#
##################################################################
function RConf () {
		CONF=$FolderBackup.conf
		if [ -f "$CONF" ] && [ ! "$CONF" == "" ]; then
		source $CONF
		else
		#wget --no-check-certificate -O https:// **** /FolderBackup.conf
		echo "\FolderBackup.conf downloaded."
		source $CONF
fi
}
function RRsync () {
		echo "Install Rsync"
		if [ -e /etc/manjaro-release ]; then
		sudo pacman -Syu rsync
		if [ -e /etc/solus-release ]; then
		sudo eopkg install rsync
		fi
		fi
}
function RFresh () {
		echo "Install APP"
		if [ -e /etc/manjaro-release ]; then
		sudo pacman-mirrors --fasttrack
		sudo pacman -Syyu
		sudo pacman -Syu $MANJAROAPP
		if [ -e /etc/solus-release ]; then
		sudo eopkg upgrade
		sudo eopkg install $SOLUSAPP
		fi
		fi
}
function ROS () {
		echo "OS test"
		if [ -e /etc/manjaro-release ]; then
		echo "Manjaro OS" ; runQuestions
		if [ -e /etc/solus-release ]; then
		echo "Solus OS" ; runQuestions
		else
		echo "Linux system not support"
		echo "contact me if you want add your system"
		exit 1
		fi
		fi
}
function RBackup () {
		echo "Backup"
		rsync -a --delete --progress -e ssh $USERFOLDER $BACKUPFOLDER
}
function RRestore () {
		echo "Restore"
		rsync -a --delete --progress -e ssh $BACKUPFOLDER $USERFOLDER
}
function runQuestions () {
		clear
		echo ""
		echo "What do you want?"
		echo "   1) Install gaming app(Steam, Lutris, Vulkan,,, etc)"
		echo "   2) Install Rsync (Needed for backup and restore)"	
		echo "   3) Backup home folder"
		echo "   4) Restore home folder"
		echo "   5) Exit"
		until [[ "$MENU_OPTION" =~ ^[1-5]$ ]]; do
		read -rp "Select an option [1-5]: " MENU_OPTION
		done

		case $MENU_OPTION in
		1)
		RFresh
		;;
		2)
		RRsync
		;;
		3)
		RBackup
		;;
		4)
		RRestore
		;;
		5)
		echo "Exit"
		exit 0
		;;
		esac
}
# Runtime
ROS
RConf
##################################################################

