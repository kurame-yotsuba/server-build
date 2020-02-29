#!/bin/bash

#================================================
# nvmとLTS版nodejsをインストール
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# nvmのインストール
# ローカルにインストールされる
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash

# nvmのパスが追加されているので、再読み込み
. ~/.bashrc

# nodejs（12.16.1）のインストール
# ~/.nvm/versions/node/v12.16.1/にインストールされる
# サポートバージョンは以下を参照
# https://github.com/Chinachu/Mirakurun/blob/master/doc/Platforms.md
nvm install --lts
