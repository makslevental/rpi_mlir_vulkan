#!/bin/bash

set -e -x

./build/mlir-vulkan-runner/mlir-vulkan-runner \
  $PWD/mlir-vulkan-runner/mulf.mlir \
  --shared-libs="$PWD/build/mlir-vulkan-runner/libvulkan-runtime-wrappers.so,$PWD/llvm_install/lib/libmlir_c_runner_utils.so,$PWD/llvm_install/lib/libmlir_runner_utils.so" \
  --entry-point-result=void 
