
((digest . "1b14156343fb1b2336898e057d62abac") (undo-list nil (596 . 598) nil ("世代" . -596) ((marker . 598) . -2) (596 . 598) ("せだい" . -596) ((marker . 598) . -3) (596 . 599) ("せだ" . -596) ((marker . 598) . -2) (596 . 598) ("せｄ" . -596) ((marker . 598) . -2) (596 . 598) ("せ" . -596) ((marker . 598) . -1) (596 . 597) ("ｓ" . -596) ((marker . 598) . -1) (596 . 597) ("n" . 596) ("o" . 596) ("i" . 596) ("t" . 596) ("a" . 596) ("r" . 596) ("e" . 596) ("n" . 596) ("e" . 596) ("G" . 596) nil (357 . 359) nil ("世代" . -357) ((marker . 598) . -2) (357 . 359) ("せだい" . -357) ((marker . 598) . -3) (357 . 360) ("せだ" . -357) ((marker . 598) . -2) (357 . 359) ("せｄ" . -357) ((marker . 598) . -2) (357 . 359) ("せ" . -357) ((marker . 598) . -1) (357 . 358) ("ｓ" . -357) ((marker . 598) . -1) (357 . 358) ("G" . -357) ((marker . 598) . -1) ("e" . -358) ((marker . 598) . -1) ("n" . -359) ((marker . 598) . -1) ("e" . -360) ((marker . 598) . -1) ("r" . -361) ((marker . 598) . -1) ("a" . -362) ((marker . 598) . -1) ("t" . -363) ((marker . 598) . -1) ("i" . -364) ((marker . 598) . -1) ("o" . -365) ((marker . 598) . -1) ("n" . -366) ((marker . 598) . -1) 367 (t 22900 27986 0 0) nil (3460 . 3464) nil ("F" . -3460) ((marker . 598) . -1) ("a" . -3461) ((marker . 598) . -1) ("l" . -3462) ((marker . 598) . -1) ("s" . -3463) ((marker . 598) . -1) ("e" . -3464) ((marker . 598) . -1) 3465 (t 22900 27937 0 0) nil (3460 . 3465) nil ("T" . -3460) ((marker . 598) . -1) ("r" . -3461) ((marker . 598) . -1) ("u" . -3462) ((marker . 598) . -1) ("e" . -3463) ((marker . 598) . -1) 3464 (t 22900 25751 0 0) nil (197 . 198) nil ("5" . -197) ((marker . 928) . -1) 198 nil (174 . 175) nil ("2" . -174) ((marker . 928) . -1) 175 nil (150 . 153) nil ("1" . -150) ((marker . 928) . -1) 151 nil (150 . 151) nil ("2" . -150) ((marker . 928) . -1) ("0" . -151) ((marker . 928) . -1) 152 nil (152 . 153) nil ("0" . -152) ((marker . 928) . -1) 153 (t 22900 25692 0 0) nil (150 . 153) (t 22900 25685 0 0) nil (170 . 171) nil ("5" . -170) ((marker . 928) . -1) 171 (t 22900 25681 0 0) nil (170 . 171) nil ("1" . -170) ((marker . 928) . -1) 171 nil ("4" . -149) ((marker . 928) . -1) ("0" . -150) ((marker . 928) . -1) ("0" . -151) ((marker . 928) . -1) ("0" . -152) ((marker . 928) . -1) 153 (t 22900 25648 0 0) nil (149 . 153) nil ("1" . -149) ((marker . 928) . -1) ("0" . -150) ((marker . 928) . -1) ("0" . -151) ((marker . 928) . -1) ("0" . -152) ((marker . 928) . -1) ("0" . -153) ((marker . 928) . -1) 154 (t 22900 25616 0 0) nil (153 . 154) (t 22900 25600 0 0) nil (152 . 153) (t 22900 25578 0 0) nil (150 . 152) nil ("9" . -150) ((marker . 928) . -1) 151 nil (149 . 151) nil ("2" . -149) ((marker . 928) . -1) ("0" . -150) ((marker . 928) . -1) ("0" . -151) ((marker . 928) . -1) 152 (t 22900 19162 0 0) nil (125 . 126) nil ("9" . -125) ((marker . 928) . -1) 126 nil (124 . 126) nil ("5" . -124) ((marker . 928) . -1) ("0" . -125) ((marker . 928) . -1) 126 (t 22900 19119 0 0) nil (1405 . 1406) nil (1246 . 1247) nil ("            
" . 1246) nil (633 . 634) nil ("            
" . 633) nil (" " . -373) ((marker . 928) . -1) 374 nil (" " . -340) ((marker . 928) . -1) 341 nil (321 . 1430) nil ("    def main(self):
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

" . 321) ((marker . 3713) . -996) ((marker) . -996) ((marker . 3713) . -996) (t 22900 19067 0 0) nil (1317 . 1318) nil ("            
" . 1317) (t 22900 18161 0 0) nil undo-tree-canary))
