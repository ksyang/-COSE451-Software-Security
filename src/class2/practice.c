#include <stdio.h>

int main(void){
  char buf[40];
  read(0, buf, 41);
  printf("%s\n", buf);
  printf("%p\n", &buf);
  read(0, buf, 80);
  return 0;
}
