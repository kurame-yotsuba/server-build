# server-build
サーバー構築メモ

CentOS8でやっています。

まずは
```sh
find scripts/ -type f -name *.sh | xargs chmod 755
```
を実行しましょう。

`scripts/res`にはsshの公開鍵が入っている前提です。


## xrdpサーバ
あとはWindowsのリモートデスクトップ接続から。

ただ本体の方でGUIログインしてると上手く行かないかもしれない。

参考：
- [CentOS 8 : Xrdpサーバーの設定 : Server World](https://www.server-world.info/query?os=CentOS_8&p=desktop&f=3)
- [[CentOS 8] xrdp サービスを使う](https://bitwalk.blogspot.com/2019/10/centos-8-xrdp.html)



## px-w3pe4を使った録画サーバ構築

以下は標準リポジトリ、及びEPELリポジトリにはない。
PowerToolsリポジトリを使う。
- autogen
- nkf
- pcsc-lite-devel

参考：
- [録画サーバ構築の前準備（CentOS 7編）、Chinachu・epgrec UNA対応](https://www.jifu-labo.net/2015/09/centos7_pre/)
- [PLEX社製TVチューナーの非公式Linuxドライバインストール方法 ](https://www.jifu-labo.net/2019/01/unofficial_plex_driver/)


## SELinuxをdisabledにしてからenforcingに変えて死

https://www.linuxtechi.com/boot-centos-8-rhel-8-single-user-mode/

https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/7/html/selinux_users_and_administrators_guide/sect-security-enhanced_linux-working_with_selinux-changing_selinux_modes


## KVMで仮想ブリッジ
- [KVMでゲストOSをブリッジ接続する](https://qiita.com/yoshiyasu1111/items/8d07a4fd55116fba07f7)
- [LinuxからSambaをマウントする](https://qiita.com/dojineko/items/e6c21f3fe309b5aae694)
- [samba-client／cifs-utilsを使ってWindowsの共有フォルダをマウントする](https://qiita.com/You_name_is_YU/items/85ffbffee744f6f494ed)
- [spice-client-error-quark: Could not redirect](https://bbs.archlinux.org/viewtopic.php?pid=1628757#p1628757)
- [](https://access.redhat.com/documentation/ja-jp/red_hat_enterprise_linux/6/html/virtualization_administration_guide/sect-managing_guest_virtual_machines_with_virsh-attaching_and_updating_a_device_with_virsh)
