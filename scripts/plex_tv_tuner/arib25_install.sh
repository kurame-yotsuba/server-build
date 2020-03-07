#!/bin/bash

#================================================
# 録画サーバ構築
# 復号ライブラリarib25のインストール
# ホストで行う必要はない
#================================================

# arib25のインストール
cd ~/src
git clone https://github.com/stz2012/libarib25.git
cd libarib25/
cmake .		# <- 「.」があることに注意
make
make install
echo /usr/local/lib64 > /etc/ld.so.conf.d/usr-local-lib.conf
ldconfig
