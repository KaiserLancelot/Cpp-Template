#include <cstdint>
#include <iostream>

#include <klib/vec.h>

int main() { std::cout << *klib::Vec<std::int32_t>{42}.begin() << '\n'; }
