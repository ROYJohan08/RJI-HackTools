Start by install [Kali-linux on virtualbox](https://www.kali.org/get-kali/#kali-virtual-machines)
Once the machine strted, run `sudo apt-get update -y` and `sudo apt-get full-upgrade -y`

# X.x. Install the VPN shortcut.
Start by create the VPN profile directory.
`mkdir -p ~/.ovpnconfig`
Insert your ".ovpn" files in there.
inster in ".zshrc" : 
`
# HTB Aliases
alias htbmachine='openvpn ~/.ovpnconfig/HTB-Machine.ovpn 1>/dev/null &'
alias htbstart='openvpn ~/.ovpnconfig/HTB-Start.ovpn 1>/dev/null &'
alias htbacademy='openvpn ~/.ovpnconfig/HTB-Academy.ovpn 1>/dev/null &'
alias sudo='sudo '
`
