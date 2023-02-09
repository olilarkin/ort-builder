#!/bin/bash
python onnxruntime/tools/ci_build/build.py \
--build_dir onnxruntime/build/wasm \
--config=MinSizeRel \
--build_wasm_static_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--skip_tests
