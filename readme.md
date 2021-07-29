# Prometheus deploy
###### tags: `work`

[TOC]
## Repository struct
```
.
├── cluster
│   ├── LICENSE
│   ├── README.md
│   ├── alertmanager
│   ├── backup_img_to_emoti_harbor.sh # 簡易的將internet 版控制 emotibot harbor
│   ├── caddyf
│   ├── docker-compose.traefik.yml
│   ├── docker-compose.yml
│   ├── dockerd-exporter
│   ├── grafana
│   ├── node-exporter
│   ├── prometheus
│   ├── run.sh # 部署 swarm prometheus
│   ├── send_mail.sh # swarm 測試寄信功能
│   ├── test-compose.yml
│   └── weave-compose.yml
├── gateway_mail
│   ├── mail.txt # 信件內容
│   └── send_alert_mail.sh # gateway 用寄信腳本
├── readme.md
├── single #單機版prometheus
│   ├── alert_rules.yaml #修改rule
│   ├── alertmanager.yaml
│   ├── docker-compose.yaml #修改寄信設定
│   ├── prometheus.yaml
│   └── send_mail.sh #單機版測試寄信
└── smtp_deploy
    ├── docker-compose.yml
    ├── docker-compose.yml.bak
    └── mailu.env
```

## Prometheus repository
```
git clone ssh://git@gitlab.emotibot.com:10022/chenhunglin/prometheus.git
```
### Deploy single prometheus

#### Step1: set smtp config in alertmanager.yaml file
```
vi ./single/alertmanager.yaml
```
example:
```yaml=
receivers:
- name: 'email'
  email_configs:
  - to: 'lighter-huang@easycard.com.tw'
    from: 'ebot-ap01@tscc.com.tw'
    smarthost: 192.168.1.242:25
    require_tls: false
    auth_username: 
    auth_identity: 
    auth_password: 
```
#### Step2: deploy prometheus
```
cd ./single && ./send_mail.sh
```

#### Step3: test email 
```
cd ./single && docker-compose up -d
```


### Deploy cluster prometheus
#### Step1: set smtp config in docker-compse.yaml file
```
vi ./cluster/docker-compose.yaml
```
example:
```yaml=
  alertmanager:
    image: harbor.emotibot.com/bfop/prometheus:99e4524-20210622-0531
    environment:
      - GROUP_WAIT=5s #初次發警報的延時
      - GROUP_INTERVAL=3h #初始警報組如果已經發送，需要等待多長時間再發送同組新產生的其他報警
      - REPEAT_INTERVAL=3h #如果警報已經成功發送，間隔多長時間再重複發送
      - TO=chenhung0506@gmail.com # 寄送對象
      - FROM=chenhunglin@emotibot.com # 寄信人
      - SMARTHOST=smtp.partner.outlook.cn #SMTP SERVER 
      - SMARTHOST_PORT=587 #SMTP SERVER PORT
      - AUTH_USERNAME=chenhunglin@emotibot.com # 登入 SMTP 使用的帳號
      - AUTH_IDENTITY=chenhunglin@emotibot.com # 登入 SMTP 使用的帳號
      - AUTH_PASSWORD=chenhunglin@Emotibot # 登入 SMTP 使用的密碼
```
> Official document
> https://prometheus.io/docs/alerting/latest/configuration/#email-receiver-email_config
```yaml=
global:
  # The default SMTP From header field.
  [ smtp_from: <tmpl_string> ]
  # The default SMTP smarthost used for sending emails, including port number.
  # Port number usually is 25, or 587 for SMTP over TLS (sometimes referred to as STARTTLS).
  # Example: smtp.example.org:587
  [ smtp_smarthost: <string> ]
  # The default hostname to identify to the SMTP server.
  [ smtp_hello: <string> | default = "localhost" ]
  # SMTP Auth using CRAM-MD5, LOGIN and PLAIN. If empty, Alertmanager doesn't authenticate to the SMTP server.
  [ smtp_auth_username: <string> ]
  # SMTP Auth using LOGIN and PLAIN.
  [ smtp_auth_password: <secret> ]
  # SMTP Auth using PLAIN.
  [ smtp_auth_identity: <string> ]
  # SMTP Auth using CRAM-MD5.
  [ smtp_auth_secret: <secret> ]
  # The default SMTP TLS requirement.
  # Note that Go does not support unencrypted connections to remote SMTP endpoints.
  [ smtp_require_tls: <bool> | default = true ]
```


#### Step2: deploy prometheus
```
cd ./cluster && ./run.sh
```

#### Step3: test email
```
cd ./cluster && ./send_mail.sh 

執行後需手動輸入密碼 admin
```
##### 如果有改過 alertmanager 的 port 請調整 send_mail.sh 最後一行的 PORT
```
curl -XPOST -u admin -p admin -d "$alerts1" 172.17.0.1:${PORT}/api/v1/alerts
```


### Deploy gateway alertmail (Gateway 報警信)
#### Step1: set smtp config in docker-compse.yaml file
```
vi ./gateway_mail/send_alert_mail.sh 
```

#### Step2: set email content in mail.txt file
```
vi ./gateway_mail/mail.txt
```

## Grafana 相關設定可參考
> https://blog.techbridge.cc/2019/08/26/how-to-use-prometheus-grafana-in-flask-app/
