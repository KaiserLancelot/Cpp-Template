/**
 * @file bar.h
 * @brief Contains the declaration of the class Bar
 */

#pragma once

#include <cstdint>

namespace klib {

/**
 * @brief A test struct
 */
class Bar {
 public:
  /**
   * @brief Default Constructor
   */
  Bar() = default;

  /**
   * @brief Construct a new Bar object
   * @param val Used to initialize members
   */
  explicit Bar(std::int32_t val);

  /**
   * @brief Get the val object
   * @return Return val
   */
  [[nodiscard]] std::int32_t get_val() const;

 private:
  std::int32_t val_{};
};

}  // namespace klib
