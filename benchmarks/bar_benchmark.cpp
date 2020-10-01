#include <benchmark/benchmark.h>

#include "klib/bar.h"

void bar_benchmark(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(klib::Bar{42}.get_val());
  }
}

BENCHMARK(bar_benchmark);
