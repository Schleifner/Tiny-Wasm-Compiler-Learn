# Introduction

This chapter will add function call between Wasm functions.

## Task to do

1. Design Wasm-to-Wasm calling convention. Don't need to consider calling imported functions in this chapter.
2. Implement `type` section of Wasm.
3. Implement call instruction.
4. Pass [all test cases](./test)
5. Add test into CI pipeline

## Doc

1. [Procedure Call Standard for the Arm 64-bit Architecture](https://github.com/ARM-software/abi-aa/blob/a82eef0433556b30539c0d4463768d9feb8cfd0b/aapcs64/aapcs64.rst)
2. [Symbol table](https://medium.com/ax1al/a-brief-info-on-linker-loader-symbol-symbol-tables-2fed729eb490) is widely used for link call address.

## Learn target

1. Understand call instruction of Wasm.
2. Understand bl instruction and link register of arm64.
3. Understand context, volatile/non-volatile registers and calling convention.
4. Understand how to link dist address of call instructions.
