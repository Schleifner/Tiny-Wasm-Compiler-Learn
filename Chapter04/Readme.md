# Chapter 04: Conditional execution (`if` / `else`)

This chapter introduces [control flow](#term-control-flow) with branches based on runtime conditions.

## Learning goals

1. Implement Wasm `if`/`else` and compare instructions.
2. Support `nop`.
3. Emit correct Arm64 [conditional branches](#term-conditional-branch).
4. Use [backpatching](#term-backpatching) to fix jump targets after code size is known.

## Task breakdown

1. Add compare instruction support required by condition checks.
2. Implement `if` and optional `else` blocks with result handling.
3. Implement `nop`.
4. Add tests for:
   1. if-without-else
   2. if-with-else
   3. nested conditionals
   4. value-producing conditionals
5. Run full test suite and update CI.

## Study tips, tools, and best practices

1. Start with a simple `abs(x)` function as a baseline case.
2. Keep labels and patch sites explicit in a dedicated structure.
3. Treat branch target patching as a separate phase from instruction selection.
4. Test [nested conditionals](#term-nested-conditionals) early to avoid hidden offset bugs.
5. Use small WAT snippets to isolate each behavior.
6. Keep this baseline `if/else` example for quick regression checks:

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

## Knowledge checklist

1. Wasm `if`/`else` semantics for value stack/results.
2. Signed vs unsigned comparisons.
3. Arm64 [condition flags](#term-condition-flags) and conditional branch instructions.
4. Basic [backpatching](#term-backpatching) concepts.

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

## Terms

1. <a id="term-control-flow"></a>**Control flow:** The order in which program instructions execute.
2. <a id="term-conditional-branch"></a>**Conditional branch:** Jumping to a different code path based on a condition result.
3. <a id="term-condition-flags"></a>**Condition flags:** CPU status bits set by compare/arithmetic instructions and used by conditional branches.
4. <a id="term-backpatching"></a>**Backpatching:** Filling in branch target addresses/offsets later, after code layout is known.
5. <a id="term-nested-conditionals"></a>**Nested conditionals:** `if` statements inside other `if` statements.
