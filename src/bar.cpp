#include "klib/bar.h"

namespace klib {

Bar::Bar(std::int32_t val) : val_{val} {}

std::int32_t Bar::get_val() const { return val_; }

}  // namespace klib
