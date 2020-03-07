#!/bin/bash

#================================================
# sambaクライアントになり、ファイルサーバーをマウントします
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)
res_dir=$SCRIPT_DIR
fstab_user_file=$SCRIPT_DIR/fstab_kvm.user

dnf install -y samba-client cifs-utils

cat $fstab_user_file >> /etc/fstab
