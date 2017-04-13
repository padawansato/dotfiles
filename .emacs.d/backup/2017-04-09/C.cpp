#include <iostream>

using namespace std;
int main(){
  int e;
  while (cin >> N && N>0){
    int sum = 0;
    for (int i=0; i < N; ++i){
      cin >> S;
      sum += S;
	}
    cout << sum << endl;
  }
  while (cint >> N && N>0){
    int max = 0;
    for (int i=0, i < N; ++i){
      cin >> S;
      if(max < S) max = S;
    }
    cout << "S"<< S << endl;
  }
}
