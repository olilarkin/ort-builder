#!/bin/bash

#python -m tf2onnx.convert --saved-model model --output model.onnx --opset 13
python -m onnxruntime.tools.convert_onnx_models_to_ort $1 --enable_type_reduction
# check if directory exists before removing
if [ -d "./model" ]; then
    rm -R ./model/
fi
mkdir -p ./model
# python verify_model.py
python -m bin2c -o ./model/model.ort model.ort
