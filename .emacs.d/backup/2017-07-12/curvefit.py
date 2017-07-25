import numpy as np
from matplotlib import pyplot as plt
 
x = np.array([0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19])
y = np.array([-1,-3,-1,9,21,30,37,39,67,65,95,123,142,173,191,216,256,292,328,358])
 
# y は次の式で生成
# y = np.round(x**2 + np.random.randn(20) * 5)
#
 
plt.scatter(x , y)

# func = np.poly1d(np.polyfit(x, y, 1))
# np.poly1d(np.polyfit(x, y, 1))(x)
# plt.plot(x, np.poly1d(np.polyfit(x, y, 1))(x), label='d=1')
# plt.show()


from scipy import optimize
 
def func1(param,x,y):
    residual = y - (param[0]*x + param[1])
    return residual
 
param1 = [0, 0]
optimize.leastsq(func1, param1, args=(x, y))
print(optimize.leastsq(func1, param1, args=(x, y)))
