# Bugs (maybe not) #
with timestamps to signal last investigation 
## pipefail bug? ## 
*Timestamp: 01.2021* 

I was probably confused 
```bash
set -Eeuo pipefail

foo="amk"
if [ $foo = "amk" ; then #<-- why is this evaluating to true even with -Eeuo
    echo "amk"
else
    echo "no amk"
fi

echo $?
exit
```

## windows startup folder & cd command
*timestamp: 05.2021*

File structure like this
```
.
+-- C:\
|   +-- Program Files\
|   +-- Users\
|   +-- Windows\
|   +-- ...
+-- D:\
|   +-- tools\
|   +-- dev\
|   +-- startup\ <-- This is important
|   +-- work\
|   +-- ...
+-- ...
``` 
now in cmd:
```bat
Microsoft Windows [Version 10.0.19042.867]
(c) 2020 Microsoft Corporation. Alle Rechte vorbehalten.

C:\WINDOWS\system32>systeminfo

...
Betriebssystemname:                            Microsoft Windows 10 Pro
Betriebssystemversion:                         10.0.19042 Nicht zutreffend Build 19042
Betriebssystemhersteller:                      Microsoft Corporation
...

C:\WINDOWS\system32>D:  <-- changing drive to D:

D:\startup>             <-- automatically goes to startup directory

# if you cd to other dir windows seems to 
#remember where to change directory on drive change 

D:\startup>cd ..\work   
D:\work>C:              <-- changing drive to C:
C:\WINDOWS\system32>D:  <-- changing drive back to D:
D:\work>                <-- now goes to work directory
```
this only happens when I have a folder named `startup` in other drive.

Could be some ancient Windows/DOS left over? 
