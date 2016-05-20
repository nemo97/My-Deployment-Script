import requests
# Import smtplib for the actual sending function
import smtplib

# Import the email modules we'll need
from email.mime.text import MIMEText

web = requests.get('http://dev2.gates.matson.com/gates/')
print  web.status_code

svc = requests.get('http://dev2.svc.gates.matson.com/gates-service/')
print  svc.status_code

message = ""
if(web.status_code <> 200):
	message =  message + " DEV2 Web is down, status code: "+str(web.status_code)

if(svc.status_code <> 200):
	message = message+ "\n DEV2 SVC is down, status code: "+str(svc.status_code)	
	
print message 	

if(web.status_code <> 200 | svc.status_code <> 200):
	msg = MIMEText(message)
	msg['Subject'] = "Dev2 is down"
	msg['From'] = "ssing@matson.com"
	msg['To'] = "ssing@matson.com"
	
	s = smtplib.SMTP('emailweb.matson.com')
	s.sendmail("ssing@matson.com", "ssing@matson.com", msg.as_string())
	print "Email sent"
	s.quit()
#print response.text
