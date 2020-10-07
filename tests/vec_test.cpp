#include <gtest/gtest.h>

#include "klib/vec.h"

TEST(VecTest, test1) {
  Vec<std::int32_t> v{1, 2, 3, 4, 5};
  v.PushBack(3);
  ASSERT_EQ(*v.begin(), 1);
}
