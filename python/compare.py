

file1 = open('ContainersForVVD.txt', 'r')
FO = open('diff-file.txt', 'w')
index =0 
for line1 in file1:
	found = 0
	#print "line 1 "+line1
	index = index +1
	file2 = open('ContainersForVVD_before.txt', 'r')	
	for line2 in file2:			
		#print "line 2 "+line2	
		if line1 == line2:
			found = 1
			break
			
			
	print str(index)+"matched? "+str(found)
	if(found==0):
		FO.write("%s" %(line1))
			

FO.close()
file1.close()
file2.close()
