#!/bin/sh
 
# ファイルパス(google drive のフォルダurlの最後がid)
ID=1V1iVE-8a8jxJwKXb9ROqfbC64fOjaEDr
# 日付
DATE=`date "+%Y-%m-%d"`


# アップロード
# ファイルがない場合作成する事もできるが、作成はしない。
if [ -e ${DATE}.txt ];
then
gdrive upload ${DATE}.txt -p ${ID} 
fi

exit 0
