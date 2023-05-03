#include <CL/sycl.hpp>
#include <chrono>
#include <random>
#include <vector>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <numeric>

#define MAX_THREADS 8
constexpr size_t META_REPS = 31;
constexpr size_t WARMUP_REPS = 1000;
constexpr size_t REPS = 1000;

namespace stats {
    auto mean(const std::vector<double> &samples) -> std::chrono::duration<double, std::micro>{
      double mean = std::reduce(samples.begin(), samples.end(), 0.0) / samples.size();
        return std::chrono::duration<double, std::micro>(mean);
    }
} // namespace stats

template <typename T = float>
auto vector_rand_init(size_t len) -> std::vector<T> {
    std::mt19937 rng(0);
    std::uniform_real_distribution<T> distrib(0.0, 1.0);

    std::vector<T> self(len);
    for (size_t i = 0; i < self.capacity(); ++i) {
        self[i] = distrib(rng);
    }

    return self;
}

int
main (int argc, char **argv)
{
  const size_t len = std::atoi(argv[1]);
  std::vector<float> x = vector_rand_init(len);
  std::vector<float> y = vector_rand_init(len);
  const float alpha = 1.0;
  size_t n = len;
  sycl::queue q (sycl::cpu_selector{});

  auto sx = sycl::malloc_shared<float>(n, q);
  auto sy = sycl::malloc_shared<float>(n, q);
  for (size_t i = 0; i < n; ++i) {
      sx[i] = x[i];
      sy[i] = y[i];
  }


  std::vector<double> samples(atoi(argv[1]));
  std::chrono::high_resolution_clock::time_point start, end;
  try {
  for (size_t j = 0; j < atoi(argv[1]); ++j) {
      q.parallel_for (sycl::nd_range<1> (MAX_THREADS, 8),
                    [=] (sycl::id<1> i) { sy[i] += 0.5 * sx[i]; });
    end = std::chrono::high_resolution_clock::now();
    samples[j] = ((end - start).count()) / (double)(REPS);
    }
    q.wait ();
  }
  catch (sycl::exception &e) {
    std::cerr << e.what () << std::endl;
    std::terminate ();
  }
  auto mean = stats::mean(samples);
  std::cout << "Average: " << mean.count() << std::endl;

  sycl::free(sx, q);
  sycl::free(sy, q);

  return 0;
}
