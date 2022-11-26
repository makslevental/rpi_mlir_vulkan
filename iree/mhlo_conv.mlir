func.func @conv_112_112_1x1_32x64() -> tensor<1x112x112x64xf32> {
    %input = util.unfoldable_constant dense<1.0> : tensor<1x112x112x32xf32>
    %filter = util.unfoldable_constant dense<1.0> : tensor<1x1x32x64xf32>
    %0 = "mhlo.convolution"(%input, %filter) {
        batch_group_count = 1 : i64,
        dimension_numbers = #mhlo.conv<raw
            input_batch_dimension = 0,
            input_feature_dimension = 3,
            input_spatial_dimensions = [1, 2],
            kernel_input_feature_dimension = 2,
            kernel_output_feature_dimension = 3,
            kernel_spatial_dimensions = [0, 1],
            output_batch_dimension = 0,
            output_feature_dimension = 3,
            output_spatial_dimensions = [1, 2]
        >,
        feature_group_count = 1 : i64,
        padding = dense<0> : tensor<2x2xi64>,
        rhs_dilation = dense<1> : tensor<2xi64>,
        window_strides = dense<1> : tensor<2xi64>
    } : (tensor<1x112x112x32xf32>, tensor<1x1x32x64xf32>) -> tensor<1x112x112x64xf32>
    return %0 : tensor<1x112x112x64xf32>
}
