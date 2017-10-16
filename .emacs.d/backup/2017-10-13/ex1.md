# 1 "ex1.c"
# 1 "<built-in>" 1
# 1 "<built-in>" 3
# 330 "<built-in>" 3
# 1 "<command line>" 1
# 1 "<built-in>" 2
# 1 "ex1.c" 2
extern int printf(char *,...);

int f(int a, int b) {
return a + b;
}
int main()
{
int a = 1;
int b = 2;
printf("%x = %x + %x \n",f(a,b),a,b);
return 0;
}
