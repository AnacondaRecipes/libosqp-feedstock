@echo on

:: Configure.
cmake -G "Ninja" -B build -S . ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DENABLE_MKL_PARDISO=OFF ^
    -DOSQP_BUILD_STATIC_LIB=ON ^
    -DOSQP_BUILD_UNITTESTS=ON
    
if %ERRORLEVEL% neq 0 exit 1

:: Build.
cmake --build build -j
if %ERRORLEVEL% neq 0 exit 1

:: Test.
cmake --build build --target test
if %ERRORLEVEL% neq 0 exit 1

:: Reconfigure.
cmake -G "Ninja" -B build-nostatic -S . ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DENABLE_MKL_PARDISO=OFF ^
    -DOSQP_RESPECT_BUILD_SHARED_LIBS:BOOL=ON ^
    -DOSQP_BUILD_SHARED_LIB=ON ^
    -DOSQP_BUILD_STATIC_LIB=OFF
if %ERRORLEVEL% neq 0 exit 1

:: Rebuild.
cmake --build build-nostatic -j
if %ERRORLEVEL% neq 0 exit 1

:: Install.
cmake --install build-nostatic
if %ERRORLEVEL% neq 0 exit 1
