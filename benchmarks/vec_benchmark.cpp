#include <cstdint>
#include <string>
#include <vector>

#include <benchmark/benchmark.h>

#include "klib/vec.h"

void vec_base_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    std::vector<std::string> v;
    for (std::int32_t i{0}; i < 100000; ++i) {
      v.push_back("string");
    }
    benchmark::DoNotOptimize(v);
  }
}

BENCHMARK(vec_base_benchmark);

void vec_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    Vec<std::string> v;
    for (std::int32_t i{0}; i < 100000; ++i) {
      v.PushBack("string");
    }
    benchmark::DoNotOptimize(v);
  }
}

BENCHMARK(vec_benchmark);
