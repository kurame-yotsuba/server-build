#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （非公式ドライバ、録画コマンドインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# 各種パッケージのインストール
dnf install wget git unzip bzip2 gcc gcc-c++ make automake kernel-devel patch perl-ExtUtils-MakeMaker libtool openssl-devel boost-devel cmake -y

dnf --enablerepo=PowerTools install autogen nkf -y
dnf --enablerepo=epel install dkms -y

dnf install ccid -y
dnf --enablerepo=PowerTools install pcsc-lite-devel -y
dnf --enablerepo=epel install pcsc-tools -y

# PCSC用のルールファイル作成
cat $SCRIPT_DIR/pcsc.rules > /etc/polkit-1/rules.d/pcsc.rules

systemctl enable pcscd --now

# arib25のインストール
mkdir ~/src
cd ~/src
git clone https://github.com/stz2012/libarib25.git
cd libarib25/
cmake .		# <- 「.」があることに注意
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

cat $SCRIPT_DIR/dkms.install > dkms.install
bash dkms.install

echo "================================================="
echo "|一般ユーザでpcsc_scanが成功するかで確認してください|"
echo "|リブートしてください！                           |"
echo "================================================="

exit 0

#================================================
# ここまで自動
#================================================
# 以下は手入力してください
#================================================

# デバイスファイルができているか確認
# /dev/px4video0
# とかができていればOK
ls -l /dev/px4*


# 録画コマンドのインストール
wget http://plex-net.co.jp/download/linux/Linux_Driver.zip
unzip Linux_Driver.zip
cd Linux_Driver/MyRecpt1/MyRecpt1/recpt1

sed -i".org" 's/-DTV/video/g' pt1_dev.h

# 手動でコマンド名変更
# $ vi Makefile.in

# 変更前) ※7行目以降
# TARGET = recpt1
# TARGET2 = recpt1ctl
# TARGET3 = checksignal

# 変更後)
# TARGET = recpt1_px4
# TARGET2 = recpt1ctl_px4
# TARGET3 = checksignal_px4

# インストール
make clean
sh ./configure --enable-b25
make
make install

