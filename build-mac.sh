#!/usr/bin/env bash
set -e
python onnxruntime/tools/ci_build/build.py \
--build_dir onnxruntime/build/macOS_x86_64 \
--config=MinSizeRel \
--parallel \
--minimal_build \
--apple_deploy_target="10.13" \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--cmake_extra_defines CMAKE_OSX_ARCHITECTURES=x86_64 \
--skip_tests

python onnxruntime/tools/ci_build/build.py \
--build_dir onnxruntime/build/macOS_arm64 \
--config=MinSizeRel \
--parallel \
--minimal_build \
--apple_deploy_target="10.14" \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--cmake_extra_defines CMAKE_OSX_ARCHITECTURES=arm64 \
--skip_tests

libtool -static -o onnxruntime-macOS_x86_64-static-combined.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnx.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_graph.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnx_proto.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_mlas.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnx_test_data_proto.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_optimizer.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnx_test_runner_common.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_providers.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_common.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_session.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_flatbuffers.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_test_utils.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_framework.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/libonnxruntime_util.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/re2-build/libre2.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/google_nsync-build/libnsync_cpp.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/protobuf-build/libprotobuf-lite.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_city.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a \
./onnxruntime/build/macOS_x86_64/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a

libtool -static -o onnxruntime-macOS_arm64-static-combined.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnx.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_graph.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnx_proto.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_mlas.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnx_test_data_proto.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_optimizer.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnx_test_runner_common.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_providers.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_common.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_session.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_flatbuffers.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_test_utils.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_framework.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/libonnxruntime_util.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/re2-build/libre2.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/google_nsync-build/libnsync_cpp.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/protobuf-build/libprotobuf-lite.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_city.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a \
./onnxruntime/build/macOS_arm64/MinSizeRel/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a

mkdir -p libs/macos-arm64_x86_64
lipo -create onnxruntime-macOS_x86_64-static-combined.a onnxruntime-macOS_arm64-static-combined.a -output libs/macos-arm64_x86_64/onnxruntime.a
rm onnxruntime-macOS_x86_64-static-combined.a
rm onnxruntime-macOS_arm64-static-combined.a