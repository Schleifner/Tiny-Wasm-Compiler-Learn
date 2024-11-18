# Introduction

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

1. Understand block/br/br_if of Wasm and arm64.
2. Think about what's the advantage of br_if compare with if-else?
