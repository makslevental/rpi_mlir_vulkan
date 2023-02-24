#!/bin/bash

set -e -x

ARCH="$(uname -m)"
PLATFORM="$(uname)"
ROOT_URL="https://github.com/makslevental/llvm-releases/releases/download/llvm-17.0.0"

if [ x"$ARCH" == x"arm64" ] && [ x"$PLATFORM" == x"Darwin" ]; then
  TAR_FILE="llvm+mlir+openmp-3.11-17.0.0-arm64-apple-darwin-release.tar.xz"
elif [ x"$PLATFORM" == x"Linux" ]; then
  sudo apt install mesa-vulkan-drivers vulkan-tools libvulkan-dev libvulkan1
  if [ x"$ARCH" == x"aarch64" ]; then
    TAR_FILE="llvm+mlir+openmp-3.11-17.0.0-arm64-linux-gnu-ubuntu-20.04-release.tar.xz"
  elif [ x"$ARCH" == x"x86_64" ]; then
    TAR_FILE="llvm+mlir+openmp-3.11-17.0.0-x86_64-linux-gnu-ubuntu-20.04-release.tar.xz"
  fi
fi

wget "$ROOT_URL/$TAR_FILE"
tar -xvf "$TAR_FILE"

cmake -GNinja -B build -S . \
  -DCMAKE_PREFIX_PATH="$PWD/llvm_install" \
  -DCMAKE_INSTALL_PREFIX="$PWD/runner_install" \
  -DCMAKE_BUILD_TYPE=Release \
  -DMLIR_ENABLE_SPIRV_CPU_RUNNER=ON \
  -DMLIR_ENABLE_VULKAN_RUNNER=ON \
  -DLLVM_BUILD_TOOLS=ON

cd build
ninja install
