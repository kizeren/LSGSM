# LSGSM
Linux Shell Game Server Manger.


The aim of this project is to further help those with a VPS/Dedicated server in setting up a quick and easy minecraft server.



## Quick and easy install.

`git clone https://github.com/kizeren/LSGSMscript.git`

`cd ~/LSGSMscript/`

Then run the command.

`./lsgsm-menu.sh`

From this menu there is a choice to install the script as default prompt when logging in to the server.



At this time the MineOS feature is broken with plans to finish soon.
Single server install has been tested and working with plans on setting up and configuring.
As of now the server starts with 1GB ram and is 100% pure vanilla.

There is a chance this script will fail!  If the script hangs at a empty prompt, please do

`sudo apt-get install dialog`

which is a needed application from ubuntu repository.

## TODO
Finish MineOS installation.
Setup menus for server.properties and ram configuration of single user server.
Intergrate steam into menus for other game servers.
