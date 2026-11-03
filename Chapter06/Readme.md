# Chapter 06: Blocks and branches (`block`, `br`, `br_if`, `drop`)

This chapter shifts from structured `if/else` to label-based branching.

## Learning goals

1. Implement [`block`](#term-block), [`br`](#term-br), and [`br_if`](#term-br_if).
2. Implement [`drop`](#term-drop).
3. Understand relative [label depth](#term-label-depth) in Wasm branching.
4. Emit reliable forward/backward branch behavior in Arm64.

## Task breakdown

1. Add block label stack management.
2. Implement unconditional and conditional branch by [label depth](#term-label-depth).
3. Implement [`drop`](#term-drop) for stack value disposal.
4. Add tests for:
   1. Single and nested blocks
   2. `br_if` taken/not taken
   3. `drop` on computed values
5. Keep CI green with all previous chapters.

## Study tips, tools, and best practices

1. Visualize label-depth mapping with a small trace log.
2. Reuse your Chapter 04 backpatching infrastructure when possible.
3. Verify stack state consistency at block boundaries.
4. Compare equivalent `if/else` and `block/br_if` programs.
5. Test deeply nested cases to validate depth resolution.
6. Use this block-style `abs` sample when validating `block` + `br_if` behavior:

```wat
(module
  (func $abs (param $x i32) (result i32)
    (block $return
      local.get $x
      i32.const 0
      i32.ge_s
      br_if $return

      i32.const 0
      local.get $x
      i32.sub
      return
    )
    local.get $x
  )
  (export "abs" (func $abs))
)
```

## Knowledge checklist

1. Wasm structured control flow and branch depth rules.
2. Relationship between high-level blocks and low-level jumps.
3. Correct handling of value stack around block exits.
4. Practical role of `drop` in stack cleanup.

## Core references

1. Wasm control-flow reference: https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Control_flow
2. Example WAT with `block`/`br_if` (current chapter tests): [./test](./test)
3. Arm64 branch and compare references:
   https://developer.arm.com/documentation/ddi0596/latest

## Extended reading

1. Blog/video search for “structured control flow in WebAssembly”:
   https://www.youtube.com/results?search_query=structured+control+flow+webassembly
2. Compilers text: _Engineering a Compiler_ (control-flow code generation chapters)

## Terms

1. <a id="term-block"></a>**`block`:** A structured Wasm control-flow region with a label target.
2. <a id="term-br"></a>**`br`:** Unconditional branch to a label depth.
3. <a id="term-br_if"></a>**`br_if`:** Conditional branch to a label depth when condition is true.
4. <a id="term-label-depth"></a>**Label depth:** Relative nesting distance used by Wasm branch instructions.
5. <a id="term-drop"></a>**`drop`:** Wasm instruction that discards the top value on the value stack.
