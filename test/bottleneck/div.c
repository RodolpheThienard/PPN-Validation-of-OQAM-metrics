#include <stdio.h>
#include <stdlib.h>

// version with direct division that produce bottlenecks
double divide(int n) {
  double tmp = 1.0 / 3.0;
  for (int i = 1; i < n; i++) {
    tmp += tmp / n + n - i;
  }
  return tmp;
}

// version following the suggestions of MAQAO to replace
// the division by a constant
double divide_inv(int n) {
  double tmp = 1.0 / 3.0;
  double n_inv = 1.0 / (double)n;
  for (int i = 1; i < n; i++) {
    tmp += tmp * n_inv + n - i;
  }
  return tmp;
}

int main(int argc, char **argv) {
  int n = 100000;
  for (int i = 0; i < 10000; i++)
    divide(n);
  for (int i = 0; i < 10000; i++)
    divide_inv(n);
  printf("initial result:           %16f\nconst denominateur result:%16f\n",
         divide(n), divide_inv(n));
  return 0;
}
