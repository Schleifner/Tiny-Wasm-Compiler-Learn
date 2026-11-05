# Chapter 01: Compile and run your first Wasm function

## Introduction

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

## Tips and best practices

1. Keep one disassembly command ready while debugging emitted binary blobs, for example:

```bash
aarch64-linux-gnu-objdump -D -b binary -m aarch64 raw_binary.bin
```

2. Disassembly Verification: Generate the binary first, then check it

```shell
printf '%s' 'FF 43 00 91' | xxd -r -p > /tmp/ret.bin
aarch64-linux-gnu-objdump -D -b binary -m aarch64 -EL /tmp/ret.bin
```

### From source code to machine code (mental model)

```text
C/C++ source (or WAT)
        |
        v
Wasm binary (.wasm bytes)
        |
        v
Parse + Decode
  - parse: split bytes into sections/opcodes
  - decode: turn encoded numbers/operands (e.g., LEB128) into usable values
        |
        v
Codegen decision
        |
        v
Arm64 assembly (human-readable intent, conceptual)
        |
        v
Arm64 machine code (actual bytes)
        |
        v
Allocate executable memory + copy bytes + set RX
        |
        v
Call function pointer and run
```

In this chapter, you mostly implement the lower half of the pipeline: parsing/decoding Wasm bytes, then emitting Arm64 machine-code bytes and executing them.

## Core references

1. Wasm concepts (beginner-friendly, MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Concepts
2. WAT syntax and examples (MDN): https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format
3. Reader-friendly Wasm manual: https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md
4. Official Wasm 1.0 spec (authoritative reference): https://webassembly.github.io/spec/versions/core/WebAssembly-1.0.pdf
5. LEB128 intro: https://en.wikipedia.org/wiki/LEB128
6. WABT online viewer: https://webassembly.github.io/wabt/demo/wat2wasm/
7. Arm64 instruction reference: https://developer.arm.com/documentation/ddi0596/2020-12/Base-Instructions?lang=en
8. A64 encoding index: https://developer.arm.com/documentation/ddi0602/2024-12/Index-by-Encoding/Data-Processing----Register
9. Arm64 online assembler/disassembler: https://shell-storm.org/online/Online-Assembler-and-Disassembler
10. `mmap`: https://man7.org/linux/man-pages/man2/mmap.2.html
11. `mprotect`: https://man7.org/linux/man-pages/man2/mprotect.2.html
12. Arm cache behavior for self-modifying code: https://developer.arm.com/documentation/den0013/d/Caches/Invalidating-and-cleaning-cache-memory
13. Local quick reference (added by you): [ARM_cheatsheet.pdf](./ARM_cheatsheet.pdf)
14. `objdump` binary disassembly (example command above): https://linux.die.net/man/1/aarch64-linux-gnu-objdump

## Extended reading

1. Capstone disassembly framework: https://github.com/capstone-engine/capstone
2. ArmConverter tool: https://armconverter.com
3. GitHub Arm64 runners announcement: https://github.blog/news-insights/product-news/arm64-on-github-actions-powering-faster-more-efficient-build-systems/
4. Video search (Wasm binary format for beginners): https://www.youtube.com/results?search_query=webassembly+binary+format+for+beginners
