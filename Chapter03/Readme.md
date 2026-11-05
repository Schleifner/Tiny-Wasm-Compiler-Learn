# Chapter 03: Arithmetic operations

## Introduction

This chapter will add arithmetic instructions.

## Task to do

1. Support add/sub/mul instructions.
2. Pass [all test cases](./test).
3. Add test into CI pipeline.

## Doc

1. [Two's Complement representation of integers](https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html)
2. If you don't know which instruction to emit for a feature, [godbolt](https://godbolt.org/) is a very helpful tool. You can write the function you want with C/C++ and see what instruction GCC/Clang emits. Add -O2 flag to emit better performance instruction. For example, following code can be used to check how to load large immediate number.

```cpp
unsigned long long foo(){
    return 0xF0F0F0F0F0F0F0;
}
```

## Learn target

1. Understand arithmetic instructions of Wasm and arm64.
2. How to encode large immediate number in arm64.

## Core references

1. Two’s complement primer: https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html
2. Compiler Explorer: https://godbolt.org/
3. Wasm numeric instruction reference (MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Numeric
4. Arm doc usage guide for this chapter: [ARM_Documentation_Quick_Guide.md](./ARM_Documentation_Quick_Guide.md)

## Extended reading

1. Arm Architecture Reference Manual (A64 base instructions):
   https://developer.arm.com/documentation/ddi0596/latest
2. Video search: “Arm64 arithmetic instructions explained”:
   https://www.youtube.com/results?search_query=arm64+arithmetic+instructions
