#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （Mirakurunのインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# nvmとnodejsのインストール
$SCRIPT_DIR/install_node_lts.sh

# Mirakurunのインストール
npm install pm2 -g
npm install mirakurun -g --unsafe --production
npm install arib-b25-stream-test -g --unsafe

$SCRIPT_DIR/make_mirakurun_user.sh

# statusがonlineなら正常
pm2 status

# tuners.yamlのコピー
mv /usr/local/etc/mirakurun/tuners.yaml /usr/local/etc/mirakurun/tuners.yaml.original
cat $SCRIPT_DIR/tuners.yaml > /usr/local/etc/mirakurun/tuners.yaml

mirakurun restart

curl -X PUT "http://localhost:40772/api/config/channels/scan"

mirakurun restart

# 待つ
