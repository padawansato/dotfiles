N = int(input())
A = [int(i) for i in input().split()]
ans = [0]*N
for i in range(N):
    while A[i] % 2 == 0:
        A[i] // = 2
        ans[i] += 1
print(min(ans))
