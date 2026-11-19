cmake_minimum_required(VERSION 3.21)

project(JanOSKernel VERSION 0.1.0 LANGUAGES CXX ASM)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_executable(janos-kernel.elf
    arch/aarch64/boot.S
    src/kernel.cpp
)

target_compile_options(janos-kernel.elf PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-ffreestanding>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-stack-protector>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
    $<$<COMPILE_LANGUAGE:CXX>:-mgeneral-regs-only>
    $<$<COMPILE_LANGUAGE:CXX>:-Wall>
    $<$<COMPILE_LANGUAGE:CXX>:-Wextra>
    $<$<COMPILE_LANGUAGE:CXX>:-Werror>
)

target_link_options(janos-kernel.elf PRIVATE
    -nostdlib
    -nostartfiles
    -nodefaultlibs
    -Wl,--build-id=none
    -Wl,-T,${CMAKE_CURRENT_SOURCE_DIR}/linker.ld
)

set_target_properties(janos-kernel.elf PROPERTIES
    SUFFIX ""
    LINK_DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/linker.ld
)
