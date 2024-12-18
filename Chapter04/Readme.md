# Introduction

This chapter will add div instructions. Div is a special instruction because it's the first instruction can trap in this learning project.

## Task to do

1. Support div_s/div_u instructions.
2. Check if operand is 0 before div.
3. Design how to abort JIT code execution at trap.
4. Extend the interface between Wasm and C++ to return trap code to C++.
5. Pass [all test cases](./test).
6. Add test into CI pipeline.

## Doc

1. To implement the "abort JIT code", the concept of C API [`setjmp`](https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/setjmp.S) and [`longjmp`](https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/__longjmp.S) can be referred

## Learn target

1. Understand div instructions of Wasm and arm64.
2. Trap mechanism of Wasm.
