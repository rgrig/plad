import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class CountDistinct {
  public static void main(String[] args) {
    int n = 10; // number of estimates
    int b = 2; // size of bunch
    if (args.length >= 1) n = Integer.parseInt(args[0]); assert (n>=1);
    if (args.length >= 2) b = Integer.parseInt(args[1]); assert (b>=1);
    int a[] = new int[n];
    int r[] = new int[n];
    Random rand = new Random(123);
    for (int i = 0; i < n; ++i) a[i] = rand.nextInt();
    Scanner scan = new Scanner(System.in);
    while (scan.hasNext()) {
      int x = (int)scan.nextLong();
      for (int i = 0; i < n; ++i) r[i] = Math.max(r[i], rho(x+a[i]));
    }
    int m = (n + b - 1) / b;
    double avg[] = new double[m];
    for (int i = 0; i < n; ++i) avg[i/b] += Math.pow(2, r[i]);
    for (int j = 0; j < m; ++j) avg[j] /= b;
    Arrays.sort(avg);
    double e = (m % 2 == 1)? avg[m/2] : (avg[m/2]+avg[m/2-1])/2.0;
    System.out.printf("%.0f\n", e);
  }

  static int rho(int x) {
    if (x == 0) return 32;
    int r = 0;
    while (x % 2 == 0) { ++r; x >>= 1; }
    return r;
  }
}
