#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （MirakurunのPM2への登録）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# なぜか自動登録だと勝手に切れる。
# 先にPM2の自動起動を解除しておく
# pm2 unstartup

mirakurun_dir="/usr/lib/node_modules/mirakurun"

pushd $mirakurun_dir
pm2 start processes.json
popd

