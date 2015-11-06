@echo off
call ant -f C:\softwares\AntScripts\build.xml stop-jboss	
rem timeout /t 10
call ant -f C:\softwares\AntScripts\build.xml start-jboss