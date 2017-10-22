#include <algorithm>
#include <cassert>
#include <cstdio>

using namespace std;

const int bits = 3;
const int M = 1 << bits;

int counts[M][bits+1];

int lastzeros(int x) {
  if (x == 0) return bits;
  int r = 0;
  while ((x&1)==0) { ++r; x>>=1; }
  return r;
}

int main() {
  for (int m = 1; m < (1<<M); ++m) {
    int bc = 0;
    int mb = 0;
    for (int i = 0; i < M; ++i) if ((m>>i)&1) {
      ++bc;
      mb = max(mb, lastzeros(i));
    }
    assert (bc>0);
    assert (0<=mb);
    assert (mb<=bits);
    ++counts[bc-1][mb];
  }
  printf("<table>\n");
  printf("<tr>\n");
  printf("  <th>$k$</th>");
  for (int j=0;j<=bits;++j) printf("  <th>%d</th>\n",j);
  printf("</tr>\n");
  for (int k = 1; k <= M; ++k) {
    int total = 0; for (int j=0;j<=bits;++j) total+=counts[k-1][j];
    printf("<tr>\n");
    printf("  <td>%d</td>\n", k);
    for (int j=0;j<=bits;++j)
      printf("  <td>%.2f</td>\n",1.*counts[k-1][j]/total);
  printf("</tr>\n");
  }
  printf("</table>\n");
}
