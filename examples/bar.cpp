#include <iostream>

#include <klib/bar.h>

int main() { std::cout << klib::Bar{42}.get_val() << '\n'; }
