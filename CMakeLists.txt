cmake_minimum_required(VERSION 3.16)
project(MathEngine LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_library(mathengine STATIC src/mathengine.cpp)
target_include_directories(mathengine PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_compile_features(mathengine PUBLIC cxx_std_17)
target_compile_options(mathengine PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)

add_executable(mathengine_demo examples/basic_demo.cpp)
target_link_libraries(mathengine_demo PRIVATE mathengine)
target_compile_features(mathengine_demo PRIVATE cxx_std_17)
target_compile_options(mathengine_demo PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)

add_executable(mathengine_verifier examples/verifier.cpp)
target_link_libraries(mathengine_verifier PRIVATE mathengine)
target_compile_features(mathengine_verifier PRIVATE cxx_std_17)
target_compile_options(mathengine_verifier PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)

add_executable(mathengine_tests tests/vector3_matrix_test.cpp)
target_link_libraries(mathengine_tests PRIVATE mathengine)
target_compile_features(mathengine_tests PRIVATE cxx_std_17)
target_compile_options(mathengine_tests PRIVATE
    $<$<CXX_COMPILER_ID:MSVC>:/W4>
    $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:-Wall -Wextra -Wpedantic>
)

enable_testing()
add_test(NAME mathengine_tests COMMAND mathengine_tests)
