# Introduction

In this chapter, the first Wasm module will be compiled.

## Task to do

1. Parser the wasm module byte by byte. Note: integers are encoded in [LEB128](https://en.wikipedia.org/wiki/LEB128)
2. Compile the opcode of the function `foo` to machine code.
3. Load the machine code to memory region with execute access.
4. Run the machine code.
5. Configure a CI pipeline with [CodeQualityRequirement](./CodeQualityRequirement.md). As a kind note, Github has recently added experimental support for arm64 runners, so it is also possible to skip qemu and run all natively. (https://github.blog/news-insights/product-news/arm64-on-github-actions-powering-faster-more-efficient-build-systems/)

## Docs

1. [Wasm 1.0 spec](https://webassembly.github.io/spec/versions/core/WebAssembly-1.0.pdf)
2. [Helpful tool to view wasm bytecode](https://webassembly.github.io/wabt/demo/wat2wasm/)
3. [Arm64 instruction set](https://developer.arm.com/documentation/ddi0596/2020-12/Base-Instructions?lang=en)
4. [Arm64 online assembler](https://shell-storm.org/online/Online-Assembler-and-Disassembler)
5. Arm64 instruction encoding can be summarized into several patterns. Detailed info can be found at [A64 instruction set encoding](https://developer.arm.com/documentation/ddi0602/2024-12/Index-by-Encoding/Data-Processing----Register).
6. Dump disassembly of emitted JIT code binary with [aarch64-linux-gnu-objdump](https://linux.die.net/man/1/aarch64-linux-gnu-objdump)(example `aarch64-linux-gnu-objdump -D -b binary -m aarch64 raw_binary.bin`) or [capstone](https://github.com/capstone-engine/capstone). There is also a nice website [Online Two-Way Converter](https://armconverter.com).
7. Manage memory permission on Linux/Posix: [mmap](https://man7.org/linux/man-pages/man2/mmap.2.html) [mprotect](https://man7.org/linux/man-pages/man2/mprotect.2.html)
8. **Important** Arm64 has separated [instruction cache and data cache](https://developer.arm.com/documentation/den0013/d/Caches/Invalidating-and-cleaning-cache-memory). This can impact the JIT code execution. For reader doesn't understand this item, please learn **Computer Organization and Architecture**.

## Learn target

1. Parse Wasm byte code
2. Emit Arm64 machine code
3. Memory permission on Linux
4. Ensure code quality with CodeQualityRequirement. Know basic C++ code quality measurements.
