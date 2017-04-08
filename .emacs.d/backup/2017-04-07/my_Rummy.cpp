#include <iostream>
#include <string>
using namespace std;
int T, card[16]//なぜ16

int main(void) {
  int yama[51], tmp[51];

  int n, r;
  while (cin >> n >> r, (n || r)) {
    // initialization
    for (int i=0; i<n; i++) {
      yama[i] = i + 1;
    }

    // shuffle
    for (int i=0; i<r; i++) {
      int p, c;
      cin >> p >> c;

      for (int j=0; j<c; j++) {
        tmp[c-1-j] = yama[n-p-j];
      }
      for (int j=n-p+1; j<n; j++) {
        yama[j-c] = yama[j];
      }
      for (int j=0; j<c; j++) {
        yama[n-c+j] = tmp[j];
      }
    }

    cout << yama[n-1] << endl;//
  }
  return 0;
}
/*


上記は配列の中身の上下が逆になっている．
これはreturnを見れば分かる．
  for (i = 1; i <= n; i++)
      deck[i] = n - i + 1;
とすれば，上下を逆転して，先頭を取ればよい，と言う形になる．
 int shuffle(int n, int r) {
      int i, deck[n+1], temp[n+1];
      for (i = 1; i <= n; i++)
          deck[i] = n - i + 1;
      while (r-- > 0) {
          int p, c;
          scanf("%d%d", &p, &c);
          for (i = 1; i < p; i++)
              temp[i] = deck[i];
          for (i = p; i < p + c; i++)
              deck[i-p+1] = deck[i];
          for (i = 1; i < p; i++)
              deck[i + c] = temp[i];
     }
      return deck[1];
 }
 */

