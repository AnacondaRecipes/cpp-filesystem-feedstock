#!/bin/bash

# Isolate the build
mkdir -p .build
cd .build || exit 1

if [[ "${target_platform}" == osx-arm64 ]]; then
    perform_test=OFF
else
    perform_test=ON
fi

# Call CMake to generate the build files
cmake -G "Ninja" \
      ${CMAKE_ARGS} \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DGHC_FILESYSTEM_BUILD_TESTING=${perform_test} \
      -DGHC_FILESYSTEM_BUILD_EXAMPLES=OFF \
      ${SRC_DIR} \
      || exit 1

# Build and install
ninja install


# Perform tests
if [[ "${perform_test}" == ON ]]; then
    test/exception || exit 1
    test/filesystem_test || exit 1
    #test/filesystem_test_cpp17 || exit 1
    #test/filesystem_test_cpp20 || exit 1
    test/fwd_impl_test || exit 1
    test/multifile_test || exit 1
    #test/std_filesystem_test  || exit 1
fi
