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
# 各種パッケージのインストール
#================================================

# .Net Core
# 2.0とかも入れておいた方がいいかも
dnf install dotnet-sdk-2.1 dotnet-sdk-3.0 dotnet-sdk-3.1

# KVM
dnf install qemu-kvm virt-install virt-manager

