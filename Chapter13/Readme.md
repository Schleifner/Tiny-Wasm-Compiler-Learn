# Introduction

This chapter will add import native function call. WebAssembly is a sandbox, when it need to use resources out of the sandbox, for example the file system, it need to call an imported native function.

Moreover, in real engineering projects, Wasm is usually compiled from frontend programming languages, such as C/C++, rust and AssemblyScript. This chapter uses clang to compile C to Wasm.

## Task to do

1. Support import function<br/>
   1.1 Support import section of Wasm.<br/>
   1.2 Design how to link Wasm call with C function.<br/>
   1.3 Call native function with C ABI.<br/>

2. Compile the [test/myPrint.c](./test/myPrint.c) to Wasm which [Wasi-SDK](https://github.com/WebAssembly/wasi-sdk). Example Compile command `/opt/wasi-sdk/bin/clang -fdata-sections -ffunction-sections -mcpu=mvp -mmutable-globals -Wl,--allow-undefined,--export-table,--gc-sections,--no-entry,--export=_start -lstdc++ -z stack-size=8192 -nostartfiles -o build/main.wasm main.c`
3. Run the `_start` function of the Wasm, and output the print message both to console and a log file.
4. Assert the content in the log file.
5. Add the test to CI pipeline.

## Doc

1. [WebAssembly with different languages](https://enarx.dev/docs/WebAssembly/Introduction)
2. [Pay attention to stack alignment when calling C API](https://community.arm.com/arm-community-blogs/b/architectures-and-processors-blog/posts/using-the-stack-in-aarch32-and-aarch64)

## Learn target

1. Basic usage of Wasi-SDK.
2. Understand C memory layout and C variadic mapped to Wasm memory layout.
3. Understand import section of Wasm.
4. Understand calling C function from JIT code.
