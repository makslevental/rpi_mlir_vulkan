iree-compile \
    --iree-hal-target-backends=vulkan-spirv \
    --iree-vulkan-target-triple=rdna1-5700xt-linux \
    --iree-input-type=mhlo \
    mhlo_conv.mlir -o mhlo_conv.vmfb
