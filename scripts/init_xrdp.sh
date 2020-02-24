#!/bin/bash

#================================================
# xrdpサーバの構築
# Windowsからリモートデスクトップ接続をできるようにする
# 本体でGUIログインしてると上手くリモートログインできないかもしれない
#================================================

# 必要なパッケージのインストール
dnf --enablerepo=epel install xrdp tigervnc-server

# 有効化＋起動
systemctl enable xrdp --now

# ファイアーウォール設定
firewall-cmd --add-port=3389/tcp --permanent
firewall-cmd --reload
