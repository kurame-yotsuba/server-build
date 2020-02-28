#!/bin/bash

#================================================
# パッケージのアップグレード
#================================================
dnf upgrade -y

# EPELリポジトリの追加
dnf install epel-release -y

# デフォルトで無効
# 使用するときは --enablerepo=epel
dnf config-manager --disable epel

dnf --enablerepo=epel upgrade -y

#================================================
# 日本語入力パッケージのインストール
# リブートが必要
# リブートのあとに設定が必要
#================================================
dnf install ibus-kkc

# 参考：
# https://ameblo.jp/arcadia-8160/entry-12553884495.html


#================================================
# 各種パッケージのインストール
#================================================

# .Net Core
# 2.0とかも入れておいた方がいいかも
dnf install dotnet-sdk-2.1 dotnet-sdk-3.0 dotnet-sdk-3.1

# KVM
dnf install qemu-kvm virt-install virt-manager

