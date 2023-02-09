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
