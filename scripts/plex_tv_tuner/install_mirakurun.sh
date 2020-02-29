#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （Mirakurunのインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# nvmとnodejsのインストール
$SCRIPT_DIR/install_node_lts.sh

. ~/.bashrc

# Mirakurunのインストール
npm install pm2 -g
npm install mirakurun -g --unsafe --production
npm install arib-b25-stream-test -g --unsafe

# mirakurunユーザの作成
$SCRIPT_DIR/make_mirakurun_user.sh

# statusがonlineなら正常
pm2 status

# tuners.yamlのコピー
mv /usr/local/etc/mirakurun/tuners.yaml /usr/local/etc/mirakurun/tuners.yaml.original
cat $SCRIPT_DIR/tuners.yml > /usr/local/etc/mirakurun/tuners.yml

mirakurun restart

curl -X PUT "http://localhost:40772/api/config/channels/scan"

mirakurun restart

# 待つ

# このコマンドで空のservicesが消えたらOK
echo "rivarun --list | sed 's/},/},\n/g'" | su - mirakurun

# 録画確認
echo "rivarun --b25 --sid 1024 --ch GR/27 15 test2.ts" | su - mirakurun
echo "rivarun --b25 --mirakurun localhost:40772 --sid 1024 --ch GR/27 15 test3.ts" | su - mirakurun

# ログ管理用
pm2 install pm2-logrotate

cat $SCRIPT_DIR/mirakurun.log.conf > /etc/logrotate.d/mirakurun
