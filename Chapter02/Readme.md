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
3. [Arm64 instruction reference](https://developer.arm.com/documentation/ddi0596/latest)

## Learn target

1. Understand the parameters and local variables of Wasm.
2. Understand local get/set/tee.
3. ABI between C++ and JIT.

## Tips

If you already can convert `.wast -> .wasm/.json` but feel stuck at `wasm -> Arm64`, try to find the answer to the below questions:

1. What is my true source of codegen truth here: the `.json` test driver, or the Wasm module binary itself?
2. For one target opcode, what Arm64 instruction intent should it map to, and how can I prove the emitted bytes are correct?
3. If I pause in debugger (see [Setup gdb debugger](../Chapter00/Readme.md)), what concrete state should I inspect first: stack, locals, registers, or PC flow?
4. Before rerunning full chapter tests, can we pause and shrink this to one tiny single-function repro first? At which exact step does it go wrong? What clue does that give us about the bug?

## Extended reading

1. WebAssembly spec tests repository: https://github.com/WebAssembly/testsuite
2. Video search for “Wasm stack machine execution model”:
   https://www.youtube.com/results?search_query=webassembly+stack+machine+explained
3. Video search for “Wasm to machine code / JIT internals”:
   https://www.youtube.com/results?search_query=webassembly+jit+compiler+internals
