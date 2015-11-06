@echo off
rem call ant -f C:\Tools\antscripts\r1\build.xml
rem start "Jboss" cmd /k "ant -f C:\softwares\AntScripts\build.xml stop-jboss"
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -pl gates-common install
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml install
call ant -f C:\softwares\AntScripts\build.xml stop-jboss
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -T 4 -pl gates-interactive-web compile -P CustomBuildProfile 
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -pl gates-interactive-web -am package
rem call mvn -f C:\dev_workspace\gates_fresh\source\gates\pom.xml -T 4 -pl gates-interactive-web package
call ant -f C:\softwares\AntScripts\build.xml web-project-deploy	
call ant -f C:\softwares\AntScripts\build.xml start-jboss
rem call ant -f C:\softwares\AntScripts\build.xml start-jboss
rem pause
timeout /t 20