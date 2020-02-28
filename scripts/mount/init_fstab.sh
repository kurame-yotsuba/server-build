#!/bin/bash

#================================================
# マウントの設定
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# ユーザ（僕）が付け加えたマウント情報のファイル
fstab_file="$SCRIPT_DIR/fstab.user"
cat $fstab_file >> /etc/fstab
