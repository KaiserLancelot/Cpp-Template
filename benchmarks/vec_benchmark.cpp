#include <cstdint>
#include <string>
#include <vector>

#include <benchmark/benchmark.h>

#include "klib/vec.h"

namespace {

void vec_base_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    std::vector<std::string> v;
    for (std::int32_t i{0}; i < 100000; ++i) {
      v.push_back("string");
    }
    benchmark::DoNotOptimize(v);
  }
}

void vec_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    klib::Vec<std::string> v;
    for (std::int32_t i{0}; i < 100000; ++i) {
      v.push_back("string");
    }
    benchmark::DoNotOptimize(v);
  }
}

}  // namespace

BENCHMARK(vec_base_benchmark);
BENCHMARK(vec_benchmark);
