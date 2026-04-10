#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
邮件发送工具 - QQ 邮箱 SMTP
"""
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from email.header import Header
import sys

# QQ 邮箱 SMTP 配置
SMTP_SERVER = "smtp.qq.com"
SMTP_PORT = 465
SMTP_USER = "694937036@qq.com"
SMTP_PASSWORD = "ualiquyfrdpvbded"
FROM_NAME = "小无疾"
FROM_EMAIL = SMTP_USER

def send_email(to_email, subject, content, html=False):
    """发送邮件"""
    try:
        msg = MIMEMultipart()
        msg['From'] = FROM_EMAIL
        msg['To'] = to_email
        msg['Subject'] = Header(subject, 'utf-8')

        if html:
            msg.attach(MIMEText(content, 'html', 'utf-8'))
        else:
            msg.attach(MIMEText(content, 'plain', 'utf-8'))

        # SSL 连接
        with smtplib.SMTP_SSL(SMTP_SERVER, SMTP_PORT) as server:
            server.login(SMTP_USER, SMTP_PASSWORD)
            server.sendmail(FROM_EMAIL, to_email, msg.as_string())
            return True, f"✅ 邮件已发送至 {to_email}"
    except Exception as e:
        return False, f"❌ 发送失败: {str(e)}"

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print("用法: python3 send_mail.py <收件人> <主题> <内容>")
        sys.exit(1)

    to = sys.argv[1]
    subject = sys.argv[2]
    body = sys.argv[3]

    success, msg = send_email(to, subject, body)
    print(msg)
    sys.exit(0 if success else 1)
