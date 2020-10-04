/**
 * @file add.h
 * @brief Contains the declaration of the function add
 */

#pragma once

#include <cstdint>

namespace klib {

/**
 * @brief Adding two numbers
 * @param lhs Number on the left hand side
 * @param rhs Number on the left hand side
 * @return The result of adding two numbers
 */
std::int32_t add(std::int32_t lhs, std::int32_t rhs);

}  // namespace klib
