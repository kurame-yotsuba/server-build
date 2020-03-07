#!/bin/bash

#================================================
# 仮想マシンを同一ネットワークで扱えるように
# ブリッジを作成します
#================================================

# ネットワークデバイスの確認
# nmcli device

# IPアドレスの確認
# ip addr

# 現在の接続の確認
# nmcli connection show

nmcli connection add type bridge ifname br0

# スパニングツリーの無効化
# nmcli connection show bridge-br0 | grep bridge.stp
nmcli connection modify bridge-br0 bridge.stp no

# IPv4の設定
# nmcli connection show bridge-br0 | grep ipv4
nmcli connection modify bridge-br0 ipv4.method manual ipv4.addresses "192.168.1.192/24" ipv4.gateway "192.168.1.1" ipv4.dns 192.168.1.1

# ブリッジとenp7s0を繋げる
nmcli connection add type bridge-slave ifname enp7s0 master br0

# enp7s0の削除
nmcli connection delete enp7s0

# このあと接続が切れる
