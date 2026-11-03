# Chapter 03: Arithmetic operations

This chapter adds integer arithmetic and strengthens your code-generation workflow.

## Learning goals

1. Implement integer `add`, `sub`, and `mul`.
2. Map Wasm arithmetic semantics to Arm64 instructions.
3. Handle [immediate](#term-immediate) constants cleanly (including large values).
4. Keep correctness and CI coverage as instruction count grows.

## Task breakdown

1. Add [opcode](#term-opcode) support for arithmetic instructions.
2. Extend tests to cover:
   1. Positive and negative values.
   2. [Boundary values](#term-boundary-values).
   3. Mixed [immediate](#term-immediate)/local [operands](#term-operand).
3. Run all chapter tests and integrate into CI.

## Study tips, tools, and best practices

1. Use a consistent emit path for binary ops (pop/pop/compute/push).
2. Prefer reusable helpers for register allocation and stack moves.
3. Use Compiler Explorer (Godbolt) to inspect high-quality instruction choices.
4. Add at least one disassembly-based debug path for failures.
5. Keep arithmetic behavior aligned with Wasm integer semantics.
6. For large-immediate intuition, try this minimal Godbolt example and inspect emitted Arm64 instructions:

```cpp
unsigned long long foo() {
    return 0xF0F0F0F0F0F0F0ULL;
}
```

## Knowledge checklist

1. [Two’s complement](#term-twos-complement) arithmetic.
2. Arm64 arithmetic instruction forms.
3. Large immediate construction/loading strategies on Arm64.
4. Overflow behavior differences (for later trap logic chapters).

## Core references

1. Two’s complement primer: https://www.cs.cornell.edu/~tomf/notes/cps104/twoscomp.html
2. Compiler Explorer: https://godbolt.org/
3. Wasm numeric instruction reference (MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Numeric
4. Arm doc usage guide for this chapter: [ARM_Documentation_Quick_Guide.md](./ARM_Documentation_Quick_Guide.md)

## Extended reading

1. Arm Architecture Reference Manual (A64 base instructions):
   https://developer.arm.com/documentation/ddi0596/latest
2. Video search: “Arm64 arithmetic instructions explained”:
   https://www.youtube.com/results?search_query=arm64+arithmetic+instructions

## Terms

1. <a id="term-twos-complement"></a>**Two’s complement:** Standard binary representation for signed integers in modern CPUs.
2. <a id="term-immediate"></a>**Immediate:** A constant value encoded directly inside an instruction.
3. <a id="term-opcode"></a>**Opcode:** The part of an instruction that specifies the operation to perform.
4. <a id="term-operand"></a>**Operand:** The input value(s) an instruction works on.
5. <a id="term-boundary-values"></a>**Boundary values:** Edge-case numbers (for example min/max integer) used to test correctness.
