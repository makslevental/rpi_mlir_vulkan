# MWE Vulkan+MLIR on RPi4

This repo shows how to use MLIR+Vulkan APIs on a Raspberry Pi 4 Model B. Minimum Vulkan driver version is 1.2 ([see here](https://www.geeks3d.com/hacklab/20220818/tested-raspberry-pi-4-and-vulkan-it-works/)).

# Building

## OS

I couldn't get this to work with Raspbian but did get it to work with Ubuntu (64bit, 22.04.1).

## Dependencies

```shell
sudo apt update
sudo apt upgrade

# Basics

sudo apt install wget ninja-build cmake clang llvm vim

# Vulkan deps

sudo apt install mesa-vulkan-drivers vulkan-tools libvulkan-dev libvulkan1
```

## Build

Run `./build.sh`; this will first download my latest build of `mlir` from [here](https://github.com/makslevental/llvm-releases/releases) and untar it.

# Running

Use `./run.sh` to run a $(4\times 4)\cdot(4\times 4)=(4\times 4)$ [matrix-multiplication](https://github.com/makslevental/rpi_mlir_vulkan/blob/main/mlir-vulkan-runner/mulf.mlir) on the GPU:

```shell
./build/mlir-vulkan-runner/mlir-vulkan-runner \
  mlir-vulkan-runner/mulf.mlir \
  --shared-libs="build/mlir-vulkan-runner/libvulkan-runtime-wrappers.so,llvm_install/lib/libmlir_c_runner_utils.so,llvm_install/lib/libmlir_runner_utils.so" \
  --entry-point-result=void
```

which should output

```
Compute shader execution time: 108us
Command buffer submit time: 121us
Wait idle time: 8us
Unranked Memref base@ = 0xaaaadaf7e630 rank = 2 offset = 0 sizes = [4, 4] strides = [4, 1] data = 
[[6,   6,   6,   6], 
 [6,   6,   6,   6], 
 [6,   6,   6,   6], 
 [6,   6,   6,   6]]
```

Note that if you get something like this (`WARNING: lavapipe` means software emulation):

```
WARNING: lavapipe is not a conformant vulkan implementation, testing use only.
Compute shader execution time: 9.82e+04us
Command buffer submit time: 6us
Wait idle time: 98482us
Unranked Memref base@ = 0xaaaadaf7e630 rank = 2 offset = 0 sizes = [4, 4] strides = [4, 1] data = 
[[6,   6,   6,   6], 
 [6,   6,   6,   6], 
 [6,   6,   6,   6], 
 [6,   6,   6,   6]]
```

then your drivers aren't driving; check `vulkaninfo` under `Presentable Surfaces`.

# Gotchas

If you get a segfault and after `lldb`ing you get

```shell
Opening /dev/dri/renderD128 failed: Permission denied
```

then you need to 

```shell
$ ls -l /dev/dri/renderD128
crw-rw----+ 1 root render 226, 128 Aug  9  2022 /dev/dri/renderD128
$ sudo usermod -aG render $(whoami)
```