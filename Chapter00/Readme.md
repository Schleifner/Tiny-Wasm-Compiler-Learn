# Chapter 00: Foundations (WebAssembly + Arm64)

## Introduction

This Chapter provide beginner guide about Wasm and Arm64.

## Getting Start with WebAssembly

WebAssembly is already widely used in browser and nodejs.
To get a general understanding of WebAssembly, please visit the [WebAssembly official website](https://webassembly.org/).

Then learn about what is [wat](https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format)

## Tasks to do

1. Implement following Wasm functions with wat. [Doc](https://developer.mozilla.org/en-US/docs/WebAssembly/Text_format_to_Wasm)<br/>
   1.1 calculate sum of 1 to n, n is i32 type<br/>
   1.2 Fibonacci sequence<br/>
2. Run the functions with nodejs. [Doc](https://nodejs.org/en/learn/getting-started/nodejs-with-webassembly)

## Learn target

After this section, the following knowledge needs to be acquired

1. Basic knowledge with Wasm and Wat
2. How to install and use [wabt](https://github.com/webassembly/wabt)

Recommended tools:

1. [wabt](https://github.com/webassembly/wabt) (`wat2wasm`, `wasm2wat`)
2. Node.js Wasm runtime support ([guide](https://nodejs.org/en/learn/getting-started/nodejs-with-webassembly))
3. Arm64 cross compiler + binutils
4. QEMU user mode
5. `gdb-multiarch` + VS Code launch config

## Getting start with Arm64

Arm64, also called aarch64, is an instruction set. For developers don't know this, refer to this [wiki](https://en.wikipedia.org/wiki/AArch64)

## Tasks to do

1. Implement following Wasm functions with arm64 asm.[Doc](https://book.hacktricks.xyz/macos-hardening/macos-security-and-privilege-escalation/macos-apps-inspecting-debugging-and-fuzzing/arm64-basic-assembly)<br/>
   1.1 calculate sum of 1 to n, n is i32 type<br/>
   1.2 Fibonacci sequence<br/>
2. Compile the asm with arm64 gcc.[Doc](https://azeria-labs.com/arm-on-x86-qemu-user/)
3. Call the asm functions from C. [Doc](https://learn.microsoft.com/en-us/cpp/build/arm64-windows-abi-conventions?view=msvc-170)
4. Run the code with qemu user mode emulator.
5. Setup gdb debugger and vscode launch.json to debug the program running in qemu. [Doc](https://code.visualstudio.com/docs/cpp/launch-json-reference)<br/>
   demo launch.json.

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
          "description": "Do not prompt for debuginfod",
          "text": "set debuginfod enabled off",
          "ignoreFailures": true
        },
        {
          "description": "Set AArch64 before connecting",
          "text": "set architecture aarch64",
          "ignoreFailures": true
        },
        {
          "description": "Find the AArch64 dynamic linker and libc",
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

## Learn target

After this section, the following knowledge should be acquired.

1. Registers of arm64
2. Basic instructions of arm64, including register mov instructions, memory load/store, basic arithmetic instructions, branch instructions, difference between b and bl instruction, ret and br instruction
3. How to use gcc arm64 compiler
4. Run arm64 program in qemu
5. Debug arm64 program in vscode
6. C ABI of arm64

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
