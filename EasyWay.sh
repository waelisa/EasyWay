#!/bin/bash
##################################################################
#
# GNU GENERAL PUBLIC LICENSE
# Version 2, June 1991
# Copyright (C) 1989, 1991 Free Software Foundation, Inc., <http://fsf.org/>
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
# Everyone is permitted to copy and distribute verbatim copies
# of this license document, but changing it is not allowed.
#
# Script made by Wael Isa
# https://github.com/waelisa/EasyWay
# https://www.wael.name/
# Version: 1
# Release Date: 18 / 2 / 2020
#
##################################################################
source "EasyWay.conf"
function RConf () {
		CONF=EasyWay.conf
		if [ -f "$CONF" ] && [ ! "$CONF" == "" ]; then
		runQuestions
		else
		wget --no-check-certificate -O https://github.com/waelisa/EasyWay/raw/master/EasyWay.conf
		echo "EasyWay.conf downloaded."
		source "$CONF" ; runQuestions
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
		echo "OS testing"
		if [ -e /etc/manjaro-release ]; then
		echo "Manjaro OS" ; RConf
		else
		clear
		echo ""
		echo "Linux system not support"
		echo "contact me if you want add your system"
		exit 1
		if [ -e /etc/solus-release ]; then
		echo "Solus OS" ; RConf

		else
		clear
		echo ""
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
		echo "   2) Manjaro Lutris Driver"
		echo "   3) Install Rsync (Needed for backup and restore)"	
		echo "   4) Backup home folder"
		echo "   5) Restore home folder"
		echo "   6) Exit"
		until [[ "$MENU_OPTION" =~ ^[1-6]$ ]]; do
		read -rp "Select an option [1-6]: " MENU_OPTION
		done

		case $MENU_OPTION in
		1)
		RFresh
		;;
		2)
		runDriverTEST
		;;
		3)
		RRsync
		;;
		4)
		RBackup
		;;
		5)
		RRestore
		;;
		6)
		echo "Exit"
		exit 0
		;;
		esac
}
function runDriverTEST () {
		echo "OS testing"
		if [ -e /etc/manjaro-release ]; then
		echo "Manjaro OS" ; runDriver
		fi
		clear
		echo ""
		echo "Linux system not support (Manjaro only)"
		exit 1
}
function runDriverAMD () {
		sudo pacman -S $MANJAROAMD ; runQuestions
}
function runDriverINTEL () {
		sudo pacman -S $MANJAROINTEL ; runQuestions
}
function runDriverNVIDIA () {
		sudo pacman -S $MANJARONVIDIA ; runQuestions
}
function runDriver () {
		clear
		echo "Manjaro Lutris ONLY"
		echo "What do you want to install?"
		echo "   1) AMD"
		echo "   2) Intel"	
		echo "   3) Nvidia"
		echo "   4) Exit"
		until [[ "$MENU_OPTION2" =~ ^[1-4]$ ]]; do
		read -rp "Select an option [1-4]: " MENU_OPTION2
		done

		case $MENU_OPTION2 in
		1)
		runDriverAMD
		;;
		2)
		runDriverINTEL
		;;
		3)
		runDriverNVIDIA
		;;
		4)

		echo "Exit"
		exit 0
		;;
		esac
}
# Runtime
ROS
##################################################################
