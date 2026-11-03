# Chapter 08: Direct function calls between Wasm functions

This chapter adds internal function calls and introduces a project-level calling convention.

## Learning goals

1. Implement Wasm [`type` section](#term-type-section-wasm) parsing.
2. Implement direct `call` instruction.
3. Design and apply a Wasm-to-Wasm [calling convention](#term-calling-convention).
4. Resolve call targets correctly during code generation/linking.

## Task breakdown

1. Parse and store function signatures from the [`type` section](#term-type-section-wasm).
2. Define argument/return mapping and caller/callee responsibilities.
3. Emit direct call instructions (`[bl](#term-bl-branch-with-link)`) and link call targets.
4. Add tests for:
   1. Simple call chains
   2. Multi-argument calls
   3. Return-value propagation
5. Add/maintain CI coverage.

## Study tips, tools, and best practices

1. Keep ABI / [calling convention](#term-calling-convention) decisions documented in one place.
2. Separate symbolic call target tracking from final address patching.
3. Validate register preservation with targeted tests.
4. Prefer a dedicated [symbol table](#term-symbol-table) for function entries.

## Knowledge checklist

1. Wasm function type encoding and call semantics.
2. Arm64 `bl` and link register behavior.
3. [Volatile/non-volatile registers](#term-volatilenon-volatile-registers).
4. Call-site [relocation/patching](#term-relocationpatching) fundamentals.

## Core references

1. AAPCS64: https://github.com/ARM-software/abi-aa/blob/a82eef0433556b30539c0d4463768d9feb8cfd0b/aapcs64/aapcs64.rst
2. [Symbol table](#term-symbol-table) overview:
   https://medium.com/ax1al/a-brief-info-on-linker-loader-symbol-symbol-tables-2fed729eb490
3. Wasm function type and call instructions (spec):
   https://webassembly.github.io/spec/core/

## Extended reading

1. Linkers and relocation basics (ELF focused):
   https://www.akkadia.org/drepper/dsohowto.pdf
2. Video search: “AArch64 calling convention tutorial”:
   https://www.youtube.com/results?search_query=aarch64+calling+convention+tutorial

## Terms

1. <a id="term-type-section-wasm"></a>**Type section (Wasm):** Section that defines function signatures.
2. <a id="term-calling-convention"></a>**Calling convention:** Rules for passing arguments/returns and preserving registers across calls.
3. <a id="term-bl-branch-with-link"></a>**`bl` (branch with link):** Arm64 call instruction that saves return address in link register.
4. <a id="term-volatilenon-volatile-registers"></a>**Volatile/non-volatile registers:** Registers caller must save vs registers callee must preserve.
5. <a id="term-symbol-table"></a>**Symbol table:** Mapping from symbolic names/IDs to addresses or metadata used for linking.
6. <a id="term-relocationpatching"></a>**Relocation/patching:** Fixing instruction targets/addresses after final layout is known.
