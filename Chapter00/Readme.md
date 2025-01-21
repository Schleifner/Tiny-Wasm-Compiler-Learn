# Introduction

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
      "type": "gdb",
      "request": "attach",
      "name": "Debug arm64",
      "miDebuggerPath": "/usr/bin/gdb-multiarch",
      "executable": "your_executable",
      "target": "<TARGET_IP>:2345",
      "remote": true,
      "cwd": "${workspaceRoot}",
      "valuesFormatting": "parseText"
    }
  ]
}
```
   
## Learn target

After this section, the following knowledge should be acquired.

1. Registers of arm64
2. Basic instructions of arm64
3. How to use gcc arm64 compiler
4. Run arm64 program in qemu
5. Debug arm64 program in vscode
6. C ABI of arm64

## Extended read

1. What is [qemu](https://medium.com/@cds.chamath/whats-qemu-c47c2d0297d3)
