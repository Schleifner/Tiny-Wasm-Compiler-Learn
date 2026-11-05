# What's this repository

This repository contains training materials and learning path about developing a WebAssembly JIT compiler for a beginner.
But this repository doesn't contain any compiler implementation.

For beginners of WebAssembly compilers, the following issues are commonly encountered:

1. I am very interested in compilers, but production-level compilers are too complex and not suitable for beginners to learn.
2. The WebAssembly standard is extensive, and reading it line by line can be tedious and obscure.
3. The knowledge required for compiler development is vast, making it difficult to know where to start.

This repo aims to provide a smooth learning curve for beginners, allowing developers with no compiler experience to gradually learn the basics of WebAssembly compiler development.

## Who is the reader of this repository

Beginner developers who are interested at WebAssembly & compiler and want to start working this domain.

See 🏆 [HALL-OF-FAME](finished_projects.md) 🏆 for an overview of people following this tutorial and their individual solutions.

## Learning target of this repository

Develop a tiny **Wasm 1.0** JIT compiler for **arm64** with cmake and **C++ 14**. With following features:

1. Module parser
2. Export function call
3. Local variables
4. Arithmetic operation
5. Control flow instructions
6. Direct function call
7. Indirect function call
8. Global variable
9. Linear memory
10. Import/Export function call

### Out of scope:

1. Validation of the Wasm Module
2. Floating point instructions

#### Engineering requirement:

