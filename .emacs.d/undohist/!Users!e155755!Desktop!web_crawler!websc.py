
((digest . "4da9715f77375ef3f9872a8c4dcc720f") (undo-list nil ("# Metapod" . 210) ((marker) . -9) (t 22884 24060 0 0) nil (17 . 1545) ("import urllib2
from bs4 import BeautifulSoup

# アクセスするURL
url = \"https://www.buzzfeed.com/awesomer/the-definitive-ranking-of-the-original-151-pokemon?utm_term=.fb10WXwdP#.bf2aLRmDJ\"

# URLにアクセスする htmlが帰ってくる → <html><head><title>経済、株価、ビジネス、政治のニュース:日経電子版</title></head><body....
html = urllib2.urlopen(url)

# htmlをBeautifulSoupで扱う
soup = BeautifulSoup(html, \"html.parser\")

# span要素全てを摘出する→全てのspan要素が配列に入ってかえされます→[<span class=\"m-wficon triDown\"></span>, <span class=\"l-h...
span = soup.find_all(\"span\")

# print時のエラーとならないように最初に宣言しておきます。
nikkei_heikin = \"\"
# for分で全てのspan要素の中からClass=\"hoge\"となっている物を探します
for tag in span:
    # classの設定がされていない要素は、tag.get(\"class\").pop(0)を行うことのできないでエラーとなるため、tryでエラーを回避する
    try:
        # tagの中からclass=\"n\"のnの文字列を摘出します。複数classが設定されている場合があるので
        # get関数では配列で帰ってくる。そのため配列の関数pop(0)により、配列の一番最初を摘出する
        # <span class=\"hoge\" class=\"foo\">  →   [\"hoge\",\"foo\"]  →   hoge
        string_ = tag.get(\"class\").pop(0)

        # 摘出したclassの文字列にmkc-stock_pricesと設定されているかを調べます
        if string_ in \"js-subbuzz__title-text\":
            # mkc-stock_pricesが設定されているのでtagで囲まれた文字列を.stringであぶり出します
            nikkei_heikin = tag.string
            # 摘出が完了したのでfor分を抜けます
#            break
            print nikkei_heikin
    except:
        # パス→何も処理を行わない
        pass

# 摘出した日経平均株価を出力します。
print nikkei_heikin" . 17) ((marker . 17) . -616) ((marker . 17) . -58) ((marker . 17) . -58) ((marker . 17) . -160) ((marker . 17) . -330) ((marker . 17) . -330) ((marker . 17) . -337) ((marker . 17) . -473) ((marker . 17) . -473) ((marker . 17) . -480) ((marker . 17) . -536) ((marker . 17) . -536) ((marker . 17) . -552) ((marker . 17) . -907) ((marker . 17) . -907) ((marker . 17) . -917) ((marker . 17) . -1005) ((marker . 17) . -1005) ((marker) . -15) ((marker) . -15) ((marker) . -45) ((marker) . -45) ((marker) . -46) ((marker) . -46) ((marker) . -58) ((marker) . -58) ((marker) . -182) ((marker) . -182) ((marker) . -183) ((marker) . -183) ((marker) . -277) ((marker) . -277) ((marker) . -305) ((marker) . -305) ((marker) . -306) ((marker) . -306) ((marker) . -330) ((marker) . -330) ((marker) . -372) ((marker) . -372) ((marker) . -373) ((marker) . -373) ((marker) . -473) ((marker) . -473) ((marker) . -502) ((marker) . -502) ((marker) . -503) ((marker) . -503) ((marker) . -536) ((marker) . -536) ((marker) . -555) ((marker) . -555) ((marker) . -600) ((marker) . -600) ((marker) . -617) ((marker) . -617) ((marker) . -698) ((marker) . -698) ((marker) . -707) ((marker) . -707) ((marker) . -769) ((marker) . -769) ((marker) . -827) ((marker) . -827) ((marker) . -899) ((marker) . -899) ((marker) . -941) ((marker) . -941) ((marker) . -942) ((marker) . -942) ((marker) . -997) ((marker) . -997) ((marker) . -1045) ((marker) . -1045) ((marker) . -1113) ((marker) . -1113) ((marker) . -1152) ((marker) . -1152) ((marker) . -1185) ((marker) . -1185) ((marker) . -1204) ((marker) . -1204) ((marker) . -1236) ((marker) . -1236) ((marker) . -1248) ((marker) . -1248) ((marker) . -1271) ((marker) . -1271) ((marker) . -1284) ((marker) . -1284) ((marker) . -1285) ((marker) . -1285) ((marker) . -1305) ((marker) . -1305) (t 22884 23764 0 0)))
