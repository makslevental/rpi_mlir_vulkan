LD_LIBRARY_PATH=/usr/local/lib /home/pi/iree-build/tools/iree-run-module \
    --device=vulkan://2ed13185-e77c-e2ea-cfd5-078818d4e3e5 \
    --module_file=mhlo_conv.vmfb \
    --entry_function=conv_112_112_1x1_32x64 \
    --vulkan_debug_verbosity=4 \
    --trace_execution=false \
    --print_statistics=true

    #--function_input="1x224x224x3xf32=0"
