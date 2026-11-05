# Chapter 02: Locals and parameter handling

## Introduction

This chapter will add local variable

## Task to do

1. Convert the [local.wast](./test/local.wast) to wasm and json with [wast2json](https://github.com/WebAssembly/wabt/blob/main/docs/wast2json.md).
2. Compile the generated wasm files. <br/>
   2.1 Need to design a data structure to store the mapping of exported function JIT code address and name.<br/>
   2.2 Need to design a storage module of local variables of a function.<br/>
3. According to the input and assert in the wast, test the generated code with [gtest](https://github.com/google/googletest). Attention: gtest need to be cross compiled for arm64
4. Add test into CI pipeline

## Doc

1. [C++ json lib](https://github.com/nlohmann/json.git)
2. [Use gtest in cmake](https://cmake.org/cmake/help/latest/module/FindGTest.html)

## Learn target

1. Understand the parameters and local variables of Wasm.
2. Understand local get/set/tee.
3. ABI between C++ and JIT.

## Tips and best practices

If you already can convert `.wast -> .wasm/.json` but feel stuck at `wasm -> Arm64`, use this workflow:

1. Treat `.json` as a **test driver**, not codegen input; your codegen source of truth is the Wasm function body bytes/opcodes.
2. Build a tiny `opcode mapping table` for this chapter only:
   1. `local.get` -> load local/param value into a working register.
   2. `local.set` -> store top stack value into local slot.
   3. `local.tee` -> store to local slot and keep value on Wasm value stack.
3. Implement one opcode at a time, and for each opcode keep three views side by side:
   1. Wasm instruction stream
   2. Expected Arm64 assembly intent
   3. Emitted machine-code bytes
4. Use a strict debug loop:
   1. Parse and print decoded instructions.
   2. Emit bytes.
   3. Disassemble emitted bytes.
   4. Compare against expected behavior from test case.
5. Start with one-function minimal examples and only then run full chapter tests.

## Core references

1. `wast2json` docs: https://github.com/WebAssembly/wabt/blob/main/docs/wast2json.md
2. nlohmann/json: https://github.com/nlohmann/json.git
3. GoogleTest: https://github.com/google/googletest
4. CMake `FindGTest`: https://cmake.org/cmake/help/latest/module/FindGTest.html
5. `wasm2wat` / `wasm-objdump` (WABT tools): https://github.com/WebAssembly/wabt
6. Compiler Explorer (check equivalent Arm64 codegen ideas): https://godbolt.org/
7. Capstone disassembly engine: https://github.com/capstone-engine/capstone
8. Arm64 instruction reference: https://developer.arm.com/documentation/ddi0596/latest

## Extended reading

1. WebAssembly spec tests repository: https://github.com/WebAssembly/testsuite
2. Video search for “Wasm stack machine execution model”:
   https://www.youtube.com/results?search_query=webassembly+stack+machine+explained
3. Video search for “Wasm to machine code / JIT internals”:
   https://www.youtube.com/results?search_query=webassembly+jit+compiler+internals
4. Reader-friendly Wasm manual:
   https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md
