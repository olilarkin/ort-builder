mkdir .\libs\win-x86_64\Release
mkdir .\libs\win-x86_64\Debug

call onnxruntime\build.bat ^
--config=MinSizeRel ^
--cmake_generator="Visual Studio 16 2019" ^
--parallel ^
--minimal_build ^
--disable_ml_ops --disable_exceptions --disable_rtti ^
--include_ops_by_config model.required_operators_and_types.config ^
--enable_reduced_operator_type_support ^
--enable_msvc_static_runtime ^
--skip_tests

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_x64
lib.exe /OUT:.\libs\win-x86_64\Release\onnxruntime.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnx.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnx_proto.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_graph.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_mlas.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_optimizer.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_providers.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_common.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_session.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_flatbuffers.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_test_utils.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_framework.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnxruntime_util.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnx_test_data_proto.lib ^
.\onnxruntime\build\Windows\MinSizeRel\MinSizeRel\onnx_test_runner_common.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\re2-build\MinSizeRel\re2.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\protobuf-build\MinSizeRel\libprotobuf-lite.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\hash\MinSizeRel\absl_hash.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\hash\MinSizeRel\absl_city.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\hash\MinSizeRel\absl_low_level_hash.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\base\MinSizeRel\absl_throw_delegate.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\base\MinSizeRel\absl_raw_logging_internal.lib ^
.\onnxruntime\build\Windows\MinSizeRel\_deps\abseil_cpp-build\absl\container\MinSizeRel\absl_raw_hash_set.lib ^

call onnxruntime\build.bat ^
--config=Debug ^
--cmake_generator="Visual Studio 16 2019" ^
--parallel ^
--minimal_build ^
--disable_ml_ops --disable_exceptions --disable_rtti ^
--include_ops_by_config model.required_operators_and_types.config ^
--enable_reduced_operator_type_support ^
--enable_msvc_static_runtime ^
--skip_tests

call "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" x86_x64
lib.exe /OUT:.\libs\win-x86_64\Debug\onnxruntime.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnx.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnx_proto.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_graph.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_mlas.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_optimizer.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_providers.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_common.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_session.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_flatbuffers.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_test_utils.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_framework.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnxruntime_util.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnx_test_data_proto.lib ^
.\onnxruntime\build\Windows\Debug\Debug\onnx_test_runner_common.lib ^
.\onnxruntime\build\Windows\Debug\_deps\re2-build\Debug\re2.lib ^
.\onnxruntime\build\Windows\Debug\_deps\protobuf-build\Debug\libprotobuf-lited.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\hash\Debug\absl_hash.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\hash\Debug\absl_city.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\hash\Debug\absl_low_level_hash.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\base\Debug\absl_throw_delegate.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\base\Debug\absl_raw_logging_internal.lib ^
.\onnxruntime\build\Windows\Debug\_deps\abseil_cpp-build\absl\container\Debug\absl_raw_hash_set.lib ^