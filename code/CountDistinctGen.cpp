// g++ -std=c++11 -O3 CountDistinctGen.cpp -o CountDistinctGen
#include <cassert>
#include <cinttypes>
#include <cstdint>
#include <cstdio>
#include <random>

using namespace std;

int m = 10; // number of distinct IPs
int64_t n = 100; // length of stream
int seed = 123;

typedef uint32_t ip_t;
minstd_rand0 G;

int main(int argc, char * argv[]) {
  if (argc >= 2) sscanf(argv[1],"%d",&m); assert (m>0);
  if (argc >= 3) sscanf(argv[2],"%" SCNd64,&n);
  if (argc >= 4) sscanf(argv[3],"%d",&seed);
  G.seed(seed);
  uniform_int_distribution<ip_t> genip;
  vector<ip_t> ips(m);
  int i, j;
  for (j=0;j<m;++j) {
    do {
      ips[j] = genip(G);
      for (i=0;i<j&&ips[i]!=ips[j];++i);
    } while (i<j);
  }
  uniform_int_distribution<int> genidx(0,m-1);
  while (n-- > 0) {
    printf("%" PRIu32 "\n", ips[genidx(G)]);
  }
}
