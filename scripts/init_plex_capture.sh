#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
#================================================

script_dir=$PWD

# 各種パッケージのインストール
dnf install wget git unzip bzip2 gcc gcc-c++ make automake kernel-devel patch perl-ExtUtils-MakeMaker libtool openssl-devel boost-devel cmake -y

dnf --enablerepo=PowerTools install autogen nkf -y
dnf --enablerepo=epel install dkms -y

dnf install ccid -y
dnf --enablerepo=PowerTools install pcsc-lite-devel -y
dnf --enablerepo=epel install pcsc-tools -y

# arib25のインストール
mkdir ~/src
cd ~/src
git clone https://github.com/stz2012/libarib25.git
cd libarib25/
cmake .
make
make install
echo /usr/local/lib64 > /etc/ld.so.conf.d/usr-local-lib.conf
ldconfig

# 非公式ドライバのインストール
cd ~/src
git clone https://github.com/nns779/px4_drv
cd px4_drv/fwtool/
make
wget http://plex-net.co.jp/plex/pxw3u4/pxw3u4_BDA_ver1x64.zip
unzip pxw3u4_BDA_ver1x64.zip
./fwtool pxw3u4_BDA_ver1x64/PXW3U4.sys it930x-firmware.bin
cp -p it930x-firmware.bin /lib/firmware/
cd ..

cat $script_dir/res/dkms.install > dkms.install
bash dkms.install

echo "リブートしてください！"
