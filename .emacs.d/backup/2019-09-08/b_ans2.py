n = int(input())
a = list(map(int, input().split()))
cnt = 0
while all(i%2 == 0 for i in a):	#all()はすべてiterがtrueならtrueを返す
  a = [i/2 for i in a]			#式"i%2==0"を評価するとbool型が帰る
  cnt += 1
  
print(cnt)
