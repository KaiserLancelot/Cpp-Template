#include <gtest/gtest.h>

#include "klib/add.h"

TEST(AddTest, test1) { ASSERT_EQ(klib::add(1, 2), 3); }

TEST(AddTest, test2) { ASSERT_EQ(klib::add(5, 3), 8); }
