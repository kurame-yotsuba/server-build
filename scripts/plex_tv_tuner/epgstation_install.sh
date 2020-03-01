#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （EPG Stationのインストール）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

# ffmpegのインストール
dnf --enablerepo=PowerTools install -y autoconf automake bzip2 cmake freetype-devel gcc gcc-c++ git wget libtool make mercurial nasm pkgconfig zlib-devel fribidi-devel fontconfig-devel libpng-devel bzip2-devel

$SCRIPT_DIR/ffmpeg_build.sh

dnf install -y mariadb mariadb-server

mv /etc/my.cnf /etc/my.cnf.original
cat $SCRIPT_DIR/my.cnf > /etc/my.cnf

systemctl enable mariadb --now


mysql_secure_installation
mysql -u root -p


cd ~/src
git clone https://github.com/l3tnun/EPGStation.git
cd EPGStation
npm install
npm run build
# cp config/config.sample.json config/config.json
cat $SCRIPT_DIR/epgstation_config.json > config/config.json
cp config/operatorLogConfig.sample.json config/operatorLogConfig.json
cp config/serviceLogConfig.sample.json config/serviceLogConfig.json


pm2 startup centos
pm2 start dist/server/index.js --name "epgstation"
pm2 save
