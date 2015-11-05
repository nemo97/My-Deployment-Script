@echo off
rem call ant -f C:\Tools\antscripts\r1\build.xml
call ant -f C:\softwares\AntScripts\build.xml stop-jboss
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -pl gates-common install
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml install
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -pl gates-interactive-web install
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -pl gates-interactive-web -am package
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -T 4 -pl gates-interactive-web package

rem **** Not required to build from maven anymore , now called from ANT itself ***
call ant -f C:\softwares\AntScripts\build.xml full-deploy-perf	
call ant -f C:\softwares\AntScripts\build.xml start-jboss
rem pause
timeout /t 20