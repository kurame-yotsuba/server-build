#!/bin/bash

#================================================
# mirakurunユーザの作成
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)
NODE_INSTALL_SCRIPT="install_node_lts.sh"

# rivarunはユーザ側にインストールする
# mirakurunユーザの作成
useradd --comment "For Mirakurun, the TV watching management software" mirakurun

# mirakurunのホームディレクトリ取得
# ここのホームディレクトリ取得を変数使ってできれば「mirakurun」を変数化できるんだが……
mirakurun_home=~mirakurun

cp $SCRIPT_DIR/$NODE_INSTALL_SCRIPT $mirakurun_home

chmod 755 $mirakurun_home/$NODE_INSTALL_SCRIPT
su -c "$mirakurun_home/$NODE_INSTALL_SCRIPT; . ~/.bashrc; npm install rivarun -g" - mirakurun

rm $mirakurun_home/$NODE_INSTALL_SCRIPT

echo "ユーザmirakurunを作成しました。"
