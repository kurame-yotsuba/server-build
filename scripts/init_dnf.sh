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

