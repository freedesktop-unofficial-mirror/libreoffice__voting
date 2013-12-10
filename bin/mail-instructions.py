#!/usr/bin/env python

# Script to send instructions to all voters.
#
# How to use this script
# ======================
#
# You probably want to first update the subject of the e-mail that will be
# sent. The second line of the instructions.txt will be the subject.
#
# So let's suppose that the instructions are in instructions.txt and that you
# made a list of voters in maildata.txt (probably using create-tmp-tokens.pl).
# The format of this file should be:
# name;email;token
#
# You should use this script like this:
# $ ./mail-instructions.pl maildata.txt instructions.txt
#
# This script needs a MTA to send the e-mails. If you don't have one
# or if you're not sure that your ISP allows you to directly send
# mails, it's probably better and safer to run the script from a
# documentfoundation.org server.  Please test this script with your
# own email address by creating a maildata.txt with a single entry
# like foo;your@address;bar
#
# You may want to look at your mail server logs (and maybe keep them) to
# know if the mail was delivered. There are usually 10-15 errors. In case of
# such errors, you can try to look for the new e-mail addresses of the voters
# to ask them if they want to update their registered e-mail address and
# receive the instructions.

import smtplib
import sys
import string
import re
import getpass
import socket
import datetime
try:
    from email.mime.text import MIMEText
    from email.mime.nonmultipart import MIMENonMultipart
    from email.charset import Charset
except ImportError:
    from email.MIMEText import MIMEText
    from email.Charset import Charset
    from email.MIMENonMultipart import MIMENonMultipart

class MTText(MIMEText):
    def __init__(self, _text, _subtype='plain', _charset='utf-8'):
        if not isinstance(_charset, Charset):
                _charset = Charset(_charset)
        if isinstance(_text,unicode):
            _text = _text.encode(_charset.input_charset)
        MIMENonMultipart.__init__(self, 'text', _subtype,
                                       **{'charset': _charset.input_charset})
        self.set_payload(_text, _charset)

def email_it(recipients_file, instructions_file):
    instructions = file(instructions_file, "r").read().decode('utf-8').splitlines()

    from_mail = instructions.pop(0)
    mc_mail = instructions.pop(0)
    subject_header = instructions.pop(0)

    instructions = "\n".join(instructions)
    template = string.Template(instructions)

    f = file(recipients_file, "r")
    recipient_lines = f.read().decode('utf-8').splitlines()

    sent = 0
    errors = 0
    s = None

    for line in recipient_lines:
        l = line.strip()
        if l.startswith("#") or l == "":
            continue

        l = l.split(";", 2)
        if len(l) <> 3:
            print "ERROR in recipients file, invalid line:"
            print line,
            continue

        member_name, member_email, token = l

        payload = template.substitute(member=member_name, email=member_email, token=token)
        msg = MTText(payload)
        msg['To'] = member_email
        msg['From'] = from_mail
        msg['Reply-To'] = mc_mail
        msg['Errors-To'] = from_mail
        msg['Date'] = datetime.datetime.now().strftime( "%a, %d %b %Y %H:%M:%S +0000 (UTC)" )
        msg['Subject'] = subject_header
        msgstr = msg.as_string()

        if s is None:
            s = smtplib.SMTP()
            s.connect('localhost')

        try:
            s.sendmail(from_mail, [member_email,], msgstr)
        except smtplib.SMTPException:
            print "Error: Could not send to %s (%s)!" % (member_email, member_name)
            errors += 1
        else:
            sent += 1

    if s:
        s.quit()

    f.close()

    print "Mailed %s instructions; %s could not be mailed." % (sent, errors)


if __name__ == '__main__':
    if len(sys.argv) != 3:
        print "Usage: mail-instructions.py <recipient list> <instructions template>"
        sys.exit(1)

    email_it(sys.argv[1], sys.argv[2])
