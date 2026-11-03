# Chapter 05: Division and traps

This chapter introduces runtime [traps](#term-trap) and error propagation from JIT code.

## Learning goals

1. Implement signed/unsigned division instructions (`[div_s / div_u](#term-div_s-div_u)`).
2. Detect divide-by-zero and [signed overflow](#term-signed-overflow) trap conditions.
3. Stop JIT execution safely when traps occur.
4. Return trap information to the host C++ runtime.

## Task breakdown

1. Implement [`div_s` and `div_u`](#term-div_s-div_u).
2. Add pre-checks:
   1. Divisor is zero.
   2. Signed overflow case (for example min-int / -1).
3. Design trap exit path from generated code.
4. Extend runtime API to return trap code/state.
5. Add tests for all trap and non-trap scenarios.
6. Keep CI up to date.

## Study tips, tools, and best practices

1. Treat trap handling as a core runtime contract, not a side path.
2. Keep trap codes explicit and stable.
3. Separate “compute” code path from “trap” code path for readability.
4. Add targeted tests for each trap reason.
5. Ensure host-side assertions verify both result and trap metadata.

## Knowledge checklist

1. Wasm integer division semantics.
2. Signed overflow behavior with two’s complement.
3. [Non-local control transfer](#term-non-local-control-transfer) concepts ([`setjmp`/`longjmp`](#term-setjmp-longjmp)) or equivalent strategy.
4. ABI-safe return of status/trap information.

## Core references

1. [`setjmp`](#term-setjmp-longjmp) (glibc AArch64 source): https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/setjmp.S
2. [`longjmp`](#term-setjmp-longjmp) (glibc AArch64 source): https://github.com/lattera/glibc/blob/master/sysdeps/aarch64/__longjmp.S
3. Reader-friendly Wasm manual:
   https://github.com/sunfishcode/wasm-reference-manual/blob/master/WebAssembly.md
4. Wasm numeric/trap behavior (spec): https://webassembly.github.io/spec/core/

## Extended reading

1. Error handling patterns in VM/runtime design:
   https://craftinginterpreters.com/
2. Video search: “setjmp longjmp explained in C”:
   https://www.youtube.com/results?search_query=setjmp+longjmp+explained

## Terms

1. <a id="term-trap"></a>**Trap:** Runtime error condition that must stop normal instruction execution.
2. <a id="term-div_s-div_u"></a>**`div_s` / `div_u`:** Signed and unsigned integer division instructions.
3. <a id="term-signed-overflow"></a>**Signed overflow:** Result exceeds representable signed range (for example min-int / -1 case).
4. <a id="term-setjmp-longjmp"></a>**`setjmp` / `longjmp`:** C control-flow mechanism for non-local jumps.
5. <a id="term-non-local-control-transfer"></a>**Non-local control transfer:** Exiting current execution context without normal return chaining.
