# Chapter 13: Imported native functions

This chapter connects Wasm code to [host functions](#term-host-function) ([sandbox boundary](#term-sandbox-boundary) crossing).

## Learning goals

1. Parse and register [import functions](#term-import-function).
2. Link Wasm call sites to host C/C++ function pointers.
3. Call native functions with correct ABI and [stack alignment](#term-stack-alignment).
4. Compile C source to Wasm with [WASI](#term-wasi-webassembly-system-interface) SDK and execute `_start`.

## Task breakdown

1. Implement import section handling.
2. Build an import registry (module + name -> [host function](#term-host-function) metadata).
3. Implement Wasm-to-native call bridge with ABI-safe argument passing.
4. Compile [`test/myPrint.c`](./test/myPrint.c) using WASI-SDK.
5. Run `_start`, print to console and file, and assert expected log output.
6. Add test coverage to CI.

## Study tips, tools, and best practices

1. Define strict type/signature matching for imports.
2. Keep host-call bridge minimal and auditable.
3. Validate stack alignment at each native call boundary.
4. Build deterministic integration tests (same inputs, same log file content).
5. Version and document your import registry format.
6. Keep a reproducible WASI-SDK compile command example for quick experiments:

```bash
/opt/wasi-sdk/bin/clang \
  -fdata-sections -ffunction-sections -mcpu=mvp -mmutable-globals \
  -Wl,--allow-undefined,--export-table,--gc-sections,--no-entry,--export=_start \
  -lstdc++ -z stack-size=8192 -nostartfiles \
  -o build/main.wasm main.c
```

## Knowledge checklist

1. Wasm import section semantics.
2. WASI SDK compile flow from C to Wasm.
3. Arm64 C ABI and stack alignment rules.
4. Host sandbox boundary and security implications.

## Core references

1. WASI SDK: https://github.com/WebAssembly/wasi-sdk
2. WebAssembly language ecosystem intro:
   https://enarx.dev/docs/WebAssembly/Introduction
3. Arm stack alignment guidance:
   https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/using-the-stack-in-aarch32-and-aarch64
4. Wasm imports reference (MDN):
   https://developer.mozilla.org/en-US/docs/WebAssembly/Understanding_the_text_format#importing_functions_from_javascript

## Extended reading

1. WASI design overview:
   https://github.com/WebAssembly/WASI
2. Video search: “WASI SDK tutorial”:
   https://www.youtube.com/results?search_query=wasi+sdk+tutorial

## Terms

1. <a id="term-import-function"></a>**Import function:** Function declared in Wasm but implemented by the host runtime.
2. <a id="term-host-function"></a>**Host function:** Native C/C++ function callable from Wasm.
3. <a id="term-wasi-webassembly-system-interface"></a>**WASI (WebAssembly System Interface):** Standardized system-like APIs for Wasm runtimes.
4. <a id="term-stack-alignment"></a>**Stack alignment:** Required stack address alignment before function calls (ABI requirement).
5. <a id="term-sandbox-boundary"></a>**Sandbox boundary:** Safety boundary between untrusted Wasm code and host system resources.
