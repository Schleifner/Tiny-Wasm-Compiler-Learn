# Chapter 12: Stack overflow protection

This chapter hardens the runtime by preventing unbounded [stack](#term-call-stack) growth from crashing the host process.

## Learning goals

1. Track stack usage during Wasm execution.
2. Enforce stack limits before growth.
3. Convert [stack overflow](#term-stack-overflow) into a controlled [trap](#term-stack-overflow-trap).
4. Integrate stack-safety checks with existing trap infrastructure.

## Task breakdown

1. Define per-execution stack limit policy.
2. Insert stack-growth checks in function entry/[prologue](#term-prologue) path.
3. Add [stack overflow trap](#term-stack-overflow-trap) code and host-visible error reporting.
4. Add tests for:
   1. Safe recursion/stack growth
   2. Overflow-triggering deep call chains
5. Keep full CI passing.

## Study tips, tools, and best practices

1. Keep stack limit checks deterministic and low overhead.
2. Use clear separation between native stack and Wasm logical stack concepts.
3. Add stress tests for deep call depth.
4. Avoid relying only on OS crashes/signals for safety.

## Knowledge checklist

1. Thread stack allocation by operating systems.
2. [Guard pages](#term-guard-page) and segmentation faults.
3. Practical stack-overflow mitigation in runtime systems.
4. Trap propagation consistency.

## Core references

1. Stack overflow and segfault basics:
   https://en.wikipedia.org/wiki/Segmentation_fault#Stack_overflow
2. Stack layout and guard page explanation:
   https://devblogs.microsoft.com/oldnewthing/20220203-00/?p=106215
3. General stack memory background:
   https://en.wikipedia.org/wiki/Call_stack

## Extended reading

1. Runtime safety engineering patterns:
   https://safecode.org/
2. Video search: “guard page stack overflow explained”:
   https://www.youtube.com/results?search_query=guard+page+stack+overflow+explained

## Terms

1. <a id="term-call-stack"></a>**Call stack:** Per-thread memory region used for function-call frames.
2. <a id="term-stack-overflow"></a>**Stack overflow:** Exceeding available stack space during deep/large call usage.
3. <a id="term-guard-page"></a>**Guard page:** Protected memory page used to detect stack overrun.
4. <a id="term-prologue"></a>**Prologue:** Function-entry instruction sequence that prepares stack/register state.
5. <a id="term-stack-overflow-trap"></a>**Stack overflow trap:** Controlled runtime error reported instead of process crash.
