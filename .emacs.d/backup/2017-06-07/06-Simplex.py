# coding: utf-8
"""
今日から使える！組合せ最適化
本プログラムは、上記書籍の理解を助ける目的のサンプルプログラムです。
完全に正しいことを証明するものではありません。
直接販売することを除き、商用でも無料で利用できます。
利用において、損害等が発生しても利用者の責任とします。
License: Python Software Foundation License
"""
from __future__ import print_function, division
import numpy as np
def Simplex(A, b, c):
    """
    シンプレックス法
        min: c^T * x
        s.t.: Ax = b, x >= 0
    入力
        A, b, c: 上記式の通り
    出力
        最適値
    備考
        自明な初期解から始められるように基底変数、非基底変数の順に並んでいるとする
    """
    n, m = len(c), len(b) # 変数数, 制約数
    bs = list(range(m)) # 基底index
    assert(np.linalg.det(A.T[bs]) > 1e-6 and np.all(np.dot(np.linalg.inv(A.T[bs].T), b) >= 0))
    while True:
        B = A.T[bs].T
        bb = np.dot(np.linalg.inv(B), b)
        pi = np.dot(np.linalg.inv(B.T), c[bs])
        cpia = [0 if j in bs else v for j, v in enumerate(c - np.dot(pi, A))]
        i = np.argmin(cpia)
        if cpia[i] >= 0:
            break
        y = np.dot(np.linalg.inv(B), A[:, i])
        if y.max() <= 0:
            return np.nan, 'Unbounded'
        bby = (bb / np.maximum(y, np.ones(m) * 1e-16))
        theta = bby.min()
        k = bby.argmin()
        bs.remove(bs[k])
        bs.append(i)
    x = [0] * n
    for i in range(m): x[bs[i]] = bb[i]
    return np.dot(c, x)

from pulp import *
def LinearOptimize(A, b, c):
    m = LpProblem()
    x = [LpVariable('x%d' % i, lowBound=0) for i in range(len(c))]
    m.setObjective(lpDot(c, x))
    for j in range(len(b)): m.addConstraint(lpDot(A[j], x) == b[j])
    m.solve()
    return value(m.objective) if m.status == 1 else np.nan

if __name__ == '__main__':
    np.random.seed(1)
    n, m = 20, 13
    for i in range(10): # 10回繰り返す
        N = np.random.random((m, n - m))
        N /= N.sum(axis=0)
        A = np.c_[np.eye(m), N]
        b = np.random.random(m)
        c = -np.random.random(n)
        r1 = round(Simplex(A, b, c), 3)
        r2 = round(LinearOptimize(A, b, c), 3)
        if abs(r1 - r2) > 0.002:
            print('NG')
            break
    else:
        print('All OK')