# Windows #

## startup ##

``startup_question.cmd``
```bat
@echo off
:setStart
set /p start=Start Programs [y/n]?: 

if "%start%"=="y" (
	call :startPrograms
) 
if "%start%"=="" (
	call :startPrograms
)

echo not launching today
exit

:startPrograms
call D:\startup\start_programs.cmd
exit
```

open start up directory with ``shell:startup``
create link to startup_question.cmd in startup directory

``start_programs.cmd`` all programs are actually links within the same folder as the script 
```bat
cmd /c Start "" "D:\startup\program1"
cmd /c Start "" "D:\startup\program2"
cmd /c Start "" ...
...
```