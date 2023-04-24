#!/usr/bin/env bash
set -euf -o pipefail

onnx_config="${1:-model.required_operators_and_types.config}"

build_arch() {
	onnx_config="$1"
	arch="$2"

	CMAKE_BUILD_TYPE=MinSizeRel

	python onnxruntime/tools/ci_build/build.py \
	--build_dir "onnxruntime/build/macOS_${arch}" \
	--config=${CMAKE_BUILD_TYPE} \
	--parallel \
	--minimal_build \
	--apple_deploy_target="10.13" \
	--disable_ml_ops --disable_exceptions --disable_rtti \
	--include_ops_by_config "$onnx_config" \
	--enable_reduced_operator_type_support \
	--cmake_extra_defines CMAKE_OSX_ARCHITECTURES="${arch}" \
	--skip_tests

	libtool -static -o "onnxruntime-macOS_${arch}-static-combined.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnx.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_graph.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnx_proto.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_mlas.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnx_test_data_proto.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_optimizer.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnx_test_runner_common.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_common.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_providers.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_session.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_flatbuffers.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_test_utils.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_framework.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/libonnxruntime_util.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/re2-build/libre2.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/google_nsync-build/libnsync_cpp.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/protobuf-build/libprotobuf-lite.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_city.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a" \
	"./onnxruntime/build/macOS_${arch}/${CMAKE_BUILD_TYPE}/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a"
}

build_arch "$onnx_config" x86_64
build_arch "$onnx_config" arm64

dir="onnxruntime-${version}-macOS-universal"
mkdir -p "$dir/lib"

lipo -create onnxruntime-macos_x86_64-static-combined.a onnxruntime-macos_arm64-static-combined.a -output "$dir/lib/libonnxruntime.a"
rm onnxruntime-macos_x86_64-static-combined.a
rm onnxruntime-macos_arm64-static-combined.a
