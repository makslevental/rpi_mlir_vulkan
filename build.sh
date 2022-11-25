#!/bin/bash

set -e -x


if [ ! -d "$PWD/llvm_install" ]; then
  wget https://github.com/makslevental/llvm-releases/releases/latest/download/llvm+mlir+python-3.10-15.0.4-arm64-linux-gnu-ubuntu-20.04-release.tar.xz
  tar -xvf llvm+mlir+python-3.10-15.0.4-arm64-linux-gnu-ubuntu-20.04-release.tar.xz
fi

cmake -GNinja -B build -S . \
    -DCMAKE_PREFIX_PATH="$PWD/llvm_install" \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DMLIR_ENABLE_SPIRV_CPU_RUNNER=True \
    -DMLIR_ENABLE_VULKAN_RUNNER=True \
    -DLLVM_BUILD_TOOLS=ON \
    -DLLVM_INCLUDE_TOOLS=ON

cd build
ninja
