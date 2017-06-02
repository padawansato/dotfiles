s=[45,160,700,1500,3200,2100,489,499,800,430]

# その中から５MB（5000KB）に収まるグループを選ぶべく最大収量を指定する
c=5000

# pulpライブラリをインポートする
from pulp import *

# ｓに収容したファイルが何個あるか計数し、後述の繰り返しのためのrangeにrnとしてその数を収容する。
rn = range(len(s))

# モデル準備
m = LpProblem('knapsack', LpMaximize)

# 変数(i番目のファイルをいれるかどうかの0/1)
v = [LpVariable('v%d' % i, cat = LpBinary) for i in rn]

# 目的関数
m += lpDot(s, v)

# 制約
m += lpDot(s, v) <= C

# 解く
m.solve()

# 出力
print(LpStatus[m.status], sum(s[i] * value(v[i]) for i in rn))
print([s[i] for i in rn if value(v[i]) > 0.5])