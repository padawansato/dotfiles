
((digest . "8e535157f7afe8ca6374304b3c06af24") (undo-list (587 . 588) 1 nil (1 . 587) nil ("problem += x >= 0 #(6.5)
" . 1) ((marker . 506) . -25) ((marker . 1) . -25) ((marker . 506) . -25) ((marker . 507) . -25) ((marker) . -25) ((marker) . -25) ((marker) . -25) nil (nil rear-nonsticky nil 25 . 26) (1 . 26) nil ("import pulp as pulp

#Creat variables
x = pulp.LpVariable(\"x\", cat = \"Integer\")
y = pulp.LpVariable(\"y\", cat = \"Integer\")

#Create object function
problem = pulp.LpProblem(\"Container\", pulp.LpMaximize)
problem += 29*x + 45*y  #(6.6)

#constrained condition
problem += 2*x + 8*y <= 60 #(6.4)
problem += 4*x + 4*y <= 60 #(6.4)
problem += x >= 0 #(6.5)
problem += y >= 0 #(6.5)

status = problem.solve()
print \"Status\", pulp.LpStatus[status]

print problem

print \"Result\"
print \"x\", x.value()
print \"y\", y.value()
" . 1) ((marker . 506) . -512) ((marker . 1) . -122) ((marker* . 588) . 493) ((marker* . 588) . 493) ((marker . 1) . -19) ((marker . 1) . -19) ((marker . 1) . -19) ((marker . 1) . -336) ((marker . 1) . -122) ((marker . 1) . -336) ((marker) . -512) ((marker . 1) . -325) ((marker . 1) . -350) ((marker . 506) . -512) ((marker . 507) . -512) ((marker) . -350) ((marker) . -351) ((marker) . -325) ((marker) . -326) ((marker) . -336) ((marker) . -337) ((marker) . -122) ((marker) . -123) (t 22876 17546 0 0) nil (20 . 21) (t 22876 17544 0 0) nil (511 . 512) 20 nil (5 . 20) nil ("e" . -5) ((marker . 1) . -1) ("h" . -6) ((marker . 1) . -1) 7 nil (1 . 7) nil (1 . 2) nil (1 . 491) nil ("# coding: UTF-8

# 線形/整数最適化問題を解くためにPuLPをインポート
import pulp
# 計算時間を計るのに time をインポート
import time



# 作業員の集合（便宜上、リストを用いる）
I = [\"Aさん\", \"Bさん\", \"Cさん\"]

print(\"作業員の集合 I = {:}\".format(I))


# タスクの集合（便宜上、リストを用いる）
J = [\"仕事イ\", \"仕事ロ\", \"仕事ハ\"]

print(\"タスクの集合 J = {:}\".format(J))


# 作業員 i を タスク j に割り当てたときのコストの集合（一時的なリスト）
cc = [
      [ 1,  2,  3],
      [ 4,  6,  8],
      [10, 13, 16],
     ]

# cc はリストであり、添え字が数値なので、
# 辞書 c を定義し、cc[0][0] は c[\"Aさん\",\"仕事イ\"] でアクセスできるようにする
c = {} # 空の辞書
for i in I:
    for j in J:
        c[i,j] = cc[I.index(i)][J.index(j)]

print(\"コスト c[i,j]: \")
for i in I:
    for j in J:
        print(\"c[{:},{:}] = {:2d},  \".format(i, j, c[i,j]), end = \"\")
    print(\"\")
print(\"\")



# 数理最適化問題（最小化）を宣言
problem = pulp.LpProblem(\"Problem-2\", pulp.LpMinimize)
# pulp.LpMinimize : 最小化 
# pulp.LpMaximize : 最大化


# 変数集合を表す辞書
x = {} # 空の辞書
       # x[i,j] または x[(i,j)] で、(i,j) というタプルをキーにしてバリューを読み書き

# 0-1変数を宣言
for i in I:
    for j in J:
        x[i,j] = pulp.LpVariable(\"x({:},{:})\".format(i,j), 0, 1, pulp.LpInteger)
        # 変数ラベルに '[' や ']' や '-' を入れても、なぜか '_' に変わる…？

# 内包表記も使える
#x_suffixes = [(i,j) for i in I for j in J]
#x = pulp.LpVariable.dicts(\"x\", x_suffixes, cat = pulp.LpBinary) 
# lowBound, upBound を指定しないと、それぞれ -無限大, +無限大 になる

# pulp.LpContinuous : 連続変数
# pulp.LpInteger    : 整数変数
# pulp.LpBinary     : 0-1変数


# 目的関数を宣言
problem += pulp.lpSum(c[i,j] * x[i,j] for i in I for j in J), \"TotalCost\"
#problem += sum(c[i,j] * x[i,j] for i in I for j in J)
# としてもOK


# 制約条件を宣言
# 各作業員 i について、割り当ててよいタスク数は1つ以下
for i in I:
    problem += sum(x[i,j] for j in J) <= 1, \"Constraint_leq_{:}\".format(i)
    # 制約条件ラベルに '[' や ']' や '-' を入れても、なぜか '_' に変わる…？

# 各タスク j について、割り当てられる作業員数はちょうど1人
for j in J:
    problem += sum(x[i,j] for i in I) == 1, \"Constraint_eq_{:}\".format(j)


# 問題の式全部を表示
print(\"問題の式\")
print(\"--------\")
print(problem)
print(\"--------\")
print(\"\")



# 計算
# ソルバー指定
solver = pulp.solvers.PULP_CBC_CMD()
# pulp.solvers.PULP_CBC_CMD() : PuLP付属のCoin-CBC
# pulp.solvers.GUROBI_CMD()   : Gurobiをコマンドラインから起動 (.lpファイルを一時生成)
# pulp.solvers.GUROBI()       : Gurobiをライブラリーから起動 (ライブラリーの場所指定が必要)
# ほかにもいくつかのソルバーに対応
# (使用例)
#if pulp.solvers.GUROBI_CMD().available():
#    solver = pulp.solvers.GUROBI_CMD()

# 時間計測開始
time_start = time.clock()

result_status = problem.solve(solver)
# solve()の()内でソルバーを指定できる
# 何も指定しない場合は pulp.solvers.PULP_CBC_CMD() 

# 時間計測終了
time_stop = time.clock()



# （解が得られていれば）目的関数値や解を表示
print(\"計算結果\")
print(\"********\")
print(\"最適性 = {:}, 目的関数値 = {:}, 計算時間 = {:} (秒)\"
      .format(pulp.LpStatus[result_status], pulp.value(problem.objective), 
              time_stop - time_start))
print(\"解 x[i,j]: \")
for i in I:
    for j in J:
        print(\"{:} = {:},  \"
              .format(x[i,j].name, x[i,j].value()), end=\"\")
    print(\"\")
print(\"********\")" . 1) ((marker . 506) . -2782) ((marker . 1) . -2782) ((marker . 1) . -2782) ((marker . 1) . -2782) ((marker . 506) . -2782) ((marker . 507) . -2782) ((marker) . -2782) ((marker) . -2782) ((marker) . -2782) nil (1 . 2783) nil ("# coding: UTF-8

# 線形/整数最適化問題を解くためにPuLPをインポート
import pulp
# sys.maxsizeでintの最大値を取得するためにインポート
import sys

# 数理最適化問題（最大化）を宣言
problem = pulp.LpProblem(\"Problem-1\", pulp.LpMaximize)

# 変数（連続）を宣言
x = pulp.LpVariable(\"x\", 0, 999, pulp.LpContinuous)
y = pulp.LpVariable(\"y\", 0, sys.maxsize, pulp.LpContinuous)

# 目的関数を宣言
problem += ( x + y, \"Objective\" )
# かっこは不要だけど、わかりやすさのため記載

# 制約条件を宣言
problem += ( 2 * x + y <= 2 , \"Constraint_1\" )
problem += ( x + 2 * y <= 2 , \"Constraint_2\" )

# 問題の式全部を表示
print(\"問題の式\")
print(\"--------\")
print(problem)
print(\"--------\")

# 計算
result_status = problem.solve()

# （解が得られていれば）目的関数値や解を表示
print(\"\")
print(\"計算結果\")
print(\"********\")
print(\"最適性 = {}\".format(pulp.LpStatus[result_status]))
print(\"目的関数値 = {}\".format(pulp.value(problem.objective)))
print(\"解 x = {}\".format(pulp.value(x)))
print(\"　 y = {}\".format(pulp.value(y)))
print(\"********\")" . 1) ((marker . 506) . -870) ((marker . 1) . -303) ((marker . 1) . -138) ((marker . 1) . -138) ((marker . 506) . -870) ((marker . 507) . -870) ((marker) . -138) ((marker) . -139) ((marker) . -303) ((marker) . -304) ((marker) . -870) nil (1 . 871) nil ("from pulp import *
m = LpProblem(sense=LpMaximize) # 数理モデル
x = LpVariable('x', lowBound=0) # 変数
y = LpVariable('y', lowBound=0) # 変数
m += 100 * x + 100 * y # 目的関数
m += x + 2 * y <= 16 # 材料Aの上限の制約条件
m += 3 * x + y <= 18 # 材料Bの上限の制約条件
m.solve() # ソルバーの実行
print(value(x), value(y)) # 4, 6
" . 1) ((marker . 1) . -286) ((marker . 506) . -286) ((marker . 1) . -286) ((marker . 506) . -286) ((marker . 507) . -286) ((marker) . -286) ((marker) . -286) ((marker) . -286) ((marker) . -286) ((marker) . -286) (t 22857 55664 0 0) nil (286 . 287) nil (1 . 286) (t . 0)))
