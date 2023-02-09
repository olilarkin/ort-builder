#!/bin/bash
./onnxruntime/build.sh \
--config=MinSizeRel \
--build_shared_lib \
--parallel \
--minimal_build \
--disable_ml_ops --disable_exceptions --disable_rtti \
--include_ops_by_config model.required_operators_and_types.config \
--enable_reduced_operator_type_support \
--skip_tests
