#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （Mirakurunのインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# nodejsとかグローバルにインストールしていいの？っていう問題がある。
# nvmのインストール
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# nodejs（12.16.1）のインストール
# サポートバージョンは以下を参照
# https://github.com/Chinachu/Mirakurun/blob/master/doc/Platforms.md
nvm install --lts

# Mirakurunのインストール
npm install pm2 -g
npm install mirakurun -g --unsafe --production
npm install rivarun -g
npm install arib-b25-stream-test -g --unsafe

# statusがonlineなら正常
pm2 status

# tuners.yamlのコピー
mv /usr/local/etc/mirakurun/tuners.yaml /usr/local/etc/mirakurun/tuners.yaml.original
cat $SCRIPT_DIR/tuners.yaml > /usr/local/etc/mirakurun/tuners.yaml

mirakurun restart

curl -X PUT "http://localhost:40772/api/config/channels/scan"

mirakurun restart

# 待つ
