#include <gtest/gtest.h>

#include "klib/bar.h"

TEST(BarTest, test1) {
  klib::Bar bar;
  ASSERT_EQ(bar.get_val(), 0);
}

TEST(BarTest, test2) {
  klib::Bar bar{42};
  ASSERT_EQ(bar.get_val(), 42);
}
