@echo off
setlocal EnableExtensions
set "ROOT_DIR=%~dp0"
set "BUILD_DIR=%ROOT_DIR%build"

echo Removing generated build files...
if exist "%BUILD_DIR%\" rmdir /s /q "%BUILD_DIR%"
if exist "%ROOT_DIR%CMakeCache.txt" del /q "%ROOT_DIR%CMakeCache.txt"
if exist "%ROOT_DIR%CMakeFiles\" rmdir /s /q "%ROOT_DIR%CMakeFiles"
if exist "%ROOT_DIR%cmake_install.cmake" del /q "%ROOT_DIR%cmake_install.cmake"
if exist "%ROOT_DIR%Makefile" del /q "%ROOT_DIR%Makefile"
if exist "%ROOT_DIR%Testing\" rmdir /s /q "%ROOT_DIR%Testing"

echo Cleanup complete.
exit /b 0
