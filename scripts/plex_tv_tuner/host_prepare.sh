#!/bin/bash

#================================================
# px-w3pe4を使った録画サーバ構築
# （ホストの準備）
#================================================

SCRIPT_DIR=$(cd $(dirname $0); pwd)
res_dir=$SCRIPT_DIR/res

guest_name="tv-rec"
tv_tuner_info=$res_dir/usb_redirect_pxw3pe4.xml
card_reader_info=$res_dir/usb_redirect_smartcard.xml

virsh attach-device $guest_name --file $tv_tuner_info --config --persistent
virsh attach-device $guest_name --file $card_reader_info --config --persistent
