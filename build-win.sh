#!/usr/bin/env bash
set -euf -o pipefail
./build-win.bat model.required_operators_and_types.config MinSizeRel
./build-win.bat model.required_operators_and_types.config Debug