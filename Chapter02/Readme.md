# Chapter 02: Locals and parameter handling

This chapter adds local variable support and makes function execution stateful.

## Learning goals

1. Understand Wasm [parameters](#term-parameter) vs. [locals](#term-local-variable).
2. Implement [`local.get/set/tee`](#term-local-get-set-tee).
3. Design a runtime layout for function-local state.
4. Build automated tests from `.wast` inputs with [`wast2json`](#term-wast2json).

## Task breakdown

1. Convert [`local.wast`](./test/local.wast) to `.wasm` and JSON using `wast2json`.
2. Extend module/runtime metadata:
   1. Map exported function names to JIT entry addresses.
   2. Add local-variable storage strategy for each function [frame](#term-frame-call-frame).
3. Implement local-related opcodes in codegen/runtime.
4. Use [`gtest`](#term-gtest-googletest) to execute wast-based test vectors and expected assertions.
5. Add these tests to CI.

## Study tips, tools, and best practices

1. Keep a clear distinction between value stack data and local slots.
2. Document index mapping rules (`param` indices come before extra locals).
3. Prefer table-driven tests from wast JSON output.
4. Validate both positive and negative values for integer locals.
5. Keep ABI assumptions explicit at the C++/JIT boundary.

## Beginner guide: how to bridge Wasm to Arm64

If you already can convert `.wast -> .wasm/.json` but feel stuck at `wasm -> Arm64`, use this workflow:

1. Treat `.json` as a **test driver**, not codegen input; your codegen source of truth is the Wasm function body bytes/opcodes.
2. Build a tiny [`opcode mapping table`](#term-opcode-mapping-table) for this chapter only:
   1. `local.get` -> load local/param value into a working register.
   2. `local.set` -> store top stack value into local slot.
   3. `local.tee` -> store to local slot and keep value on Wasm value stack.
3. Implement one opcode at a time, and for each opcode keep three views side by side:
   1. Wasm instruction stream
   2. Expected Arm64 assembly intent
   3. Emitted machine-code bytes
4. Use a strict debug loop:
   1. Parse and print decoded instructions.
   2. Emit bytes.
   3. Disassemble emitted bytes.
   4. Compare against expected behavior from test case.
5. Start with one-function minimal examples and only then run full chapter tests.

### Practical checkpoint strategy (recommended)

1. First make `local.get` pass all basic tests.
2. Then add `local.set`.
3. Finally add `local.tee`.
4. Only after all pass, refactor shared code paths.

### Why this feels hard (and how to reduce the pain)

1. Wasm is stack-based, Arm64 is register-based: you need an explicit value-stack model in runtime/codegen.
2. One Wasm opcode may expand to multiple Arm64 instructions.
3. Bugs often come from slot/index mismatch, not from instruction encoding itself.

To reduce friction, always print:

1. local index
2. resolved slot offset
3. chosen registers
4. emitted bytes range per opcode

## Knowledge checklist

1. Wasm local declaration encoding.
2. Semantics of `local.get`, `local.set`, `local.tee`.
3. Function frame design for a JIT.
4. Basic Arm64 load/store patterns for locals.
5. Test harness design for spec-style cases.

## Core references

1. `wast2json` docs: https://github.com/WebAssembly/wabt/blob/main/docs/wast2json.md
2. nlohmann/json: https://github.com/nlohmann/json.git
3. GoogleTest: https://github.com/google/googletest
4. CMake `FindGTest`: https://cmake.org/cmake/help/latest/module/FindGTest.html
5. `wasm2wat` / `wasm-objdump` (WABT tools): https://github.com/WebAssembly/wabt
6. Compiler Explorer (check equivalent Arm64 codegen ideas): https://godbolt.org/
7. Capstone disassembly engine: https://github.com/capstone-engine/capstone
8. Arm64 instruction reference: https://developer.arm.com/documentation/ddi0596/latest

## Extended reading

1. WebAssembly spec tests repository: https://github.com/WebAssembly/testsuite
2. Video search for “Wasm stack machine execution model”:
   https://www.youtube.com/results?search_query=webassembly+stack+machine+explained
3. Video search for “Wasm to machine code / JIT internals”:
   https://www.youtube.com/results?search_query=webassembly+jit+compiler+internals
4. Reader-friendly Wasm manual:
   https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md

## Terms

1. <a id="term-parameter"></a>**Parameter (`param`):** Input value passed into a function.
2. <a id="term-local-variable"></a>**Local variable (`local`):** Function-scoped temporary storage.
3. <a id="term-frame-call-frame"></a>**Frame (call frame):** Runtime data structure holding per-call state (locals, metadata, etc.).
4. <a id="term-local-get-set-tee"></a>**`local.get/set/tee`:** Wasm instructions to read, write, and write+keep local values.
5. <a id="term-wast2json"></a>**`wast2json`:** Tool that converts `.wast` script tests into machine-readable JSON + wasm artifacts.
6. <a id="term-gtest-googletest"></a>**`gtest` (GoogleTest):** C++ unit testing framework.
7. <a id="term-opcode-mapping-table"></a>**Opcode mapping table:** A small table that maps each Wasm opcode to its target Arm64 codegen pattern.
