@echo off

rem ***** Stop Jboss if running **
call ant -f C:\softwares\AntScripts\build.xml stop-jboss

rem **** Not required to build from maven anymore , now called from ANT itself ***
call ant -f C:\softwares\AntScripts\build.xml scheduled-task	

rem ***** Start Jboss **
call ant -f C:\softwares\AntScripts\build.xml start-jboss
rem call ant -f C:\softwares\AntScripts\build.xml alert
start "" /B notepad /A C:/softwares/AntScripts/logs/full.txt 
start "" /B notepad /A C:/softwares/AntScripts/logs/cvsupdate.log
rem pause