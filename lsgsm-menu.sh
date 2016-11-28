
#!/bin/bash


INPUT=/tmp/menu.sh.$$

# get text editor or fall back to vi_editor
editor=/usr/bin/nano

# trap and delete temp files
trap "rm $OUTPUT; rm $INPUT; exit" SIGHUP SIGINT SIGTERM


function install_preqs() {

	sudo curl -sL https://deb.nodesource.com/setup_4.x | bash - 
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get install -y git supervisor rdiff-backup screen build-essential oracle-java8-installer nodejs
}

#
# Install MineOS - Incomplete.
#

function install_mineos(){
dialog --msgbox "Incomplete."
}

#
# Backup minecraft servers belonging to the user running the script.
#

function backup_mc() {

echo "Backup"
}

#
# Start minecraft server belonging to the user running the script.
#

function start_mc() {
echo "start"
}

#
# Stop minecraft server belonging to the user running the script.
#

function stop_mc() {
echo "stop"
}
#
# Purpose. Background download of minecraft to be displayed in a tailbox.
#
function install_vmc() {
mkdir -v -p LSGSM/minecraft > lsgsm.log
wget -P LSGSM/minecraft/ https://s3.amazonaws.com/Minecraft.Download/versions/1.11/minecraft_server.1.11.jar 
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--msgbox "Game downloaded to ~/LSGSM/minecraft/" 0 0

single_menu
}

#
# Purpose.  Accept EULA for Minecraft
#
function accept_eula() {
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--yesno "By hitting the yes button you are accepting the EULA  (https://account.mojang.com/documents/minecraft_eula)." 7 60

sel=$?
case $sel in
	0) eula_info_accept;;
	2) eula_info_decline;;
esac

}

function eula_info_accept() {

echo "eula=true" > ~/LSGSM/minecraft/eula.txt

dialog --clear --backtitle "Linux Shell Game Server Manager" \
--msgbox "EULA Accepted!" 0 0
single_menu
}

function eula_info_decline() {
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--msgbox "EULA Declined! Nothing done." 0 0
single_menu

}

#
#Install LSGSM as default ssh screen when logging into remote console. 
#

function install_lsgsm() {
mkdir -p ~/LSGSM/scripts
#Included both possiblities of using bash.
echo "~/LSGSM/scripts/lsgsm-menu.sh" > ~/.bash_profile
echo "~/LSGSM/scripts/lsgsm-menu.sh" > ~/.bashrc
chmod +x LSGSM/scripts/lsgsm-menu.sh
cat lsgsm-menu.sh > ~/LSGSM/scripts/lsgsm-menu.sh
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--msgbox "Linux Shall Game Server Manager set as default ssh screen when logging in.\n You can now safely remove lsgsm-menu.sh, its new location is ~/LSGSM/scripts folder." 0 0

main_menu

}

#
# Purpose.  Main Menu.
#

function main_menu() {

dialog --clear --backtitle "Linux Shell Game Server Manager" \
--title "[ LSGSM ]" \
--menu "From this main menu installation of a multiuser \n\
minecraft hosting solution can be installed. \n\
A single user basic minecraft server can be installed. \n\
Please use the arrow keys to select an option." 20 70 6 \
Preqs "Install packages need to use this script" \
MineOS "Install multiuser and administration commands" \
Single "Single user and administration commands" \
Install "Install this script as default ssh screen" \
Exit "Exit to the shell" 2>"${INPUT}"
menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	Preqs) install_preqs;;
	MineOS) mineos_menu;;
	Single) single_menu;;
	Install) install_lsgsm;;
	Exit) echo "Bye"; break;;
esac


}


#
#Purpose. MineOS install and admin menu.
#
function mineos_menu() {
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--title "[ MineOS Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 20 70 6 \
"Install MineOS" "Auto Installs MineOS - Requires SUDO!!" \
Backup "Backup Minecraft Servers" \
Start "Start Minecraft Servers" \
Stop "Stop Minecraft Servers" \
Editor "Start a text editor" \
Return "Return to Main Menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	"Install MineOS") install_mineos;;
	Backup) backup_mc;;
	Start) start_mc;;
	Stop) stop_mc;;
	Editor) $editor;;
	Return) main_menu;;
esac


}

#
# Purpose. Single user setup and admin menu.
#
function single_menu() {
dialog --clear --backtitle "Linux Shell Game Server Manager" \
--title "[ Single User Menu ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 20 70 6 \
Install "Installs a single instance of vanilla mc to user directory" \
EULA "Accept the EULA required by Minecraft" \
Return "Return to Main Menu" 2>"${INPUT}"

menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	Install) install_vmc;;
	EULA) accept_eula;;
	Return) main_menu;;
esac


}

#
# set infinite loop
#
while true
do
### display main menu ###
main_menu
done
# if temp files found, delete em
[ -f $OUTPUT ] && rm $OUTPUT
[ -f $INPUT ] && rm $INPUT

