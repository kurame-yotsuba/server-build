#!/bin/sh
# chinachu-transcode_180729.sh
# version 1.0 created on 2018-05-07 by simplelife0530
# version 1.1 modified on 2018-07-29 by simplelife0530
#
export LIBVA_DRIVERS_PATH=/opt/intel/mediasdk/lib64
export LIBVA_DRIVER_NAME=iHD
export MFX_HOME=/opt/intel/mediasdk
export PKG_CONFIG_PATH=/opt/intel/opencl:
#
#時間表示サブプログラム
function setStartTime() {
start_time=`date +%s`
}

function getEndTime() {
end_time=`date +%s`
process_time=`expr ${end_time} - ${start_time}`
}

function displayTime() {
 HH=`expr ${2} / 3600`
 SS=`expr ${2} % 3600`
 MM=`expr ${SS} / 60`
 SS=`expr ${SS} % 60`
 echo "${1} =  ${2} 秒 ${HH}時間${MM}分${SS}秒"
}
#
#出力ファイルの設定
#全角スペース、全角英数字の半角変換（追加＃ー）
file=${1##*/}
filename1=${file%.*}
filename2=`echo "$filename1" | sed 's/　/ /g'`
filename=`echo "$filename2" | sed 'y/ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ０１２３４５６７８９＃－/ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#-/'`
outExt=".mp4"
#
#カテゴリーでフォルダ分けする。
#＜jq＞をインストールする。sudo yum -y install jq
outDir="./temp/"
category=`echo "$2" | jq -r '.category'`
case $category in
 anime) outDir="./temp/" ;;
 information) outDir="./temp/" ;;
 news) outDir="./temp/" ;;
 sports) outDir="./temp/" ;;
 variety) outDir="./temp/" ;;
 documentary) outDir="./temp/" ;;
 drama) outDir="./temp/" ;;
 music) outDir="./temp/" ;;
 cinema) outDir="./temp/" ;;
 theater) outDir="./temp/" ;;
 hobby) outDir="./temp/" ;;
 welfare) outDir="./temp/" ;;
 etc) outDir="./temp/" ;;
 *) outDir="./temp/" ;;
esac
outputFile=$outDir$filename$outExt
#
#ログファイルの設定
logExt=".log"
logFile="./log/mp4log/log"$filename$logExt
#
#番組情報をログに書き出す
{
echo "-------------------------番組名--------------------------"
echo "$1"
echo ""
echo "-------------------------番組情報------------------------"
echo "$2"
echo "$category"
echo ""
} > $logFile
#
#他にトランスコードしている場合は待つ
transcode_command="ffmpeg"
#qsvを利用する場合は、以下を有効にする
#transcode_command="ffmpeg-qsv"
until [ ! `pidof -s $transcode_command` ]
do
    sleep 60
done
#
#エンコード設定
input=" -y -i "
videoCodec=" -vcodec libx264"
#qsvを利用する場合は以下を有効にする
#videoCodec=" -vcodec h264_qsv"
#
videoOpt=" -b:v 4M -maxrate 8M"
#qsvを利用する場合は以下を有効にする
#videoOpt=" -b:v 4M -maxrate 8M -init_hw_device qsv:hw "
audioCodec=" -acodec aac"
audioOpt=""
#audioOpt=" -strict -2 -ac 2 -ar 48000 -ab 128k"
advancedOpt=" -loglevel error "
#advancedOpt=" -loglevel info "
#
command="/usr/local/ffmpeg_build/bin/$transcode_command"$input\"$1\"$videoCodec$videoOpt$audioCodec$audioOpt$advancedOpt\"$outputFile\"
#
#エンコード開始
{
echo "----------------------エンコードコマンド------------------"
echo "${command}"
echo ""
echo "----------------------エンコード開始----------------------"
} >> $logFile

setStartTime

eval ${command} >> $logFile 2>&1

{
echo ""
echo "----------------------エンコード情報-----------------------"
getEndTime
displayTime "処理時間" ${process_time}
duration=`./usr/bin/ffprobe "$outputFile" -hide_banner -show_entries format=duration | sed -n 2p`
recordingTime=${duration#duration=}
displayTime "録画時間" ${recordingTime%.*}
compressSpeed=`echo "scale=2; ${recordingTime}/${process_time}" | bc`
echo "エンコード速度 = ${compressSpeed} 倍"
inputFileSize=`ls -l "$1" | awk '{ print $5; }'`
echo "入力ファイル = $inputFileSize bytes"
outputFileSize=`ls -l "$outputFile" | awk '{ print $5; }'`
echo "出力ファイル = $outputFileSize bytes"
compressionRate=`echo "scale=4; ${outputFileSize}/${inputFileSize}*100" | bc`
echo "圧縮率 = ${compressionRate} %"
echo "----------------------エンコード終了------------------------"
echo ""
} >> $logFile

exit
