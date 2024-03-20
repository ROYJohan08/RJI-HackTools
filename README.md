# 1. Introduction.

# 2.1. Installation de la machine.
- Installez un systeme de gestion de machine virtuelle comme [Virtulbox](https://www.virtualbox.org/wiki/Downloads).
- Installez la machine virtuelle [Kali-linux](https://www.kali.org/get-kali/#kali-virtual-machines).
- Une fois la machine démarré, lancez les commandes : `sudo apt-get update -y` and `sudo apt-get full-upgrade -y`.

# 2.2. Installation des VPN HackTheBox

- Creez le fichier de configuration des VPN avec la commande : `mkdir -p /home/kali/.ovpnconfig`
- Déplacez-vous dans le fichier via : `cd /home/kali/.ovpnconfig/`
- Inserez vos configurations ".ovpn".
- Modifiez `.zshrc` avec la commande : `notepadqq /home/kali/.zshrc`.
- Ajoutez les lignes : 
```
# HTB VPN Shortcuts:
alias htbmachine='openvpn ~/.ovpnconfig/HTB-Machine.ovpn 1>/dev/null &'
alias htbstart='openvpn ~/.ovpnconfig/HTB-Start.ovpn 1>/dev/null &'
alias htbacademy='openvpn ~/.ovpnconfig/HTB-Academy.ovpn 1>/dev/null &'
alias sudo='sudo '
```

# 2.3. Instllation des outils
- Créez le dossier Outils : `mkdir /home/kali/Tools`
- Rendez-vous dans ce dossier : `cd Tools`
- Installez seclist : `git clone https://github.com/danielmiessler/SecLists`
- Installez gobuster : `sudo apt-get instll gobuster`


## Using Ffuf.
Search directorys : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ`
Search subdomains : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u https://FUZZ.hackthebox.eu/`
Search vhost : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx`



Directory Fuzzing : `ffuf -w Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ	`
Extension Fuzzing : `ffuf -w Tools/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://SERVER_IP:PORT/indexFUZZ`
Page Fuzzing : `ffuf -w Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/blog/FUZZ.php`
Recursive Fuzzing : `ffuf -w Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ -recursion -recursion-depth 1 -e .php -v`
Sub-domain Fuzzing : `ffuf -w Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u https://FUZZ.hackthebox.eu/`
VHost Fuzzing : `ffuf -w Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx`
Parameter Fuzzing - GET : `ffuf -w Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx`
Parameter Fuzzing - POST : `ffuf -w Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`
Value Fuzzing : `ffuf -w Tools/SecLists/Discovery/Web-Content/ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`
Wordlists
Command	Description
Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt	Directory/Page Wordlist
Tools/SecLists/Discovery/Web-Content/web-extensions.txt	Extensions Wordlist
Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt	Domain Wordlist
Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt	Parameters Wordlist
Misc
Command	Description
sudo sh -c 'echo "SERVER_IP academy.htb" >> /etc/hosts'	Add DNS entry
for i in $(seq 1 1000); do echo $i >> ids.txt; done	Create Sequence Wordlist
curl http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=key' -H 'Content-Type: application/x-www-form-urlencoded'	curl w/ P
