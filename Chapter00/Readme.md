# Chapter 00: Foundations (WebAssembly + Arm64)

This chapter builds the minimum background needed for the rest of the project.

## Learning goals

By the end of this chapter, you should be able to:

1. Explain what [WebAssembly (Wasm)](#term-wasm) is and what [WAT](#term-wat) (text format) looks like.
2. Write and run small Wasm examples in Node.js.
3. Read and write basic Arm64 assembly.
4. Build and run [Arm64](#term-arm64) binaries (native or via [QEMU user mode](#term-qemu-user-mode)).
5. Debug Arm64 programs with [GDB (`gdb-multiarch`)](#term-gdb-multiarch)/VS Code.

## Task breakdown

### Part A: Wasm basics

1. Write two functions in WAT:
   1. `sum(1..n)` with `i32` input.
   2. Fibonacci sequence (example: `f(0)=0`, `f(1)=1`, `f(2)=1`, `f(3)=2`, `f(4)=3`, `f(5)=5`, `f(6)=8`).
2. Convert WAT to Wasm and run from Node.js.
3. Verify outputs with several test inputs (small, medium, edge cases).

### Part B: Arm64 basics

1. Re-implement the same two functions in Arm64 assembly.
2. Compile with an Arm64 toolchain.
3. Call assembly functions from C/C++.
4. Run with QEMU user mode if your host is not Arm64.
5. Debug with `gdb-multiarch` + VS Code.

### Part C: Debug setup (GDB + VS Code launch.json)

Use this as a starting point for remote/user-mode debugging (for example, QEMU + `gdbserver`):

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Debug Arm64",
      "type": "cppdbg",
      "request": "launch",
      "program": "${workspaceFolder}/<your_executable>",
      "cwd": "${workspaceFolder}",
      "MIMode": "gdb",
      "miDebuggerPath": "/usr/bin/gdb-multiarch",
      "miDebuggerArgs": "--nx",
      "miDebuggerServerAddress": "<TARGET_IP>:2345",
      "stopAtEntry": true,
      "externalConsole": false,
      "setupCommands": [
        {
          "description": "Disable debuginfod prompts",
          "text": "set debuginfod enabled off",
          "ignoreFailures": true
        },
        {
          "description": "Set architecture before connecting",
          "text": "set architecture aarch64",
          "ignoreFailures": true
        },
        {
          "description": "Set sysroot for dynamic linker and libc",
          "text": "set sysroot /usr/aarch64-linux-gnu",
          "ignoreFailures": true
        },
        {
          "description": "Enable pretty-printing",
          "text": "-enable-pretty-printing",
          "ignoreFailures": true
        }
      ]
    }
  ]
}
```

Quick checks:

1. Replace `<your_executable>` and `<TARGET_IP>`.
2. Ensure `gdb-multiarch` is installed and available at the configured path.
3. Make sure your target process is started with `gdbserver` on port `2345`.

## Study tips, tools, and best practices

1. Keep each function tiny at first; add complexity only after it works.
2. Always compare outputs between Wasm and Arm64 implementations.
3. Use disassembly tools early to confirm generated instructions.
4. Keep one reproducible build/run script per experiment.
5. Record assumptions ([ABI](#term-abi), register usage, stack alignment) in notes.

Recommended tools:

1. [wabt](https://github.com/webassembly/wabt) (`wat2wasm`, `wasm2wat`)
2. Node.js Wasm runtime support ([guide](https://nodejs.org/en/learn/getting-started/nodejs-with-webassembly))
3. Arm64 cross compiler + binutils
4. QEMU user mode
5. `gdb-multiarch` + VS Code launch config

## Knowledge checklist

Before moving to Chapter 01, confirm you understand:

1. Wasm module/function basics, value stack, and integer types.
2. WAT syntax for constants, locals, arithmetic, and exports.
3. Arm64 registers, `mov`/load/store/arithmetic/branch basics.
4. Difference between `b` and `bl`, and between `ret` and indirect branch.
5. Arm64 calling convention basics (arguments, return values, caller/callee-saved registers).

## Core references

1. WebAssembly overview: https://webassembly.org/
2. WAT format (MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format
3. Text-to-binary workflow: https://developer.mozilla.org/en-US/docs/WebAssembly/Text_format_to_Wasm
4. AArch64 overview (wiki): https://en.wikipedia.org/wiki/AArch64
5. Arm64 basic assembly tutorial: https://book.hacktricks.xyz/macos-hardening/macos-security-and-privilege-escalation/macos-apps-inspecting-debugging-and-fuzzing/arm64-basic-assembly
6. Running Arm binaries with QEMU: https://azeria-labs.com/arm-on-x86-qemu-user/
7. Arm64 ABI notes (reference): https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170
8. VS Code C/C++ launch config docs: https://code.visualstudio.com/docs/cpp/launch-json-reference

## Extended reading

1. QEMU intro article: https://medium.com/@cds.chamath/whats-qemu-c47c2d0297d3
2. Book: _Computer Organization and Design: ARM Edition_ (Patterson & Hennessy)
3. Video playlist (AArch64): https://www.youtube.com/results?search_query=aarch64+assembly+tutorial

## Terms

1. <a id="term-wasm"></a>**Wasm (WebAssembly):** A portable binary instruction format designed for safe and fast execution.
2. <a id="term-wat"></a>**WAT:** The human-readable text format of Wasm modules.
3. <a id="term-arm64"></a>**Arm64 / AArch64:** The 64-bit ARM instruction set architecture.
4. <a id="term-abi"></a>**ABI (Application Binary Interface):** Low-level calling rules (arguments, return values, register usage, stack layout).
5. <a id="term-qemu-user-mode"></a>**QEMU user mode:** Runs binaries for another CPU architecture without booting a full virtual machine.
6. <a id="term-gdb-multiarch"></a>**`gdb-multiarch`:** GDB build that can debug programs for multiple CPU architectures.
7. <a id="term-sysroot"></a>**`sysroot`:** Directory that provides target runtime libraries/symbols for cross-debugging.
