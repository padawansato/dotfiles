
2
3
4
5
6
7
8
9
10
11
12
13
14
15
'''
リスト形式へのデータの格納
'''
with open('city1.csv', 'r', encoding='UTF-8') as f:
    reader = csv.reader(f)
    for row in reader:
        print(row)
 
'''
辞書形式へのデータの格納
'''
with open('city2.csv', 'r', encoding='UTF-8') as f:
    reader = csv.DictReader(f)
    for row in reader:
        print(row)
