#動かない．
#-*- coding:utf-8 -*-

import requests
import csv
import sys,codecs
import re,pprint
import random

sys.stdout = codecs.getwriter("utf-8")(sys.stdout)

def pp(obj):
    pp = pprint.PrettyPrinter(indent=4,width=160)
    str = pp.pformat(obj)
    return re.sub(r"\\u([0-9a-f]{4})", lambda x: unichr(int("0x"+x.group(1), 16)), str) 

category_list={"ポテト":"18-415","春雨":"18-416","大根":"18-417","コールスロー":"18-418","かぼちゃ":"18-419","ごぼう":"18-420","マカロニ":"18-421","シーザー":"18-187","コブ":"18-423","タラモ":"18-424","スパゲティ":"18-189","ホットサラダ":"18-190","トマト":"18-184-943"}


gen_input = input("Input Key Words >> ")

if category_list.has_key(gen_input):
    print(pp(u"かしこまりました。"))
    categoryid = category_list[gen_input]
elif gen_input == "お任せ" or gen_input == "おまかせ":
    print(pp(u"おまかせですね、かしこまりました。"))
    categoryid = random.choice(category_list.values())
else:
    print(pp(u"取り扱っておりません。"))
    exit(1)

url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20121121?"

st_load= {
        "categoryId":categoryid,
        "applicationId":"1034629428804147256",
       }
r = requests.get(url,params = st_load)

res = r.json()

recipe = res["result"][random.randint(0,len(res["result"])-1)]

print(recipe["recipeTitle"])
print(recipe["recipeUrl"])
