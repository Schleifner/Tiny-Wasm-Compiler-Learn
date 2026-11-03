# Chapter 11: Linear memory and data segments

This chapter adds Wasm [linear memory](#term-linear-memory), the main mutable byte-addressable storage.

## Learning goals

1. Implement memory section parsing and runtime allocation.
2. Load [data segments](#term-data-segment) into linear memory.
3. Implement memory [load/store](#term-loadstore)/grow operations.
4. Add [OOB (out-of-bounds)](#term-oob-out-of-bounds-access) traps for memory access.
5. Define a coherent overall runtime memory layout.

## Task breakdown

1. Parse memory limits and initialize linear memory [pages](#term-page-wasm-memory-page).
2. Parse and apply data sections.
3. Implement memory access instructions used in this chapter.
4. Implement memory growth and update related metadata.
5. Integrate [OOB](#term-oob-out-of-bounds-access) traps with existing trap mechanism.
6. Add tests for normal access, boundary access, and OOB cases.
7. Keep CI green.

## Study tips, tools, and best practices

1. Treat bounds checks as mandatory on every memory access path.
2. Keep page-size logic centralized.
3. Add helper APIs for address calculation and range validation.
4. Test data-segment initialization with deterministic fixtures.

## Knowledge checklist

1. Wasm linear memory model (pages, limits, growth).
2. Data segment initialization semantics.
3. Load/store width and signedness basics.
4. Unified trap handling for memory faults.

## Core references

1. WAMR memory model article:
   https://bytecodealliance.github.io/wamr.dev/blog/the-wamr-memory-model/
2. Wasm memory instructions reference (MDN):
   https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Memory
3. Wasm core spec:
   https://webassembly.github.io/spec/core/

## Extended reading

1. Bytecode Alliance docs and talks:
   https://bytecodealliance.org/
2. Video search: “WebAssembly linear memory explained”:
   https://www.youtube.com/results?search_query=webassembly+linear+memory+explained

## Terms

1. <a id="term-linear-memory"></a>**Linear memory:** Contiguous byte-addressable memory used by Wasm programs.
2. <a id="term-page-wasm-memory-page"></a>**Page (Wasm memory page):** Fixed-size unit for Wasm memory growth (64 KiB per page).
3. <a id="term-data-segment"></a>**Data segment:** Static bytes copied into linear memory at initialization.
4. <a id="term-loadstore"></a>**Load/store:** Instructions that read/write values from/to memory.
5. <a id="term-oob-out-of-bounds-access"></a>**OOB (out-of-bounds) access:** Memory access outside valid linear-memory range.
