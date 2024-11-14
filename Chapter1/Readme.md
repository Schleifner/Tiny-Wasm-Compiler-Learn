# Introduction

In this chapter, the first Wasm module will be compiled.

## Task to do

1. Parser the wasm module byte by byte. Note: integers are encoded in [LEB128](https://en.wikipedia.org/wiki/LEB128)
2. Compile the opcode of the function `foo` to machine code
3. Setup a [github action](https://docs.github.com/en/actions) to ensure code quality<br/>
   5.1 trigger on PR<br/>
   5.2 check clang-format<br/>
   5.3 build by cmake with clang-tidy enabled. Example of cmake code `set(CMAKE_CXX_CLANG_TIDY clang-tidy --config-file ${CMAKE_CURRENT_LIST_DIR}/.clang-tidy "--header-filter=${CMAKE_CURRENT_LIST_DIR}/(src|tests)/.*")`<br/>

## Docs

1. [Wasm 1.0 spec](https://webassembly.github.io/spec/versions/core/WebAssembly-1.0.pdf)
2. [Helpful tool to view wasm bytecode](https://webassembly.github.io/wabt/demo/wat2wasm/)
3. [Arm64 instruction set](https://developer.arm.com/documentation/ddi0596/2020-12/Base-Instructions?lang=en)
4. [Arm64 online assembler](https://shell-storm.org/online/Online-Assembler-and-Disassembler)
5. Dump disassembly of emitted JIT code binary with [aarch64-linux-gnu-objdump](https://linux.die.net/man/1/aarch64-linux-gnu-objdump) or [capstone](https://github.com/capstone-engine/capstone)
6. Manage memory permission on Linux/Posix: [mmap](https://man7.org/linux/man-pages/man2/mmap.2.html) [mprotect](https://man7.org/linux/man-pages/man2/mprotect.2.html)

## Learn target

1. Parse Wasm byte code
2. Emit Arm64 machine code
3. Memory permission on Linux
4. Ensure code quality with clang-format and clang-tidy in CI pipeline
