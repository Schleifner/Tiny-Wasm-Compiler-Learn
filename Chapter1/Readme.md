# Introduction

In this chapter, the first Wasm module will be compiled.

## Task to do

1. Convert the [add.wast](./test/add.wast) to wasm and json with [wast2json](https://github.com/WebAssembly/wabt/blob/main/docs/wast2json.md)
2. Parser the wasm module byte by byte.
3. Compile the opcode of the function `foo` to machine code
4. According to the input and assert in the wast, test the generated code with [gtest](https://github.com/google/googletest). Attention: gtest need to be cross compiled for arm64
5. Setup a [github action](https://docs.github.com/en/actions) to ensure code quality
   5.1 trigger on PR
   5.2 check clang-format
   5.3 build by cmake with clang-tidy enabled. Example of cmake code `set(CMAKE_CXX_CLANG_TIDY clang-tidy --config-file ${CMAKE_CURRENT_LIST_DIR}/.clang-tidy "--header-filter=${CMAKE_CURRENT_LIST_DIR}/(src|tests)/.*")`
   5.4 run test base on the wast

## Docs

1. [Wasm 1.0 spec](https://webassembly.github.io/spec/versions/core/WebAssembly-1.0.pdf)
2. [Arm64 instruction set](https://developer.arm.com/documentation/ddi0596/2020-12/Base-Instructions?lang=en)
3. Manage memory permission on Linux/Posix: [mmap](https://man7.org/linux/man-pages/man2/mmap.2.html) [mprotect](https://man7.org/linux/man-pages/man2/mprotect.2.html)

## Learn target

1. Parse Wasm byte code
2. Emit Arm64 machine code
3. Memory permission on Linux
4. Ensure code quality
