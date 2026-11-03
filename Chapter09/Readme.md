# Chapter 09: Indirect calls and function tables

This chapter adds [`call_indirect`](#term-call_indirect), the basis for function pointers and dynamic dispatch.

## Learning goals

1. Implement Wasm [`table`](#term-table-wasm), [`elem`](#term-element-segment-elem), and [`call_indirect`](#term-call_indirect).
2. Perform [signature checks](#term-signature-check) before indirect calls.
3. Reuse and extend trap handling for indirect-call failures.
4. Design runtime table layout accessible by JIT-generated code.

## Task breakdown

1. Parse and initialize table/element sections.
2. Implement runtime [table](#term-table-wasm) storage and lookup.
3. Emit `call_indirect` code path with:
   1. [Bounds checks](#term-bounds-check)
   2. Null/invalid entry checks
   3. [Signature checks](#term-signature-check)
4. Extend trap codes for indirect call failures.
5. Add test cases for valid/invalid targets and signature mismatch.
6. Keep CI up to date.

## Study tips, tools, and best practices

1. Keep table metadata and function metadata in separate structures.
2. Validate table index and signature before jumping.
3. Assign distinct trap codes per failure reason.
4. Compare direct vs indirect call paths to avoid ABI drift.

## Knowledge checklist

1. Wasm table model and element initialization.
2. `call_indirect` validation requirements.
3. Arm64 indirect branch/call forms.
4. Runtime safety checks for dynamic call targets.

## Core references

1. Wasm table and indirect calls (spec): https://webassembly.github.io/spec/core/
2. CPU pipeline and branch behavior:
   https://web.eecs.utk.edu/~mbeck/classes/cs160/lectures/09_intruc_pipelining.pdf
3. MDN table reference:
   https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/JavaScript_interface/Table

## Extended reading

1. Branch prediction and indirect branch cost (overview):
   https://en.wikipedia.org/wiki/Branch_predictor
2. Video search: “WebAssembly call_indirect explained”:
   https://www.youtube.com/results?search_query=webassembly+call_indirect+explained

## Terms

1. <a id="term-call_indirect"></a>**`call_indirect`:** Wasm instruction that calls a function through a table entry.
2. <a id="term-table-wasm"></a>**Table (Wasm):** Runtime array of callable references used by indirect calls.
3. <a id="term-element-segment-elem"></a>**Element segment (`elem`):** Section data used to initialize table entries.
4. <a id="term-bounds-check"></a>**Bounds check:** Verifying an index is within valid range before access.
5. <a id="term-signature-check"></a>**Signature check:** Verifying target function type matches expected call type.
