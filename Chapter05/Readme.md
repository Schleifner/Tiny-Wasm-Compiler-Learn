# Chapter 05: Division and traps

## Introduction

This chapter will add div instructions. Div is a special instruction because it's the first instruction can trap in this learning project.

## Task to do

1. Support div_s/div_u instructions.
2. Check if operand is 0 before div.
3. Check for integer overflow.
4. Design how to abort JIT code execution at trap.
5. Extend the interface between Wasm and C++ to return trap code to C++.
6. Pass [all test cases](./test).
7. Add test into CI pipeline.

## Doc

1. To implement the "abort JIT code", the concept of C API [`setjmp`](https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/setjmp.S) and [`longjmp`](https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/__longjmp.S) can be referred
2. A more reader-friendly wasm manual can be found here (https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md), it may offer help if you found the official one hard to understand.
3. Wasm numeric/trap behavior (spec): https://webassembly.github.io/spec/core/

## Learn target

1. Understand div instructions of Wasm and arm64.
2. Understand the implication of two's complement on implementing div instructions.
3. Trap mechanism of Wasm and C.

## Tips

If you can already run normal arithmetic but get stuck on `div` and trap handling, try to find the answer to the below questions:

1. For `div_s/div_u`, which cases are normal results, and which cases must trap by Wasm semantics?
2. Where should trap checks happen in your flow?
3. When trap happens, what exact control-transfer path do you want: JIT code -> `longjmp` -> host C++ -> trap code return?
4. Can you create one tiny single-function repro for divide-by-zero and one for overflow, then verify both before rerunning full chapter tests?

## Extended reading

1. Video search for "Wasm trap / runtime error handling":
   https://www.youtube.com/results?search_query=webassembly+trap+runtime+error+handling
2. Error handling patterns in VM/runtime design:
   https://craftinginterpreters.com/
3. Video search: “setjmp longjmp explained in C”:
   https://www.youtube.com/results?search_query=setjmp+longjmp+explained
4. CS360 Lecture notes -- Setjmp and Longjmp
   https://web.eecs.utk.edu/~huangj/cs360/360/notes/Setjmp/lecture.html
