cmake_minimum_required(VERSION 3.21...3.24)

set(CMAKE_POLICY_DEFAULT_CMP0116 OLD)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(MYIREE ASM C CXX)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to" FORCE)

message(STATUS ${LLVM_MAIN_SRC_DIR})
find_package(LLVM REQUIRED CONFIG)
find_package(MLIR REQUIRED CONFIG)
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")

include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)
include(MLIRDetectPythonEnv)
include(AddMLIRPython)
include(TableGen)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
link_directories(${LLVM_BUILD_LIBRARY_DIR})
add_definitions(${LLVM_DEFINITIONS})

add_subdirectory(mlir-vulkan-runner)
add_subdirectory(mlir-spirv-cpu-runner)
add_subdirectory(mlir-spirv-cpu-runner-tests)
