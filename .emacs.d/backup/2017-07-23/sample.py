import random

def eval_func(solution_list):
    """
    遺伝子リストから何かを評価する
    すべて君の腕に掛かっている！！！
    """
    return sum([value * pow(-1,ind) for (ind,value) in enumerate(solution_list)])

def geneticoptimize(domain,costf,maximize=False,popsize=50,step=1, mutprob=0.2,elite=0.2,maxiter=100):
    """
    domain : 変数の領域 
例えば [(0,100)]*10 とすると0から100の10変数のリストで行う
    costf : 評価函数 ここが肝
    maximize : Trueにすると最大化 デフォルトは最小化
    popsize : 遺伝子の個数 デフォルトは50
    step : 突然変異の変化量 デフォルトは1
    mutprob : 突然変異の確率 デフォルトは0.2
    elite : 生き残る遺伝子の割合 デフォルトは0.2
    maxiter : 繰り返し回数 デフォルトは100
    """
    # 突然変異
    def mutate(vec):
        i = random.SystemRandom().randint(0,len(domain)-1)
        mut = random.SystemRandom().choice(range(1,step + 1))
        if random.SystemRandom().random() < 0.5 and (vec[i] - mut) > domain[i][0]:
            return vec[0:i] + [vec[i] - mut] + vec[i+1:]
        elif (vec[i] + mut) < domain[i][1]:
            return vec[0:i] + [vec[i] + mut] + vec[i+1:]
        else:
            return vec

    # 1点交叉 非推奨
    def one_point_crossover(r1,r2):
        i = random.SystemRandom().randint(1,len(domain)-2)
        
        return random.SystemRandom().choice((r1[0:i] + r2[i:], r2[0:i] + r1[i:]))

    # 2点交叉
    def two_point_crossover(r1,r2):
        i, j = sorted(random.SystemRandom().sample(range(len(domain)),2))
        return random.SystemRandom().choice((r1[0:i] + r2[i:j] + r1[j:] , r2[0:i] + r1[i:j] + r2[j:]))

    # 一様交叉
    def uniform_crossover(r1, r2):
        q1 = r1.copy()
        q2 = r2.copy()
        for i in range(len(r1)):
            if random.SystemRandom().random() < 0.5:
                q1[i], q2[i] = q2[i], q1[i]
        
        return random.SystemRandom().choice([q1,q2])

    # 初期遺伝子プールの作成
    pop=[]
    for i in range(popsize):
        vec = [random.SystemRandom().randint(domain[i][0],domain[i][1]) for i in range(len(domain))]
        pop.append(vec)

    # 生き残る遺伝子の個数
    topelite = int(elite * popsize)

    # 交叉アルゴリズムの選択
    #crossover = two_point_crossover
    crossover = uniform_crossover

    # Main loop
    for i in range(maxiter):
        scores=[(costf(v),v) for v in pop]
        scores.sort()
        if maximize:
            scores.reverse()
        ranked = [v for (s,v) in scores]

        # 弱い遺伝子は淘汰される
        pop = ranked[0:topelite]

        # 生き残った遺伝子同士で交叉したり突然変異したり
        while len(pop) < popsize:
            if random.SystemRandom().random() < mutprob:
                # 突然変異
                c = random.SystemRandom().randint(0,topelite)
                pop.append(mutate(ranked[c]))

            else:
                # 交叉
                c1 = random.SystemRandom().randint(0,topelite)
                c2 = random.SystemRandom().randint(0,topelite)
                pop.append(crossover(ranked[c1],ranked[c2]))
        # 暫定の値を出力
        #print(scores[0][0])
        print(scores[0])

    return scores[0]

# 実行
domain = [(0,100)]*10
ans = geneticoptimize(domain, eval_func, maximize=True,
                    popsize=50,step=1, mutprob=0.2,elite=0.3,maxiter=100)
print("Ans:",ans)       
