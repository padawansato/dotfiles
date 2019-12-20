#!/bin/sh
 
# ファイルパス(google drive のフォルダurlの最後がid)
ID=1V1iVE-8a8jxJwKXb9ROqfbC64fOjaEDr
# 日付
DATE=`date "+%Y-%m-%d"`


# アップロード
# 引数をファイル名で取る
# 引数がない場合、当日の日誌をuploadする
if [$# -ne 1];then
    
# ファイルがない場合、作成する事もできるが、作成はしない。
if [ -e ${DATE}.txt ];then
gdrive upload ${DATE}.txt -p ${ID} 
fi
exit 1
else # 引数をuploadする
gdrive upload $1 -p ${ID}
fi

exit 0

