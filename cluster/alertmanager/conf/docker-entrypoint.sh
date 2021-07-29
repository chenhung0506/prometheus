#!/bin/sh -e

cat /etc/alertmanager/alertmanager.yml |\
    sed "s:#group_wait\:#:group_wait\: $GROUP_WAIT:g" |\
    sed "s:#group_interval\:#:group_interval\: $GROUP_INTERVAL:g" |\
    sed "s:#repeat_interval\:#:repeat_interval\: $REPEAT_INTERVAL:g" |\
    sed "s:#- to\:#:- to\: '$TO':g" |\
    sed "s:#from\:#:from\: '$FROM':g" |\
    sed "s:#smarthost\:#:smarthost\: '$SMARTHOST:g" |\
    sed "s:#smarthost_port#:$SMARTHOST_PORT':g" |\
    sed "s:#require_tls\:#:require_tls\: $REQUIRE_TLS:g" |\
    sed "s:#subject\:#:subject\: $SUBJECT:g" > /tmp/alertmanager.yml

if [ ! -z "$AUTH_USERNAME" ]
then 
    mv /tmp/alertmanager.yml /tmp/alertmanager_tmp.yml
    cat /tmp/alertmanager_tmp.yml | sed "s:#auth_username\:#:auth_username\: $AUTH_USERNAME:g" > /tmp/alertmanager.yml
fi 

if [ ! -z "$AUTH_IDENTITY" ]
then 
    mv /tmp/alertmanager.yml /tmp/alertmanager_tmp.yml
    cat /tmp/alertmanager_tmp.yml | sed "s:#auth_identity\:#:auth_identity\: $AUTH_IDENTITY:g" > /tmp/alertmanager.yml
fi 

if [ ! -z "$AUTH_PASSWORD" ]
then 
    mv /tmp/alertmanager.yml /tmp/alertmanager_tmp.yml
    cat /tmp/alertmanager_tmp.yml | sed "s:#auth_password\:#:auth_password\: $AUTH_PASSWORD:g" > /tmp/alertmanager.yml
fi 


    # sed "s@#- to:#@- to: '$TO'@g" |\
        #username: <user>#
        #channel: <channel>#
        #api_url: <url>#
        # username: 'SLACK_USER_TEST'
        # channel: '#SLACK_CHANNEL_TEST'
        # api_url: 'SLACK_URL_TEST'

cp /tmp/alertmanager.yml /etc/alertmanager/alertmanager.yml

set -- /bin/alertmanager "$@"

exec "$@"
