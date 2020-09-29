#include <benchmark/benchmark.h>

#include "lib.h"

void test(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(add(1, 2));
  }
}

BENCHMARK(test);

void test2(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
  }
}

BENCHMARK(test2);

void test3(benchmark::State& state) {
  for (auto _ : state) {
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
    benchmark::DoNotOptimize(add(1, 2));
  }
}

BENCHMARK(test3);

BENCHMARK_MAIN();
