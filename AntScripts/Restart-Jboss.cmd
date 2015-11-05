@echo off
call ant -f C:\softwares\AntScripts\build.xml stop-jboss	
timeout /t 10
call ant -f C:\softwares\AntScripts\build.xml start-jboss