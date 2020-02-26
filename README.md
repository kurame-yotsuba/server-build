# server-build
サーバー構築メモ

CentOS8でやっています。

まずは
```sh
find scripts/ -type f -name *.sh
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
