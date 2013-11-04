#!/usr/bin/python3

import subprocess
import smtplib
import socket
import os
from email.mime.text import MIMEText
import datetime

# Change to your own account information
to ='RECIPIENT'
gmail_user ='SENDER EMAIL'
gmail_password = 'SENDER EMAIL PASSWORD'
smtpserver = smtplib.SMTP('smtp.gmail.com', 587)
smtpserver.ehlo()
smtpserver.starttls()
smtpserver.ehlo()
smtpserver.login(gmail_user, gmail_password)
today = datetime.date.today()

# Get the ip address of the main route on system
arg='ip route list'
p=subprocess.Popen(arg,shell=True,stdout=subprocess.PIPE)
data = str(p.communicate()[0])
ipaddr = data.split(' ')[2]

# Cpu speed doesn't work either, save for later
cpu = 'INVALID'

# get the hostname of rpi
hostname = socket.gethostname()

# craft the email
#mail_body = "CPU speed: " + cpu + "IP address: %s" %  ipaddr
mail_body = "IP address: " + ipaddr + "\n" + "CPU Speed: " + cpu
msg = MIMEText(mail_body)
msg['Subject'] = hostname + " @ " + ipaddr + " started up on %s" % today.strftime('%b %d %Y')
msg['From'] = gmail_user
msg['To'] = to

# and send the mail
smtpserver.sendmail(gmail_user, [to], msg.as_string())
smtpserver.quit()
