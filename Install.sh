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

git clone https://github.com/megadose/holehe.git
cd holehe/
python3 setup.py install
cd ../

git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
python3 -m pip install -r requirements.txt
cd ../

sudo wget https://github.com/ROYJohan08/RJI-HackTools/raw/main/.zshrc
sudo rm -rf /home/kali/.zshrc
sudo mv .zshrc /home/kali/
sudo source /home/kali/.zshrc

sudo wget https://github.com/ROYJohan08/RJI-HackTools/raw/main/RYOHajon-Machine.ovpn
sudo mv RYOHajon-Machine.ovpn /home/kali/.ovpnconfig/Machine.ovpn

setxkbmap fr
