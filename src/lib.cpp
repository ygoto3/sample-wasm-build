#include "lib.hpp"
#include <iostream>

int add(int a, int b) {
  std::ios_base::Init init;
  auto ret = a + b;
  std::cout << a << " + " << b << " = " << ret << std::endl;
  return ret;
}
