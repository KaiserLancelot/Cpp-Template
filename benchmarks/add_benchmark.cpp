#include <benchmark/benchmark.h>

#include "klib/add.h"

namespace {

void add_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(klib::add(1, 2));
  }
}

}  // namespace

BENCHMARK(add_benchmark);
