#!/usr/bin/env python
# -*- coding: utf-8 -*-
import requests
import csv
import sys, codecs
sys.stdout = codecs.getwriter("utf-8")(sys.stdout)

gen_input = input("catID input here: ")

url = "https://app.rakuten.co.jp/services/api/IchibaItem/Ranking/20120927?"

st_load = {
    "genreId": gen_input,
    "applicationId": ******************************,
    }

r = requests.get(url, params=st_load)

res = r.json()

f = open("raku.csv" , "ab")
writer = csv.writer(f)
writer.writerow(["No", "Itemname", "URL", "Price"])

for i in res["Items"]:
    item = i["Item"]
    Rank = item["rank"]
    Name = (item["itemName"].encode("utf-8"))
    Url = item["itemUrl"]
    Price = item["itemPrice"]

    writer.writerow([Rank, Name, Url, Price])

f.close()
