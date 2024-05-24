#!/bin/bash
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get auto-remove -y

sudo apt-get install terminator -y
sudo apt-get install noterpadqq -y
sudo apt-get instll gobuster -y

sudo mkdir -p /home/kali/.ovpnconfig
sudo mkdir -p /home/kali/tools

cd /home/kali/tools
sudo git clone https://github.com/danielmiessler/SecLists


sudo wget https://github.com/ROYJohan08/RJI-HackTools/raw/main/.zshrc
sudo rm -rf /home/kali/.zshrc
sudo mv .zshrc /home/kali/
sudo source /home/kali/.zshrc

sudo wget https://github.com/ROYJohan08/DomotikHomeNas/raw/main/Install.sh | bash