1. Use Cmake 3.10+
2. Use the [.clang-format](./clang-format) for code format. [Doc](https://clang.llvm.org/docs/ClangFormat.html)
3. Use the [.clang-tidy](./clang-tidy) for linter. [Doc](https://clang.llvm.org/extra/clang-tidy/)
4. Enable the warning flags of of gcc `-Wall -Wextra -Wpedantic  -Wformat=2
-Wformat-security -Werror=format-security -Wcast-align -Wcast-qual -Wconversion
-Wdouble-promotion -Wfloat-equal -Wmissing-include-dirs
-Wredundant-decls -Wshadow -Wsign-conversion -Wswitch -Wuninitialized
-Wunused-parameter -Walloca -Wunused-result -Wunused-local-typedefs
-Wwrite-strings -Wpointer-arith -Wfloat-conversion -Wnull-dereference -Wdiv-by-zero
-Wswitch-default -Wno-switch-bool -Wunknown-pragmas -Werror`

### Pre-commit checks (cspell + prettier)

Use this helper script before each commit:

1. Check only:
   ```bash
   ./scripts/pre-commit-check.sh check
   ```
   (CI-parity mode, same as `./scripts/pre-commit-check.sh ci`)
2. Auto-fix formatting + run checks:
   ```bash
   ./scripts/pre-commit-check.sh fix
   ```
3. Add project-specific dictionary words while fixing:
   ```bash
   ./scripts/pre-commit-check.sh fix --add-word yourWord anotherWord
   ```

Notes:

1. The script is aligned with CI workflow versions: **cspell@8** and **prettier@3**.
2. CI and local script both target `**/*.md`.
3. `prettier` will auto-format files in `fix` mode.
4. `cspell` checks spelling but does not auto-correct typos.
5. The script warns if your local Node.js major version differs from CI (`18`).

### FAQ

1. Why chose arm64 instruction set?
   Arm64 and x86_64 are most often used instruction set on consumer electronics. Since x86_64 instruction encoding is complex, arm64 is more friendly for beginner
2. Why use C++ 14?
   C++ is the most classic system-level programming language. It's friendly to interacting with operating system and JIT code. In meanwhile, it's more powerful than C. Using version 14 is due to some embedded compiler doesn't support C++17 and further.
3. Which operating system and compiler to use?
   No limit here. But some guide of this repo may assume developers are developing on a x86_64 Ubuntu 24.04 or later with gcc-arm64 cross compiler and testing with qemu user mode emulator. If someone is not using this setup, some steps need to be adapted.

## Prerequisite knowledge

1. As a compiler developer, **Compiler principle** is the core knowledge
2. Emit machine code need solid knowledge about **Computer Organization and Architecture**
3. Load JIT code need to interaction with operating system, so **Principles of Operating Systems** is also necessary

For developers who have not systematically studied these principles in university or have not learned them thoroughly, it is strongly required to study or revise them.
In [Learning_Materials](./Learning_Materials) there are some recommended curses

## What to do Next

For developers without basic knowledge of Wasm and arm64, start with [Chapter 00](./Chapter00/).

Otherwise, start with [Chapter 01](./Chapter01/), and then implement the compiler chapter by chapter

## Overview map

### What you can do after finishing this repository

1. Parse core Wasm 1.0 module structures and execute exported functions.
2. Build a tiny Arm64-oriented JIT pipeline (decode -> codegen -> executable memory -> run).
3. Implement key integer/control/runtime features: locals, arithmetic, branches, calls, table-based indirect calls, globals, linear memory, imports, and basic traps.
4. Build a test-driven workflow using chapter test cases and CI/code-quality constraints.

### What is intentionally not covered here

1. Full Wasm validation engine.
2. Floating-point instruction support.
3. Advanced optimization passes (SSA-based IR optimization, register allocation quality tuning, instruction scheduling).
4. Production features such as GC integration, full sandbox hardening, tiered JIT/AOT strategies, and multi-architecture backends.

### What to learn next (with resources)

1. Wasm validation and semantics deep dive:
   1. https://webassembly.github.io/spec/core/
   2. https://github.com/WebAssembly/testsuite
2. Production-grade runtime/codegen architecture:
   1. https://github.com/bytecodealliance/wasmtime
   2. https://github.com/bytecodealliance/wasmtime/tree/main/cranelift
3. Compiler optimization foundations:
   1. _Engineering a Compiler_ (Cooper & Torczon)
   2. _Compilers: Principles, Techniques, and Tools_ (Aho et al.)
4. JIT/runtime engineering practice:
   1. https://v8.dev/blog
   2. https://bytecodealliance.org/articles
5. Video resources:
   1. MIT 6.035 (Compiler course): https://www.youtube.com/watch?v=9p_s457RSQE
   2. Carnegie Mellon 15-213 / 18-213 (Computer Systems): https://www.youtube.com/watch?v=ScMxnXq6fbI&list=PLcQU3vbfgCc9sVAiHf5761UUApjZ3ZD3x
   3. AArch64 assembly tutorials (search collection): https://www.youtube.com/results?search_query=aarch64+assembly+tutorial
   4. WebAssembly internals talks (search collection): https://www.youtube.com/results?search_query=webassembly+compiler+internals
6. Wiki / encyclopedia resources:
   1. WebAssembly (wiki): https://en.wikipedia.org/wiki/WebAssembly
   2. AArch64 (wiki): https://en.wikipedia.org/wiki/AArch64
   3. Compiler (wiki): https://en.wikipedia.org/wiki/Compiler
   4. Just-in-time compilation (wiki): https://en.wikipedia.org/wiki/Just-in-time_compilation
   5. Register allocation (wiki): https://en.wikipedia.org/wiki/Register_allocation

## Chapter-by-chapter goals

| Chapter                            | Goal                                                                                                             |
| ---------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| [Chapter00](./Chapter00/Readme.md) | Build baseline knowledge in Wasm/WAT, Arm64 assembly, toolchain, QEMU, and debugging setup.                      |
| [Chapter01](./Chapter01/Readme.md) | Implement first end-to-end path: parse Wasm bytes, emit Arm64 machine code, allocate executable memory, and run. |
| [Chapter02](./Chapter02/Readme.md) | Add parameter/local handling and implement `local.get/set/tee` with test-driven validation.                      |
| [Chapter03](./Chapter03/Readme.md) | Add integer arithmetic instructions and strengthen instruction-selection/codegen debugging workflow.             |
| [Chapter04](./Chapter04/Readme.md) | Implement conditional execution (`if/else` + compare + `nop`) with patchable control-flow targets.               |
| [Chapter05](./Chapter05/Readme.md) | Implement division plus runtime traps (divide-by-zero/overflow) and host-visible trap propagation.               |
| [Chapter06](./Chapter06/Readme.md) | Implement `block/br/br_if/drop` and reason about structured branching via label depth.                           |
| [Chapter07](./Chapter07/Readme.md) | Implement `loop` and backward branches, including nested loop-control behavior.                                  |
| [Chapter08](./Chapter08/Readme.md) | Implement direct Wasm-to-Wasm calls with type-section support and a stable calling convention.                   |
| [Chapter09](./Chapter09/Readme.md) | Implement tables, elements, and `call_indirect` with bounds/signature checks and traps.                          |
| [Chapter10](./Chapter10/Readme.md) | Implement global variables (`global.get/set`) and global runtime layout.                                         |
| [Chapter11](./Chapter11/Readme.md) | Implement linear memory, data segments, memory access/growth, and out-of-bounds trap handling.                   |
| [Chapter12](./Chapter12/Readme.md) | Add stack-overflow protection and convert unsafe growth into controlled runtime traps.                           |
| [Chapter13](./Chapter13/Readme.md) | Implement imported native function calls (host bridge, ABI correctness, WASI-SDK integration).                   |
