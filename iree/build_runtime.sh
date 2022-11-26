cmake -GNinja -B ../iree-build/ -S . \
    -DCMAKE_BUILD_TYPE=RelWithDebInfo \
    -DIREE_ENABLE_ASSERTIONS=ON \
    -DIREE_BUILD_COMPILER=OFF \
    -DIREE_ENABLE_CPUINFO=OFF \
    -DIREE_BUILD_SAMPLES=OFF \
    -DIREE_BUILD_TESTS=OFF \
    -DCMAKE_C_COMPILER=clang \
    -DCMAKE_CXX_COMPILER=clang++ \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DIREE_HAL_DRIVER_VULKAN=ON \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache 
