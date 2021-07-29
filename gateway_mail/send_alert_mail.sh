#!/usr/bin/env bash
curl --ssl-reqd \
  --url 'smtp://192.168.1.242:25' \
  # --user 'chenhunglin@emotibot.com:chenhunglin@Emotibot' \
  --mail-from 'ebot-ap01@tscc.com.tw' \
  --mail-rcpt 'lighter-huang@easycard.com.tw' \
  --upload-file mail.txt