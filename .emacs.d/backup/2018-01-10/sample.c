#define Ra 1.1      
#define lm 1.07e-05 
#define lL 1.85e-05
#define Dm 4.4e-05
#define Kt 0.05
#define Kv 0.06
#define e  1.0
#define K  15.0
#define dt 0.0001


double t, b1, b2, aLfa, beta, k1, k2, k3, k4, L1, L2, L3, L4, z, zv;
double x[2501], th[2501], thv[2501];
int i, n;
void zp1();

void main(void)
{
b1 = ( Kv + Ra*Dm/Kt) ;
b2 = (Ra / Kt )*( lm + lL) ;
aLfa = b1 /(2.0 * b2) ;
beta = (sqrt(4.0 * b2 * K - b1 * b1))/(2.0* b2);

z = 0.0 ;
zv = 0.0 ;
t = 0.0 ;

for ( t = 0 ; i <= 2500 ; i ++ ) {
t = t * dt ;

/* 角度のフィードバック制御(ラプラス変換による解) */
x[i] = (1.0 / K)*(1.0- exp(-aLfa * t)*( cos(beta * t) + (aLfa / beta) * sin(beta * t)));

/* ルンゲクッタ法による数値計算 */
k1 = dt * (zv);
k2 = dt * (zv + L1 / 2.0);
k3 = dt * (zv + L2 / 2.0);
k4 = dt * (zv + L3);

L1 = dt * (e -b1 * (zv           )-K * z             ) / b2 ;
L2 = dt * (e -b1 * (zv + L1 / 2.0)-K * (z + k1 / 2.0)) / b2 ;
L3 = dt * (e -b1 * (zv + L2 / 2.0)-K * (z + k2 / 2.0)) / b2 ;
L4 = dt * (e -b1 * (zv + L3      )-K * (z + k3      )) / b2 ;

z  = z  + ( k1 + 2.0* k2 + 2.0* k3 + k4) / 6.0 ;
zv = zv + ( L1 + 2.0* L2 + 2.0* L3 + L4) / 6.0 ;

th[i]  = z ;/* 角度rad */
thv[i] = zv;/* 角速度rad/s */

}
 zp1();
}

void zp1()
{
for (n=1; n<=25; n++){
i=n*100;
//printf("i=%4d     x[i]=%8.6f    th[i]=%8.6f \n",i,x[i],th[i]);
printf("%4d,%8.6f,%8.6f \n",i,x[i],th[i]);
}

}