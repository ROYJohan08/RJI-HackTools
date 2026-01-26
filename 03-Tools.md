# Sommaire
1. [Holehe](#holehe)
2. [SpiderFoot](#spiderfoot)
3. [Nmap](#nmap)
# OSINT
## Holehe
Holehe permet de rechercher les comptes crée avec un email donné.
### Installation
```
git clone https://github.com/megadose/holehe.git
cd holehe/
python3 setup.py install
```
### Usage
```
holehe test@gmail.com
```
### Reponse
## SpiderFoot
SpiderFoot est un outil d'automatisation de renseignement d'origine source ouverte (OSINT).
### Installation
```
git clone https://github.com/smicallef/spiderfoot.git
cd spiderfoot
python3 -m pip install -r requirements.txt
```
### Usage
```
python3 sf.py -l 127.0.0.1:80
```
### Réponse
## Nmap
Nmap permet de voir les ports ouverts sur une machine distante
### Installation
```
sudo apt-get install nmap
```
### Usage
```
nmap -A -oN initial_scan SERVER_IP
nmap -SV SERVER_IP
```
### Reponse
