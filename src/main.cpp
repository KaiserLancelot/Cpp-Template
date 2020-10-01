#include <iostream>

#include "klib/add.h"
#include "klib/bar.h"

int main() {
  std::cout << klib::add(1, 2) << '\n';
  std::cout << klib::Bar{42}.get_val() << '\n';
}
