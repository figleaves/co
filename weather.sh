#!/bin/bash

set -eux

CITY=shenzhen
LANGUAGE="zh-CN"
UNIT=m
UA="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36"

curl rate.sx/?qFT > result0.html
cat result0.html |grep "^│"|awk -F "│" '{print $3 $4 $5 $6}' > result1.html
sed -i 's/Coin .*/  Coin     Price      Change(24H)   (1H)/g' result1.html

COINS=$3
cat result1.html |egrep "$COINS" > result1.html


#wttr.in/$CITY
#wttr.in/$CITY?format=4\&$UNIT


CHAT_ID=$1
BOT_TOKEN=$2

d=`date --utc "+%Y-%m-%d %H:%M:%SZ"`
curl -k \
     --data chat_id="$CHAT_ID" \
     --data "text=$d" "https://api.telegram.org/bot$BOT_TOKEN/sendMessage"

SEND_TEXT=`cat result1.html`

curl -k \
     --data chat_id="$CHAT_ID" \
     --data "text=$SEND_TEXT" "https://api.telegram.org/bot$BOT_TOKEN/sendMessage"
