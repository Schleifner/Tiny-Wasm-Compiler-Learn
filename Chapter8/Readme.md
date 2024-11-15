# Introduction

This chapter will add indirect function call. It's the foundation of virtual function and function pointer.

## Task to do

1. Implement call_indirect instruction
2. Check function signature for call_indirect. Extend the trap mechanism also for call_indirect beside `div`
3. Design memory layout for Wasm `table`
4. Design how to let JIT code get address of table
5. Implement `table` and `elem` of Wasm
6. Pass [all test cases](./test)
7. Add test into CI pipeline

## Doc

1. Extended read about performance overhead of indirect call compare with direct call regarding [CPU pipeline](https://web.eecs.utk.edu/~mbeck/classes/cs160/lectures/09_intruc_pipelining.pdf).

## Learn target

1. Understand call_indirect instruction of Wasm
2. Understand table of Wasm
3. Understand indirect function call of arm64
4. Understand context, volatile/non-volatile registers and calling convention
