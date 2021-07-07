# mariadb # 

## install portable mariadb on win ##

### download zip ###
https://downloads.mariadb.org/mariadb/10.5.10/

-> windows 64 zip file 

and unpack it somewhere, e.g.: 
```cmd 
d:\db\mariadb
```
## creating datafolder, installing db and starting daemon 
```cmd 
d:\db\mariadb> cd d:\db\mariadb 
d:\db\mariadb> mkdir data
d:\db\mariadb> cd bin
d:\db\mariadb\bin> mysql_install_db.exe
#run the next ocmmand either in a new window or open another one afterwards, this is the mysql daemon service
d:\db\mariadb\bin> myqsld --console 
```
## creating new schema and user ##
```cmd
d:\db\mariadb\bin>mysql -u root
MariaDB [(none)]> create database new_db;
MariaDB [(none)]> create user 'new_user'@'localhost' identified by 'super-password';
MariaDB [(none)]> grant all privileges on new_db.* to 'new_user'@'localhost';
MariaDB [(none)]> flush privileges; -- reloads the grant tables in the mysql database
MariaDB [(none)]> exit

#login as new user
d:\db\mariadb\bin>mysql -u new_user -p
MariaDB [(none)]> use new_db;
MariaDB [(new_db)]> create table .......

```
