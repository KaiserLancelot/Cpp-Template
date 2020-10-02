/// \file bar.h
/// \brief Contains the declaration of the function b

#pragma once

#include <cstdint>

namespace klib {

/// test struct bar
class Bar {
 public:
  /// Default constructor
  Bar() = default;

  /// \brief A constructor
  /// \param val Used to initialize members
  explicit Bar(std::int32_t val);

  /// \brief A member fun
  /// \return return val
  std::int32_t get_val() const;

 private:
  std::int32_t val_{};
};

}  // namespace klib
