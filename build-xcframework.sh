#!/bin/bash
xcodebuild -create-xcframework \
-library libs/ios-arm64/onnxruntime.a \
-library libs/ios-arm64_x86_64-simulator/onnxruntime.a \
-library libs/macos-arm64_x86_64/onnxruntime.a \
-output onnxruntime.xcframework