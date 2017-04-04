using namespace std;
#include <vector>

// // int N = hoge;
// // vedtor<int> A{N, 0};
// #include <array>
// using namespace std;
// array<int, 50> A = {};

// for (auto e:A) cout << e << endl;

vector<int> A(50);
for (size_t i=0; i<A.size(); ++i)
  cout << A[i] << endl;
for (vector<int>::const_iterator p=0; p!=A.end();++p)
  cout << *p << endl;
fputc(
