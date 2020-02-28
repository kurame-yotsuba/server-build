#!/bin/bash

#================================================
# Sambaの設定
# 先にマウントを終わらせていること
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)

dnf install samba samba-client samba-winbind samba-winbind-clients -y

firewall-cmd --add-service=samba --permanent --zone=public
firewall-cmd --add-service=samba-client --permanent --zone=public

# SELinuxの設定
# ホームディレクトリ共有をしないので多分これだけでOK
setsebool -P samba_domain_controller on
setsebool -P samba_export_all_rw on
setsebool -P tmpreaper_use_samba on

# オリジナルの設定ファイルのバックアップ
mv /etc/samba/smb.conf /etc/samba/smb.conf.original
cat $SCRIPT_DIR/smb.conf > /etc/samba/smb.conf

systemctl enable smb --now
systemctl enable nmb --now
systemctl enable winbind --now

echo "==========================================="
echo "pdbedit -a ユーザ名"
echo "でSambaユーザの作成をしてください。"
echo "Sambaユーザはシステムにいるユーザであること"
echo "上手くいかなかったらクライアントを再起動してみる"
echo "==========================================="
