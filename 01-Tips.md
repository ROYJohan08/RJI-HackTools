# Tips

Add dommain to ip : 
```
sudo tee --append /etc/hosts <<< "{ip} {host}"
```
Path of user list : 
```
/etc/passwd
```
Command for user allowed sudo : 
```
sudo -l
```
Command for read databases : 
```
sqlite3 user.db
```
Extract hash from .kdbx
```
keepass2john /home/$USER/dataset.kdbx > hash.txt
```
Crack hash with JohnSoReaper : 
```
john hash.txt
```
