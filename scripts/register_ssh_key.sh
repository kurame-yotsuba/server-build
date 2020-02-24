#!/bin/bash

# 引数チェック
if [ ! $# -eq 1 ]; then
	echo "公開鍵ファイルを１つ指定して下さい。"
	exit 1;
fi

# 変数定義
ssh_dir="$HOME/.ssh"
authorized_keys_file="$HOME/.ssh/authorized_keys"
key_file=$1

# sshディレクトリチェック
if [ ! -d $ssh_dir ]; then
	mkdir $ssh_dir
	chmod 700 $ssh_dir
fi

# 認証ファイルチェック
if [ ! -f $authorized_keys_file ]; then
	touch $authorized_keys_file
	chmod 644 $authorized_keys_file
fi

# 認証ファイルに追記
cat $key_file >> $authorized_keys_file
