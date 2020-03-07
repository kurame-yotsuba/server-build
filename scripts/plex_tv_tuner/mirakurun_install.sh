#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （Mirakurunのインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)
res_dir=$SCRIPT_DIR/res

# nodejsのインストール
curl -sL https://rpm.nodesource.com/setup_12.x | bash -
dnf upgrade -y
dnf install nodejs -y

# Mirakurunのインストール
npm install pm2 -g
npm install mirakurun -g --unsafe --production
npm install rivarun -g
npm install arib-b25-stream-test -g --unsafe

# statusがonlineなら正常
pm2 status

# tuners.ymlのコピー
mv /usr/local/etc/mirakurun/tuners.yml /usr/local/etc/mirakurun/tuners.yml.original
cat $res_dir/tuners.yml > /usr/local/etc/mirakurun/tuners.yml

mirakurun restart

curl -X PUT "http://localhost:40772/api/config/channels/scan"

mirakurun restart

# ログ管理用にlogrotateインストール
pm2 install pm2-logrotate
cat $SCRIPT_DIR/mirakurun.log.conf > /etc/logrotate.d/mirakurun

exit 0


# 待つ

# このコマンドで空のservicesが消えたらOK
rivarun --list | sed 's/},/},\n/g'

# 録画確認
rivarun --b25 --sid 1024 --ch GR/27 15 test2.ts
rivarun --b25 --mirakurun localhost:40772 --sid 1024 --ch GR/27 15 test3.ts
