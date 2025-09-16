@echo on

cmake -G "Ninja" -B build -S . ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
    -DENABLE_MKL_PARDISO=OFF ^
    -DOSQP_RESPECT_BUILD_SHARED_LIBS:BOOL=ON ^
    -DBUILD_SHARED_LIBS=ON ^
    -DOSQP_BUILD_UNITTESTS=ON
    
if %ERRORLEVEL% neq 0 exit 1

:: Build.
cmake --build build -j
if %ERRORLEVEL% neq 0 exit 1

:: Test.
cmake --build build --target test
if %ERRORLEVEL% neq 0 exit 1

:: Install.
cmake --install build
if %ERRORLEVEL% neq 0 exit 1
