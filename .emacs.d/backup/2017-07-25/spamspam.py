# coding: utf-8

import random
import math
import copy
import operator
import pandas as pd

N_ITEMS = 151 #20 #要素数
N_POP = 50 #20   #集団の個体数
N_GEN = 1000 #世代
MUTATE_PROB = 0.1 #突然変異
ELITE_RATE = 0.5 #エリート保存
N_POKE = 6 #手持ちポケモンの数

class GA:
    def __init__(self):
        self.items = {}
        self.fitness_master = {}

    def main(self):
        pop = [{'param': p} for p in self.get_population()]

        for g in range(N_GEN):
            print 'Generation%3s:' % str(g),

            #エリートの選定
            fitness = self.evaluate(pop)
            elites = fitness[:int(len(pop) * ELITE_RATE)]

            #交叉と突然変異
            #突然変異以外は，交叉する．
            pop = elites[:]
            while len(pop) < N_POP:
                if random.random() < MUTATE_PROB:
                    m = random.randint(0, len(elites) - 1)
                    child = self.mutate(elites[m]['param'])
                else:
                    c1 = random.randint(0, len(elites) - 1)
                    c2 = random.randint(0, len(elites) - 1)
                    child = self.crossover(elites[c1]['param'], elites[c2]['param'])
                pop.append({'param': child})

            # 次世代の生成
            fitness = self.evaluate(pop)
            pop = fitness[:]

            print pop[0]['score0'], pop[0]['score1'], pop[0]['param']

            
    def get_population(self):
        #要素のコストのリスト．昇順で90.5が1位の重量
        item_weight = (90.5,122,85.5,4,210,155,4,48,235,56,52.6,55.4,460,40.5,220,39.5,13,0.1,30,130,132.5,29,24.5,54,25,49.8,50.2,120,80,60,59,76.6,95,36.5,30,55,60,62,44.5,35,40,78.5,9.5,8.5,88.4,30,80,300,120,39,9,30,16.5,66.6,45,60,29.5,19.9,6,6.9,210,30,75.6,3.3,19,12,9.9,32,32,54,56.5,60,6.5,65.5,34.6,6.5,11.5,7.5,36,70.5,22.5,1.8,19,120,85.2,115,0.1,12.4,19.5,20,100,28,19.5,29.5,19.6,105,12.5,33.3,18.6,40,25,55,38,2.5,32.4,65,0.8,8.6,55,5.5,7,9,15.5,6.4,18.5,30,90,39,4,6,34.5,20,19.5,30,5.4,15,8.8,6.5,35,15,3.5,4.2,12,6.9,4,54.5,1,7.5,10.4,32,40.6,2,5.4,45.5,7.5,29.5,10,3.2,2.9,10,9.9)

        # value,weightを持つ辞書
        for i in xrange(N_ITEMS):
            self.items[i] = (abs(150-i), item_weight[i])  # value, weight #selfいらない？


        # Population 集団 個体の集まりの生成
        pop = []
        for i in range(N_POP):
            ind = [self.items[k] for k in random.sample(range(N_ITEMS), N_POKE)]
            pop.append(ind)

        return pop

    def clac_score(self, indivisual):
        dic = {}
        dic['score0'] = 0  # value
        dic['score1'] = 0  # weight
        for ind in indivisual:
            dic['score0'] += ind[0]
            dic['score1'] += ind[1]
        if dic['score1'] > 200:
            dic['score0'] = 0

        return dic

    def evaluate(self, pop):
        #評価
        #個体の適応度（fitness）を計算
        #スコアなし，パラメータあり，個体の評価を参照する．
        fitness = []
        for p in pop:
            if not p.has_key('score0'):
                if self.fitness_master.has_key(str(p['param'])):
                    p.update(self.fitness_master[str(p['param'])])
                else:
                    p.update(self.clac_score(p['param']))
                fitness.append(p)
            else:
                fitness.append(p)

        # 適応度の保存
        for fit in fitness:
            param = fit['param']
            self.fitness_master[str(param)] = {k: v for k, v in fit.items() if k!= 'param'}

        # 世代の適応度
        df = pd.DataFrame(fitness)
        df = df.sort_values(['score0', 'score1'], ascending=[False, True])

        fitness = df.to_dict('records')

        return fitness

    def mutate(self, parent):
        #突然変異
        ind_idx = int(math.floor(random.random() * len(parent)))
        item_idx = random.choice(range(N_ITEMS))
        child = copy.deepcopy(parent)
        child[ind_idx] = self.items[item_idx]

        return child

    def crossover(self, parent1, parent2):
        #2点交叉
        length = len(parent1)
        r1 = int(math.floor(random.random() * length))
        r2 = r1 + int(math.floor(random.random() * (length - r1)))

        child = copy.deepcopy(parent1)
        child[r1:r2] = parent2[r1:r2]

        return child


if __name__ == "__main__":
    GA().main()
