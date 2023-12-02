#!/bin/bash
xcodebuild -create-xcframework \
-library libs/ios-arm64/libonnxruntime.a \
-library libs/ios-arm64_x86_64-simulator/libonnxruntime.a \
-library libs/macos-arm64_x86_64/libonnxruntime.a \
-output onnxruntime.xcframework