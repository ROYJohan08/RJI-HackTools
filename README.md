- Start by install [Kali-linux on virtualbox](https://www.kali.org/get-kali/#kali-virtual-machines).
- Once the machine strted, run `sudo apt-get update -y` and `sudo apt-get full-upgrade -y`

# X.x. Install the VPN shortcut.

- Start by create the VPN profile directory : `mkdir -p ~/.ovpnconfig`
- Insert your ".ovpn" files in there.
- Insert in ".zshrc" :
```
# HTB VPN Shortcuts:
alias htbmachine='openvpn ~/.ovpnconfig/HTB-Machine.ovpn 1>/dev/null &'
alias htbstart='openvpn ~/.ovpnconfig/HTB-Start.ovpn 1>/dev/null &'
alias htbacademy='openvpn ~/.ovpnconfig/HTB-Academy.ovpn 1>/dev/null &'
alias sudo='sudo '
```

# X.x. Install Tools
- Create Tools Folder : `mkdir Tools`
- Move in Tools folder: `cd Tools`
- Install seclist : `git clone https://github.com/danielmiessler/SecLists`
- Install gobuster : `sudo apt-get instll gobuster`


## Using Ffuf.
Search directorys : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u http://SERVER_IP:PORT/FUZZ`
Search subdomains : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u https://FUZZ.hackthebox.eu/`
Search vhost : `ffuf -w Tools/Discovery/Web-Content/common.txt:FUZZ -u http://academy.htb:PORT/ -H 'Host: FUZZ.academy.htb' -fs xxx`
