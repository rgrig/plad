import java.util.*;

// TODO: Print *which* coins could be used.
public class CoinChange {
  public static void main(String[] args) {
    Scanner scan = new Scanner(System.in);
    int n = scan.nextInt();
    ds = new ArrayList<>();
    while (scan.hasNextInt()) {
      ds.add(scan.nextInt());
    }
    int m = ds.size();

    if (false) {
      System.out.printf("%d\n", solve(m, n));
    } else {

      int[][] C = new int[m + 1][]; // TODO: Consider using array of option of integer

      // handle i = 0
      C[0] = new int[n + 1];
      C[0][0] = 0;
      for (int j = 1; j <= n; ++j) C[0][j] = Integer.MAX_VALUE;

      // handle i > 1
      for (int i = 1; i <= m; ++i) {
        C[i] = new int[n + 1];
        for (int j = 0; j <= n; ++j) {
          C[i][j] = C[i-1][j];
          if (j - ds.get(i-1) >= 0 && C[i][j-ds.get(i-1)] < Integer.MAX_VALUE) {
            C[i][j] = Math.min(C[i][j], 1 + C[i][j-ds.get(i-1)]);
          }
        }
      }

      System.out.printf("%d\n", C[m][n]);
    }
  }

  static ArrayList<Integer> ds;

  static int solve(int m, int n) {
    if (m < 0) return Integer.MAX_VALUE;
    if (m == 0 && n == 0) return 0;
    if (m == 0 && n > 0) return Integer.MAX_VALUE;
    if (n < 0) return Integer.MAX_VALUE;
    int a = solve(m-1, n);
    int b = solve(m,n-ds.get(m-1));
    if (b == Integer.MAX_VALUE) return a;
    return Math.min(a, 1 + b);
  }
}
