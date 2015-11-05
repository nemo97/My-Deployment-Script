@echo off

rem ***** Stop Jboss if running **
call ant -f C:\softwares\AntScripts\build.xml stop-jboss

rem **** Not required to build from maven anymore , now called from ANT itself ***
call ant -f C:\softwares\AntScripts\build.xml scheduled-task	

rem ***** Start Jboss **
call ant -f C:\softwares\AntScripts\build.xml start-jboss
rem pause