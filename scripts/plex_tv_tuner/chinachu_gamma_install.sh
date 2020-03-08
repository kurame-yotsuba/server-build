#!/bin/bash

#================================================
# 録画サーバ構築
# Chinachu Gammmaインストール
#================================================

git clone -b gamma git://github.com/kanreisa/Chinachu.git ~/chinachu
cd ~/chinachu
./chinachu installer
echo "[]" > rules.json


# 最後にファイアーウォール切る
