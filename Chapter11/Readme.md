# Introduction

This chapter will add linear memory. Linear memory is like the RAM of Wasm virtual machine. It can be used to store dynamic size data.

## Task to do

1. Design memory module of linear memory.
2. Support memory section of Wasm.
3. Support data section of Wasm.
4. Implement memory get/set/grow instructions.
5. Add memory out of range trap into trap handling.
6. Pass [all test cases](./test).
7. Add test into CI pipeline.

## Doc

1. [The memory module of wasm-micro-runtime](https://bytecodealliance.github.io/wamr.dev/blog/the-wamr-memory-model/)

## Learn target

1. Understand linear memory mechanism.
2. Understand the usage of `data` section
3. Understand memory get/set/grow instructions.
4. Design a overall memory layout including local, table, global and linear memory.
