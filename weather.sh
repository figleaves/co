#!/bin/bash

set -eux

CITY=shenzhen
LANGUAGE="zh-CN"
UNIT=m
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"


curl \
    -H "Accept-Language: $LANGUAGE" \
    -H "User-Agent: $UA" \
    -o result.html \
    rate.sx/eth

#wttr.in/$CITY
#wttr.in/$CITY?format=4\&$UNIT


CHAT_ID=$1
BOT_TOKEN=$2
SEND_TEXT=`cat result.html`

curl -k \
     --data chat_id="$CHAT_ID" \
     --data "text=$SEND_TEXT" "https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
