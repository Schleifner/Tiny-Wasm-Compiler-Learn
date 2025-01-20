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
6. [Optional] Compile with clang and debug with lldb. There is a nice extension called [codelldb](https://github.com/vadimcn/codelldb/blob/master/MANUAL.md) to support native lldb debugging on vscode. Shown below is an example for setting up codelldb debugging. It is also possible for codelldb to support reverse debugging, refer to the manual for details.

Launch.json

```json
{
   "name": "LLDB Arm64 active",
   "type": "lldb",
   "sourceLanguages": [
       "cpp"
   ],
   "request": "custom",
   "preLaunchTask": "debug active",
   "targetCreateCommands": [
       "target create ${fileDirname}/${fileBasenameNoExtension}"
   ],
   "processCreateCommands": [
       "gdb-remote localhost:1234"
   ],
   "initCommands": [
       "process handle SIGTRAP -s false"
   ]
}
```

Tasks.json
```json
{
   "label": "make build active",
   "command": "make",
   "args": [
       "build",
       "curFile=${fileDirname}/${fileBasenameNoExtension}"
   ],
   "type": "process",
   "problemMatcher": [
       "$gcc"
   ]
},
{
   "label": "make qemu-static-active",
   "command": "make",
   "args": [
       "qemu-gdb",
       "curFile=${fileDirname}/${fileBasenameNoExtension}"
   ],
   "type": "process",
   "isBackground": true,
   "problemMatcher": [
       {
           "pattern": [
               {
                   "regexp": ".",
                   "file": 1,
                   "location": 2,
                   "message": 3
               }
           ],
           "background": {
               "activeOnStart": true,
               "beginsPattern": ".",
               "endsPattern": "."
           }
       }
   ]
},
{
   "label": "debug active",
   "dependsOrder": "sequence",
   "dependsOn": [
       "make build active",
       "make qemu-static-active"
   ]
},
```

Makefile
```makefile
.PHONY: build qemu-gdb clean
build:
	/usr/bin/clang++ --target=aarch64-linux-gnu -g ${curFile}.cpp -o ${curFile}
qemu-gdb: 
	qemu-aarch64 -g 1234 -L /usr/aarch64-linux-gnu ${curFile}
```

7. [Optional] Set up systemd-binfmt and chroot arm64 for a transparent emulation process. Note that systemd-binfmt is not well supported on WSL, because it will break WSLinterop (https://github.com/ubuntu/WSL/issues/334), so currently it is recommended only on real virtual machines, though there are workarounds exist. Check the issue page for detail. 
   
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
