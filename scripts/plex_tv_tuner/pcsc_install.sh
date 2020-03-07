#!/bin/bash

#================================================
# 録画サーバ構築
# ICカードリーダーの設定
# ホストで行う必要はない
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)
res_dir=$SCRIPT_DIR/res

dnf --enablerepo=epel install pcsc-tools -y

# PCSC用のルールファイル作成
cat $res_dir/pcsc.rules > /etc/polkit-1/rules.d/pcsc.rules

systemctl enable pcscd --now

echo "================================================="
echo "一般ユーザでpcsc_scanが成功するかで確認してください"
echo "================================================="

