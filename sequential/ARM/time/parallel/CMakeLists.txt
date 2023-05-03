cmake_minimum_required(VERSION 3.12...3.24)

project(sycl
    VERSION 0.1.0
    DESCRIPTION "Evaluation of Sycl parallelism"
    LANGUAGES CXX)

find_package(IntelDPCPP REQUIRED)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(sycl sycl.cpp)
target_compile_features(sycl PUBLIC cxx_std_17)
