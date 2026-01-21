# Enumeration
Osint data from dommain name : [spiderfoot](Tools.md#spiderfoot) `python3 sf.py -l 127.0.0.1:80`

Used port list and infos : [Nmap](Tools.md#nmap) `nmap -A -oN initial_scan SERVER_IP`

Used port list and infos complete : [Nmap](Tools.md#nmap)  `nmap -SV SERVER_IP`

Directory Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ`

Extension Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://SERVER_IP:PORT/indexFUZZ`

Page Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/blog/FUZZ.php`

Recursive Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ -recursion -recursion-depth 1 -e .php -v`

Sub-domain Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u https://FUZZ.hackthebox.eu/`

VHost Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx`

Parameter Fuzzing - GET :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx`

Parameter Fuzzing - POST :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`

Value Fuzzing :`ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx`

