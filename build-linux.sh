#!/bin/bash

ONNX_CONFIG="${1:-model.required_operators_and_types.config}"
CMAKE_BUILD_TYPE=MinSizeRel

build_arch() {
  ONNX_CONFIG="$1"
  ARCH="$2"

  python onnxruntime/tools/ci_build/build.py \
  --build_dir "onnxruntime/build/linux_${ARCH}" \
  --config=${CMAKE_BUILD_TYPE} \
  --parallel \
  --compile_no_warning_as_error \
  --skip_tests \
  --minimal_build \
  --disable_ml_ops --disable_rtti \
  --include_ops_by_config "$ONNX_CONFIG" \
  --enable_reduced_operator_type_support
  
  BUILD_DIR=onnxruntime/build/linux_${ARCH}/${CMAKE_BUILD_TYPE}
}

build_arch "$ONNX_CONFIG" x86_64

ar -M << EOM
        CREATE "onnxruntime-linux_${ARCH}-static-combined.a"
        ADDLIB "${BUILD_DIR}/libonnx.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_graph.a"
        ADDLIB "${BUILD_DIR}/libonnx_proto.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_mlas.a"
        ADDLIB "${BUILD_DIR}/libonnx_test_data_proto.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_optimizer.a"
        ADDLIB "${BUILD_DIR}/libonnx_test_runner_common.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_common.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_providers.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_session.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_flatbuffers.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_test_utils.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_framework.a"
        ADDLIB "${BUILD_DIR}/libonnxruntime_util.a"
        ADDLIB "${BUILD_DIR}/_deps/pytorch_cpuinfo-build/deps/clog/libclog.a
        ADDLIB "${BUILD_DIR}/_deps/pytorch_cpuinfo-build/libcpuinfo.a
        ADDLIB "${BUILD_DIR}/_deps/re2-build/libre2.a"
        ADDLIB "${BUILD_DIR}/_deps/google_nsync-build/libnsync_cpp.a"
        ADDLIB "${BUILD_DIR}/_deps/protobuf-build/libprotobuf-lite.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/hash/libabsl_hash.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/hash/libabsl_city.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/hash/libabsl_low_level_hash.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/base/libabsl_throw_delegate.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/container/libabsl_raw_hash_set.a"
        ADDLIB "${BUILD_DIR}/_deps/abseil_cpp-build/absl/base/libabsl_raw_logging_internal.a"
    SAVE
    END
EOM