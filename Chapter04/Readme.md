# Chapter 04: Conditional execution (`if` / `else`)

## Introduction

This chapter will add if-else instruction. Then conditional execution is supported by this compiler.

## Task to do

1. Support if/else instructions.
2. Support compare instruction.
3. Support nop instruction.
4. Pass [all test cases](./test).
5. Add test into CI pipeline.

## Doc

1. This chapter can start with a classic example: calculate abs

```wat
(module
  (func $abs (param $x i32) (result i32)

    ;; Check if the number is negative

    (i32.lt_s (local.get $x) (i32.const 0))

    ;; If negative, return the negation of the number
    (if (result i32)

      (then
        (i32.sub (i32.const 0) (local.get $x))
      )
      ;; Else, return the number itself
      (else
        (local.get $x)
      )
    )
  )
  (export "abs" (func $abs))
)
```

2. In this chapter [address backpatching](https://www.geeksforgeeks.org/backpatching-in-compiler-design/) can be used.

## Learn target

1. Understand if/else instruction of Wasm.
2. Understand conditional jump instruction in arm64.

## Core references

1. Backpatching overview: https://www.geeksforgeeks.org/backpatching-in-compiler-design/
2. Wasm control flow reference (MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Control_flow
3. Arm64 branch instruction reference:
   https://developer.arm.com/documentation/ddi0596/latest

## Extended reading

1. Compiler design lecture notes on control-flow codegen:
   https://www.cs.cornell.edu/courses/cs4120/
2. Video search: “compiler backpatching explained”:
   https://www.youtube.com/results?search_query=compiler+backpatching+explained
