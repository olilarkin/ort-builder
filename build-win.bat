setlocal
@echo off
@set "ONNX_CONFIG=%1"
@if "%ONNX_CONFIG%"=="" (
	@set "ONNX_CONFIG=model.required_operators_and_types.config"
)
@set "CMAKE_BUILD_TYPE=%2"
@if "%CMAKE_BUILD_TYPE%"=="" (
	@set "CMAKE_BUILD_TYPE=MinSizeRel"
)

mkdir ".\libs\win-x86_64\%CMAKE_BUILD_TYPE%"

"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -format value -property catalog_productLine > tmp || exit \b
set /p version= < tmp
set version=%version:Dev=%

"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -format value -property installationPath > tmp || exit \b
set /p installationPath= < tmp

"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -format value -property catalog_productLineVersion > tmp || exit \b
set /p year= < tmp

del tmp

call onnxruntime\build.bat ^
--config="%CMAKE_BUILD_TYPE%" ^
--cmake_generator="Visual Studio %version% %year%" ^
--parallel ^
--minimal_build ^
--disable_ml_ops --disable_rtti ^
--include_ops_by_config "%ONNX_CONFIG%" ^
--enable_reduced_operator_type_support ^
--enable_msvc_static_runtime ^
--skip_tests ^
	|| exit \b

call "%installationPath%\VC\Auxiliary\Build\vcvarsall.bat" x86_x64 ^
	|| exit \b

@if "%CMAKE_BUILD_TYPE%"=="Debug" (
    set "PROTOBUF_LIB=libprotobuf-lited.lib"
) else (
    set "PROTOBUF_LIB=libprotobuf-lite.lib"
)

lib.exe /OUT:".\libs\win-x86_64\%CMAKE_BUILD_TYPE%\onnxruntime.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnx.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnx_proto.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_graph.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_mlas.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_optimizer.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_providers.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_common.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_session.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_flatbuffers.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_test_utils.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_framework.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnxruntime_util.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnx_test_data_proto.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\%CMAKE_BUILD_TYPE%\onnx_test_runner_common.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\re2-build\%CMAKE_BUILD_TYPE%\re2.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\protobuf-build\%CMAKE_BUILD_TYPE%\%PROTOBUF_LIB%" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\hash\%CMAKE_BUILD_TYPE%\absl_hash.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\hash\%CMAKE_BUILD_TYPE%\absl_city.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\hash\%CMAKE_BUILD_TYPE%\absl_low_level_hash.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\base\%CMAKE_BUILD_TYPE%\absl_throw_delegate.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\base\%CMAKE_BUILD_TYPE%\absl_raw_logging_internal.lib" ^
  ".\onnxruntime\build\Windows\%CMAKE_BUILD_TYPE%\_deps\abseil_cpp-build\absl\container\%CMAKE_BUILD_TYPE%\absl_raw_hash_set.lib"

