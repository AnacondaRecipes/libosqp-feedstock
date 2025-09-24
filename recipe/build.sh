#!/bin/sh
set -ex

cmake -G Ninja -B build -S . \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DENABLE_MKL_PARDISO=OFF \
    -DOSQP_BUILD_STATIC_LIB=ON \
    -DOSQP_BUILD_UNITTESTS=ON

cmake --build build -j
cmake --build build --target test

cmake -G Ninja -B build-nostatic -S . \
    ${CMAKE_ARGS} \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DCMAKE_PREFIX_PATH=$PREFIX \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_LIBDIR=lib \
    -DENABLE_MKL_PARDISO=OFF \
    -DOSQP_RESPECT_BUILD_SHARED_LIBS:BOOL=ON \
    -DOSQP_BUILD_SHARED_LIB=ON \
    -DOSQP_BUILD_STATIC_LIB=OFF

cmake --build build-nostatic -j
cmake --install build-nostatic
