#!/bin/bash

#================================================
# 録画サーバ構築
# 復号ライブラリarib25のインストール
# ホストで行う必要はない
#================================================

# 必要なパッケージのインストール
# 全部必要なのかは不明
dnf install wget git unzip bzip2 gcc gcc-c++ make automake kernel-devel patch perl-ExtUtils-MakeMaker libtool openssl-devel boost-devel cmake -y

dnf --enablerepo=PowerTools install autogen nkf -y
dnf --enablerepo=PowerTools install pcsc-lite-devel -y

# arib25のインストール
cd ~/src
git clone https://github.com/stz2012/libarib25.git
cd libarib25/
cmake .		# <- 「.」があることに注意
make
make install
echo /usr/local/lib64 > /etc/ld.so.conf.d/usr-local-lib.conf
ldconfig
