# Chapter 06: Structured branching (`block` / `br` / `br_if`)

## Introduction

Block + br + br_if is any way to implement conditional execution.

## Task to do

1. Support block/br/br_if instructions.
2. Support drop instruction.
3. Pass [all test cases](./test).
4. Add test into CI pipeline.

## Doc

This is block version abs, compare this with the if-else version

```wat
(module
  (func $abs (param $x i32) (result i32)
    (block $return
      ;; Check if the number is non-negative
      local.get $x
      i32.const 0
      i32.ge_s
      br_if $return

      ;; If the number is negative, return its negation
      i32.const 0
      local.get $x
      i32.sub
      return
    )
    ;; If the number is non-negative, return it as is
    local.get $x
  )
  (export "abs" (func $abs))
)
```

## Learn target

1. Understand Wasm `block`, `br`, and `br_if`, and how to translate them into Arm64 branches.
2. Understand label depth and operand stack behavior when branching out of nested blocks.
3. Understand how `drop` affects the operand stack.
4. Compare `br_if` with `if` / `else`: when does an early exit make control flow easier to express?

## Extended reading

1. Video search: [WebAssembly structured control flow and branch labels](https://www.youtube.com/results?search_query=WebAssembly+structured+control+flow+branch+labels).
2. [A64 -- Base Instructions](https://www.scs.stanford.edu/~zyedidia/arm64/)
