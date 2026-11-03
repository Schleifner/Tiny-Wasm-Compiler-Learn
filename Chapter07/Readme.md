# Chapter 07: Looping (`loop`)

This chapter adds iterative control flow and backward branches.

## Learning goals

1. Implement Wasm [`loop`](#term-loop).
2. Generate correct [backward jumps / back-edges](#term-backward-jump-back-edge) in Arm64.
3. Reuse branch depth infrastructure from Chapter 06.
4. Validate loop correctness and termination behavior.

## Task breakdown

1. Add `loop` block handling in your label/control stack.
2. Ensure `br`/`br_if` can target [loop headers](#term-loop-header) correctly.
3. Add tests for:
   1. Counting loops
   2. Early exits
   3. Nested loops and blocks
4. Add/maintain CI coverage.

## Study tips, tools, and best practices

1. Confirm loop-target offsets with disassembly.
2. Test both short and long loop bodies.
3. Add guard tests to catch accidental infinite loops.
4. Keep loop entry and exit stack contracts explicit.

## Knowledge checklist

1. Wasm `loop` semantics (branch-to-loop means continue).
2. [Backward jump / back-edge](#term-backward-jump-back-edge) encoding constraints on Arm64.
3. Interactions between loop labels and outer block labels.

## Core references

1. Wasm control flow docs (loop): https://developer.mozilla.org/en-US/docs/WebAssembly/Reference/Control_flow/loop
2. Arm64 branch instruction docs:
   https://developer.arm.com/documentation/ddi0596/latest

## Extended reading

1. Compiler [CFG](#term-cfg-control-flow-graph) basics (loops and back-edges):
   https://en.wikipedia.org/wiki/Control-flow_graph
2. Video search: “Wasm loop br br_if explained”:
   https://www.youtube.com/results?search_query=wasm+loop+br+br_if+explained

## Terms

1. <a id="term-loop"></a>**`loop`:** Wasm control construct whose branch target points to the loop header.
2. <a id="term-backward-jump-back-edge"></a>**Backward jump / back-edge:** A branch to an earlier instruction, typically forming a loop.
3. <a id="term-loop-header"></a>**Loop header:** The entry point instruction block for a loop.
4. <a id="term-cfg-control-flow-graph"></a>**CFG (Control-Flow Graph):** Graph model of possible execution paths between basic blocks.
