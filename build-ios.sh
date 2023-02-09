#!/bin/bash
python onnxruntime/tools/ci_build/build.py \
  --build_dir onnxruntime/build/iOS_arm64 \
  --config=MinSizeRel \
  --use_xcode \
  --parallel \
  --minimal_build \
  --ios \
  --use_xcode \
  --build_apple_framework \
  --ios_sysroot iphoneos \
  --osx_arch arm64 \
  --apple_deploy_target="14.0" \
  --disable_ml_ops --disable_exceptions --disable_rtti \
  --include_ops_by_config model.required_operators_and_types.config \
  --enable_reduced_operator_type_support \
  --skip_tests

mkdir -p libs/ios-arm64

libtool -static -o libs/ios-arm64/onnxruntime.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnx.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_graph.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnx_proto.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_mlas.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_optimizer.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_providers.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_common.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_session.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_flatbuffers.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_framework.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libonnxruntime_util.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libre2.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libnsync_cpp.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libprotobuf-lite.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_hash.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_city.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_low_level_hash.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_throw_delegate.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_raw_hash_set.a \
./onnxruntime/build/iOS_arm64/MinSizeRel/static_libraries/libabsl_raw_logging_internal.a
