# Introduction

This chapter will add handler of overflow. Until this chapter, most likely stack is used in JIT compiler. Attention: **Stack overflow in Wasm module can cause host runtime process crash**, so stack overflow in Wasm function call must be avoided.

## Task to do

1. Check stack limit before grow stack size.
2. Add stack overflow trap into trap handling.
3. Pass [all test cases](./test).
4. Add test into CI pipeline.

## Doc

1. [Why stack overflow leads to segmentation fault](https://en.wikipedia.org/wiki/Segmentation_fault#Stack_overflow)
2. [What's stack memory layout and guard page](https://devblogs.microsoft.com/oldnewthing/20220203-00/?p=106215)

## Learn target

1. Understand how OS allocate stack for each thread.
2. Understand what's a guard page of .
