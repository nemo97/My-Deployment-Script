import re
def displaymatch(match):
    if match is None:
        return None
    return '<Match: %r, groups=%r>' % (match.group(), match.groups())
	
data = "";
with open ("C:/applog/logigng.log", "r+") as myfile:
    data=myfile.read().replace('\n', '')
#print(data)	
#prog = re.compile("^select*$")
#result = prog.match(data)
#for var in result:
#	print(var)
print("Lenght of the string ",len(data))
#print(displaymatch(re.search("^([\nA-Za-z0-9_\.\s,=?>()']*select[\nA-Za-z0-9_\.\s,=?>()']*group by[\nA-Za-z\s_\.a-z,0-9]*)",data,re.MULTILINE)))
searches = re.findall(r"(/[\s]*select.+?group by)",data,re.DOTALL)
#match=re.search("select[\n\S\s]*group",data,re.MULTILINE)
count =1
for selected in searches:
	fo = open("C:/applog/foo"+str(count)+".txt", "w+")
	fo.write(selected.strip())	
	fo.close()
#fo.write(match.group())
#fo.write("\n");


#with open("C:/applog/logigng.log") as f:
# print re.findall("^(select[\nA-Za-z0-9_\.\s,=?>\(\)\']*)$",f.read(),re.MULTILINE)
