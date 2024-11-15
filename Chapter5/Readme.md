# Introduction

This chapter will add if-else instruction. Then conditional execution is supported by this compiler

## Task to do

1. Support if/else instructions
2. Support compare instruction
3. Support nop instruction
4. Pass [all test cases](./test)
5. Add test into CI pipeline

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

2. In this chapter [address backpatching](https://www.geeksforgeeks.org/backpatching-in-compiler-design/) can be used

## Learn target

1. Understand if/else instruction of Wasm
2. Understand conditional jump instruction in arm64
