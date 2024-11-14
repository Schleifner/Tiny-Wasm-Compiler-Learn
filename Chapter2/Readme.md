# Introduction

This chapter will add local variable

## Task to do

1. Convert the [local.wast](./test/local.wast) to wasm and json with [wast2json](https://github.com/WebAssembly/wabt/blob/main/docs/wast2json.md)
2. Compile the generated wasm files. <br>
   2.1 Need to design a data structure to store the mapping of exported function JIT code address and name<br>
   2.2 Need to design a storage module of local variables of a function<br>
3. According to the input and assert in the wast, test the generated code with [gtest](https://github.com/google/googletest). Attention: gtest need to be cross compiled for arm64
4. Add test into CI pipeline

## Doc

1. [C++ json lib](https://github.com/nlohmann/json.git)

2. [Use gtest in cmake](https://cmake.org/cmake/help/latest/module/FindGTest.html)

## Learn target

1. Understand the parameters and local variables of Wasm
2. Understand local get/set/tee
3. ABI between C++ and JIT
