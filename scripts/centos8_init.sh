#!/bin/bash

#================================================
# rootで実行してください！
#================================================


#================================================
# 日本語入力パッケージのインストール
# リブートが必要
# リブートのあとに設定が必要
#================================================
dnf install ibus-kkc

# 参考：
# https://ameblo.jp/arcadia-8160/entry-12553884495.html

#================================================
# SSHの設定
#================================================

# 各ユーザーでregister_ssh_key.shを実行

#================================================
# Chronyの設定
#================================================
vi /etc/chrony.conf




#================================================
# DLNAサーバの構築
#================================================


#================================================
# Plex Media Serverの設定
#================================================

dnf install wget git unzip bzip2 gcc gcc-c++ make automake kernel-devel patch perl-ExtUtils-MakeMaker libtool openssl-devel boost-devel cmake -y


dnf --enablerepo=PowerTools install autogen nkf -y
dnf --enablerepo=epel install dkms -y

dnf install ccid -y
dnf --enablerepo=PowerTools install pcsc-lite-devel -y
dnf --enablerepo=epel install pcsc-tools -y
