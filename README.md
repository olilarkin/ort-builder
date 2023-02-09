# ORTBuilder

Convert ONNX model to ORT and serialize C++ source code, generate custom slimmed ONNX Runtime static libs

0. Checkout ONNX Runtime `$ git clone https://github.com/microsoft/onnxruntime.git`

1. Create a [virtual environment](https://packaging.python.org/tutorials/installing-packages/#creating-virtual-environments) `$ python3 -m venv venv`

2. Activate it `$ source ./venv/bin/activate`

3. Install dependencies `$ pip install -r requirements.txt`

4. Run `$ ./convert-model-to-ort.sh model.onnx`

5. Build for apple
   Run `$ ./build-mac.sh`
   Run `$ ./build-ios.sh`
   Run `$ ./build-ios-simulator.sh`
   Run `$ ./build-xcframework.sh`

6. Build for win
   Run `$ ./build-win.sh`
   ... tbc

7. Build for ...
   Run `$ ./build-win.sh`
   ... tbc