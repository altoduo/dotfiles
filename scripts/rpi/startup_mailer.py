import subprocess
import smtplib
import socket
import os
from email.mime.text import MIMEText
import datetime
# Change to your own account information
to ='EMAIL ADDRESS HERE'
gmail_user ='raspi3141592@gmail.com'
gmail_password = 'PASSWORD HERE'
smtpserver = smtplib.SMTP('smtp.gmail.com', 587)
smtpserver.ehlo()
smtpserver.starttls()
smtpserver.ehlo
smtpserver.login(gmail_user, gmail_password)
today = datetime.date.today()
# Very Linux Specific
arg='ip route list'
p=subprocess.Popen(arg,shell=True,stdout=subprocess.PIPE)
data = p.communicate()
split_data = data[0].split()
ipaddr = split_data[split_data.index('src')+1]
# Get the current CPU speed
f = os.popen('/opt/vc/bin/vcgencmd get_config arm_freq')
cpu = f.read()
mail_body = "CPU speed: " + cpu + "IP address: %s" %  ipaddr
msg = MIMEText(mail_body)
msg['Subject'] = "RasPI @ "+ipaddr+" started up on %s" % today.strftime('%b %d %Y')
msg['From'] = gmail_user
msg['To'] = to
smtpserver.sendmail(gmail_user, [to], msg.as_string())
smtpserver.quit()
