@echo off
setlocal EnableExtensions
set "ROOT_DIR=%~dp0"
cd /d "%ROOT_DIR%"
set "BUILD_DIR=build"

if not exist "CMakeLists.txt" (
    echo ERROR: This folder is not the MathEngine project root.
    echo Open the folder that contains build.bat, README.md, and CMakeLists.txt.
    exit /b 1
)

echo [1/3] Checking prerequisites...
where cmake >nul 2>nul
if errorlevel 1 (
    echo ERROR: CMake is not installed or is not available in PATH.
    exit /b 1
)

set "COMPILER_TYPE="
where cl >nul 2>nul && set "COMPILER_TYPE=MSVC"
if not defined COMPILER_TYPE where g++ >nul 2>nul && set "COMPILER_TYPE=MinGW"
if not defined COMPILER_TYPE where clang++ >nul 2>nul && set "COMPILER_TYPE=Clang"

if not defined COMPILER_TYPE (
    echo ERROR: No supported C++ compiler was detected.
    exit /b 1
)

echo Found compiler: %COMPILER_TYPE%

set "RECONFIGURE=0"
if exist "%BUILD_DIR%\CMakeCache.txt" (
    set "EXISTING_GENERATOR="
    for /f "usebackq tokens=1* delims==" %%L in (`findstr /b /c:"CMAKE_GENERATOR:INTERNAL=" "%BUILD_DIR%\CMakeCache.txt" 2^>nul`) do set "EXISTING_GENERATOR=%%M"
    if /i "%COMPILER_TYPE%"=="MinGW" (
        if /i not "%EXISTING_GENERATOR%"=="MinGW Makefiles" set "RECONFIGURE=1"
    ) else if /i "%COMPILER_TYPE%"=="MSVC" (
        echo %EXISTING_GENERATOR% | findstr /i /c:"Visual Studio" >nul 2>nul
        if errorlevel 1 set "RECONFIGURE=1"
    )
) else if exist "%BUILD_DIR%\" (
    set "RECONFIGURE=1"
)

if "%RECONFIGURE%"=="1" (
    echo Existing build configuration does not match the detected compiler or generator.
    echo Removing "%BUILD_DIR%" and reconfiguring...
    rmdir /s /q "%BUILD_DIR%"
)

if not exist "%BUILD_DIR%\" mkdir "%BUILD_DIR%"

echo [2/3] Configuring project...
if /i "%COMPILER_TYPE%"=="MinGW" (
    cmake -S . -B "%BUILD_DIR%" -G "MinGW Makefiles"
) else (
    cmake -S . -B "%BUILD_DIR%"
)
if errorlevel 1 exit /b 1

echo [3/3] Building project...
cmake --build "%BUILD_DIR%" --config Debug
if errorlevel 1 exit /b 1

echo Build complete.
exit /b 0
