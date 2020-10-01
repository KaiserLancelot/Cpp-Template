#include <benchmark/benchmark.h>

#include "klib/add.h"

void add_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(klib::add(1, 2));
  }
}

BENCHMARK(add_benchmark);
