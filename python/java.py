import re
import os

for root, dirs, files in os.walk('C:\dev_workspace\GatesCVS\source\gates\gates-batch\src\main\java'):
	 for dir in dirs:		
		if dir not in ("CVS") :			
			for file in files:
				print "Directory "+dir +" file name "+file
				with open(os.path.join(root, file), "r") as auto:							
					line = auto.line()
					
