#include <cstdint>
#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>

#include "klib/add.h"
#include "klib/bar.h"

int main() {
  std::vector<std::int32_t> v;
  v.push_back(1);
  v.push_back(2);
  v.push_back(3);

  std::string str{"Hello World!"};

  std::unordered_map<std::int32_t, std::string> map;
  map.emplace(1, "a");
  map.emplace(2, "b");
  map.emplace(3, "c");

  std::cout << klib::add(1, 2) << '\n';
  std::cout << klib::Bar{42}.get_val() << '\n';
}
