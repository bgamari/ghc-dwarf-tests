#include <stdio.h>

void ffi_test(int n, void(*fun)(int n)) {
  printf("in foreign %d\n", n);
  fun(n);
  printf("leaving foreign %d\n", n);
}
