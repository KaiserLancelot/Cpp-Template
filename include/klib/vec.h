/**
 * @file vec.h
 * @brief A container
 */

#pragma once

#include <cstddef>
#include <initializer_list>
#include <memory>
#include <string>
#include <utility>

namespace klib {

template <typename T>
class Vec {
 public:
  using SizeType = std::size_t;
  Vec() = default;
  Vec(std::initializer_list<T> il);
  Vec(const Vec& item);
  Vec& operator=(const Vec& item);
  ~Vec() { free(); }
  void push_back(const T& s);
  SizeType size() const { return static_cast<SizeType>(end_ - begin_); }
  SizeType capacity() const { return static_cast<SizeType>(cap_ - begin_); }
  T* begin() const { return begin_; }
  T* end() const { return end_; }
  void reserve(SizeType new_cap);
  void resize(SizeType new_size);
  void resize(SizeType new_size, const T& value);

 private:
  void check_alloc();
  std::pair<T*, T*> alloc_copy(const T* begin, const T* end);
  void free();
  void reallocate(SizeType new_cap);

  T* begin_{};
  T* end_{};
  T* cap_{};

  std::allocator<T> alloc_;
};

template <typename T>
Vec<T>::Vec(std::initializer_list<T> il) {
  auto data{alloc_copy(std::begin(il), std::end(il))};
  begin_ = data.first;
  end_ = cap_ = data.second;
}

template <typename T>
Vec<T>::Vec(const Vec& item) {
  auto data{alloc_copy(std::begin(item), std::end(item))};
  begin_ = data.first;
  end_ = cap_ = data.second;
}

template <typename T>
Vec<T>& Vec<T>::operator=(const Vec& item) {
  auto data{alloc_copy(std::begin(item), std::end(item))};
  free();
  begin_ = data.first;
  end_ = cap_ = data.second;
  return *this;
}

template <typename T>
void Vec<T>::push_back(const T& s) {
  check_alloc();
  std::allocator_traits<decltype(alloc_)>::construct(alloc_, end_++, s);
}

template <typename T>
void Vec<T>::reserve(Vec::SizeType new_cap) {
  if (new_cap > capacity()) {
    reallocate(new_cap);
  }
}

template <typename T>
void Vec<T>::resize(Vec::SizeType new_size) {
  resize(new_size, T{});
}

template <typename T>
void Vec<T>::resize(Vec::SizeType new_size, const T& value) {
  if (new_size < size()) {
    std::destroy(begin_ + new_size, end_);
    end_ = begin_ + new_size;
  } else if (new_size > size()) {
    while (new_size > size()) {
      push_back(value);
    }
  }
}

template <typename T>
void Vec<T>::check_alloc() {
  if (size() == capacity()) {
    reallocate(capacity() ? 2 * capacity() : 1);
  }
}

template <typename T>
std::pair<T*, T*> Vec<T>::alloc_copy(const T* begin, const T* end) {
  auto data{alloc_.allocate(static_cast<std::size_t>(end - begin))};
  return {data, std::uninitialized_copy(begin, end, data)};
}

template <typename T>
void Vec<T>::free() {
  if (begin_) {
    std::destroy(begin_, end_);
    alloc_.deallocate(begin_, capacity());
  }
}

template <typename T>
void Vec<T>::reallocate(Vec::SizeType new_cap) {
  auto new_begin{alloc_.allocate(new_cap)};
  auto new_end{std::uninitialized_move(begin_, end_, new_begin)};
  free();
  begin_ = new_begin;
  end_ = new_end;
  cap_ = begin_ + new_cap;
}

}  // namespace klib
