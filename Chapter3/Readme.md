# Introduction

This chapter will add arithmetic instructions

## Task to do

1. Support add/sub/mul instructions
2. Pass [all test cases](./test)
3. Add test into CI pipeline

## Doc

1. [Two's Complement representation of integers](https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html)
2. If you don't know which instruction to emit for a feature, [godbolt](https://godbolt.org/) is a very helpful tool. You can write the feature you want with C/C++ and see what instruction does GCC/Clang emit. Add -O2 to emit better performance instruction. For example, following code can be used to check how to load large immediate number

```cpp
unsigned long long foo(){
    return 0xF0F0F0F0F0F0F0;
}
```

## Learn target

1. Understand arithmetic instructions of Wasm and arm64
2. How to encode large immediate number in arm64
