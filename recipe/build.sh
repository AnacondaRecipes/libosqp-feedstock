#!/bin/sh
set -ex

cmake -G Ninja -B build -S . \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DENABLE_MKL_PARDISO=OFF \
    -DOSQP_RESPECT_BUILD_SHARED_LIBS:BOOL=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DOSQP_BUILD_UNITTESTS=ON

cmake --build build -j
cmake --build build --target test
cmake --install build
