# Enumeration
Osint data from dommain name : [spiderfoot](Tools.md#spiderfoot) 
```
python3 sf.py -l 127.0.0.1:80
```
Open port list (short) : [Nmap](Tools.md#nmap) 
```
# -A : OS detection.
nmap -A {TARGET_IP}
```
Open port list (long) : [Nmap](Tools.md#nmap)  
```
# -sV : Version detection
# -sT : TCP
# -sU : UDP
# -sF : FIN scan
# -O : OS detection, same as -A
# -T3 : Test speed, over T3 it can submerge target |Use T0 for bypass IDS servers
nmap -sV -sT -sU -sF -O {TARGET_IP} -T3
```
Web directory BruteForce : [Dirb](Tools.md#dirb) 
```
dirb http://SERVER_IP:PORT/
```
Web directory BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ
```
Web extension BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/web-extensions.txt:FUZZ -u http://SERVER_IP:PORT/indexFUZZ
```
Web page BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/directory-list-2.3-small.txt:FUZZ -u http://SERVER_IP:PORT/blog/FUZZ.php
```
Web sub-domain BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/DNS/subdomains-top1million-5000.txt:FUZZ -u https://FUZZ.hackthebox.eu/
```
Web get arameter BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php?FUZZ=key -fs xxx
```
Web post parameter BruteForce  : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/burp-parameter-names.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```
Web value BruteForce : [ffuf](Tools.md#ffuf) 
```
ffuf -w /home/kali/Tools/SecLists/Discovery/Web-Content/ids.txt:FUZZ -u http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=FUZZ' -H 'Content-Type: application/x-www-form-urlencoded' -fs xxx
```

