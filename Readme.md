# What's this repository

This repository contains training materials and learning path about developing a WebAssembly JIT compiler for a beginner.
But this repository doesn't contain any compiler implementation.

## Who is the reader of this repository

Beginner developers who are interested at WebAssembly & compiler and want to start working this domain.

## Learning target of this repository

Develop a tiny **Wasm 1.0** JIT compiler for **arm64** with cmake and **C++ 14**. With following features:

1. Module parser
2. Export function call
3. Local variables
4. Arithmetic operation
5. Control flow instructions
6. Direct function call
7. Indirect function call
8. Global variable
9. Linear memory
10. Import function call

### Out of scope:

1. Validation of the Wasm Module
2. Floating point instructions

#### Engineering requirement:

1. Use Cmake 3.10+
2. Use the [.clang-format](./clang-format) for code format. [Doc](https://clang.llvm.org/docs/ClangFormat.html)
3. Use the [.clang-tidy](./clang-tidy) for linter. [Doc](https://clang.llvm.org/extra/clang-tidy/)
4. Enable the warning flags of of gcc `-Wall -Wextra -Wpedantic  -Wformat=2
-Wformat-security -Werror=format-security -Wcast-align -Wcast-qual -Wconversion
-Wdouble-promotion -Wfloat-equal -Wmissing-include-dirs 
-Wredundant-decls -Wshadow -Wsign-conversion -Wswitch -Wuninitialized
-Wunused-parameter -Walloca -Wunused-result -Wunused-local-typedefs
-Wwrite-strings -Wpointer-arith -Wfloat-conversion -Wnull-dereference -Wdiv-by-zero
-Wswitch-default -Wno-switch-bool -Wunknown-pragmas -Werror`

### FAQ

1. Why chose arm64 instruction set?
   Arm64 and x86_64 are most often used instruction set on consumer electronics. Since x86_64 instruction encoding is complex, arm64 is more friendly for beginner
2. Why use C++ 14?
   C++ is the most classic system-level programming language. It's friendly to interacting with operating system and JIT code. In meanwhile, it's more powerful than C. Using version 14 is due to some embedded compiler doesn't support C++17 and further.
3. Which operating system and compiler to use?
   No limit here. But some guide of this repo may assume developers are developing on a x86_64 Ubuntu 24.04 or later with gcc-arm64 cross compiler and testing with qemu user mode emulator. If someone is not using this setup, some steps need to be adapted.

## Prerequisite knowledge

1. As a compiler developer, **Compiler principle** is the core knowledge
2. Emit machine code need solid knowledge about **Computer Organization and Architecture**
3. Load JIT code need to interaction with operating system, so **Principles of Operating Systems** is also necessary

For developers who have not systematically studied these principles in university or have not learned them thoroughly, it is strongly required to study or revise them.
In [Learning_Materials](./Learning_Materials) there are some recommended curses

## What to do Next

For developers without basic knowledge of Wasm and arm64, start with [Chapter 0](./Chapter0/).

Otherwise, start with [Chapter 1](./Chapter1/), and then implement the compiler chapter by chapter
