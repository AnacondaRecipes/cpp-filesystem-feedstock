:: Windows

:: Isolate the build
mkdir build
cd build
if errorlevel 1 exit 1

:: Generate the build files
cmake -G "Ninja" ^
      %CMAKE_ARGS% ^
      -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
      -DBUILD_TESTS=OFF ^
      -DGHC_FILESYSTEM_BUILD_TESTING=ON ^
      -DGHC_FILESYSTEM_BUILD_EXAMPLES=OFF ^
      %SRC_DIR%
if errorlevel 1 exit 1

:: Build and install
ninja install
if errorlevel 1 exit 1

:: Perform tests
test\exception
if errorlevel 1 exit 1

test\filesystem_test
if errorlevel 1 exit 1

::test\filesystem_test_cpp17
::if errorlevel 1 exit 1

::test\filesystem_test_cpp20
::if errorlevel 1 exit 1

test\fwd_impl_test
if errorlevel 1 exit 1

test\multifile_test
if errorlevel 1 exit 1

::test\std_filesystem_test
::if errorlevel 1 exit 1
