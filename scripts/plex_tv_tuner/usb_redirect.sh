#!/bin/bash

#================================================
# 録画サーバ構築
# USBリダイレクト
#================================================

script_dir=$(cd $(dirname $0); pwd)
res_dir=$script_dir/res
pxw3pe4_config="$res_dir/usb_redirect_pxw3pe4.xml"
smartcard_config="$res_dir/usb_redirect_smartcard.xml"
spice_rules=$res_dir/spice.rules

$vm_name=tv-rec
virsh attach-device $vm_name --file $pxw3pe4_config --config --persistent
virsh attach-device $vm_name --file $smartcard_config --config --persistent

cat $spice_rules > /etc/polkit-1/rules.d/spice.rules
