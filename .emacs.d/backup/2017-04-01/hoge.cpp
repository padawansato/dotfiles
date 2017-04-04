#include <iostream>
#include <algorithm>
using namespace std;
int A[5] = {3,5,1,2,4};
int main(){
  sort(A,A+5);
  reverse(A,A+5);
  //  cout << A;
  for (int i=0; i<5; i++)
  //  printf("%d\n", A[i]);
  cout << A[i] << endl;
}
















// int main(){
//   int e;
//   while (cin >> N && N>0){
//     int sum = 0;
//     for (int i=0; i < N; ++i){
//       cin >> S;
//       sum += S;
// 	}
//     cout << sum << endl;
//   }
//   while (cint >> N && N>0){
//     int max = 0;
//     for (int i=0, i < N; ++i){
//       cin >> S;
//       if(max < S) max = S;
//     }
//     cout << "S"<< S << endl;
//   }
// }
