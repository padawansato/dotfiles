#include <iostream>
#include <algorithm>
using namespace std;
int a,b,c;
int main(){
  cin >> a >> b >> c;
  if (a-b == b-c){
    cout << "YES" << endl;
  }
  else
    cout << "NO" << endl;
}
