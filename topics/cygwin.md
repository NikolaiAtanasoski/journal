# Cygwin # 

## cygwin encoding fix for scripts ##
```bash
(set -o igncr) 2>/dev/null && set -o igncr; # cygwin encoding fix
```
------

## using wrong programs ## 
```bash
#because windows has some programs with same name
alias find="/usr/bin/find.exe"
alias curl="/usr/bin/curl.exe"
alias tar="/usr/bin/tar.exe"
```