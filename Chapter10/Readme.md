# Chapter 10: Global variables

This chapter adds Wasm globals and expands your [runtime layout](#term-runtime-layout) state model.

## Learning goals

1. Implement global storage in runtime memory.
2. Support `global.get` and `global.set`.
3. Handle [mutable/immutable globals](#term-mutableimmutable-global) correctly.
4. Integrate global state into generated code execution.

## Task breakdown

1. Parse global declarations and [initializers](#term-initializer).
2. Design global [runtime layout](#term-runtime-layout) and indexing.
3. Emit code for `global.get` / `global.set`.
4. Enforce mutability rules.
5. Add tests for:
   1. Read/write mutable globals
   2. Read immutable globals
   3. Illegal writes (trap or validation behavior per project scope)
6. Keep CI passing.

## Study tips, tools, and best practices

1. Keep globals in a dedicated region for clarity.
2. Use typed metadata for global value type + mutability.
3. Add debug dumps for global table initialization.
4. Reuse memory-access helpers to avoid duplicated codegen logic.

## Knowledge checklist

1. Wasm global declarations and initialization rules.
2. Mutable vs immutable semantics.
3. Runtime data region design in JIT engines.

## Core references

1. Wasm global instructions (MDN):
   https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Variables/Global
2. Video talk on Wasm memory/runtime model:
   https://www.youtube.com/watch?v=CHj0AoUN82k
3. Wasm core spec:
   https://webassembly.github.io/spec/core/

## Extended reading

1. Runtime object/memory layout fundamentals:
   https://en.wikipedia.org/wiki/Data_structure_alignment
2. Video search: “Wasm globals explained”:
   https://www.youtube.com/results?search_query=webassembly+globals+explained

## Terms

1. <a id="term-global-variable-wasm-global"></a>**Global variable (Wasm global):** Module-level value accessible across functions.
2. <a id="term-mutableimmutable-global"></a>**Mutable/immutable global:** Global that can/cannot be modified after initialization.
3. <a id="term-initializer"></a>**Initializer:** Expression/value used to set initial global content.
4. <a id="term-runtime-layout"></a>**Runtime layout:** In-memory organization of runtime data structures.
