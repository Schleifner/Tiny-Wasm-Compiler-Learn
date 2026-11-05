# Arm Instruction Documentation Quick Guide (Beginner-Friendly)

This guide helps you use the official Arm instruction documentation efficiently during experiments, especially when moving from Wasm semantics to Arm64 instructions and machine code.

Primary reference:

- Arm Base Instructions (A64): https://support.arm.com/documentation/ddi0602/2026-09/Base-Instructions?lang=en

## 1. Practical way to use the Arm docs

When you need an instruction (for example `ADD`, `SUB`, `MUL`), do this in order:

1. Open the instruction page by mnemonic (`ADD (immediate)` vs `ADD (shifted register)` are different pages).
2. Read only these sections first:
   1. **Mnemonic/Variant name**
   2. **Encoding diagram**
   3. **Assembler syntax**
   4. **Operation / pseudocode**
3. Confirm your operand kinds:
   1. Register or immediate?
   2. 32-bit (`W`) or 64-bit (`X`)?
   3. Shift/extend needed or not?
4. Encode fields one by one (do not encode the whole line mentally at once).
5. Verify the emitted bytes with disassembly (`objdump` / `capstone`).

Tip: for beginners, always start from assembler syntax + examples, then return to encoding bits.

Important: on each instruction page, the **Assembler Symbols** section is where Arm explains placeholders like
`<Wd|WSP>`, `<Xn|SP>`, `<R><m>`, `<imm>`, `<shift>`, and `<extend>`.
For this repo, read that section every time before you map Wasm operands to registers/immediates.

## 2. How to quickly locate what you need

Use this lookup pattern:

1. First decide **intent** (add/sub/mul/load/store/branch).
2. Then decide **operand form**:
   1. immediate
   2. register
   3. shifted register
   4. extended register
3. Search by `Mnemonic + form` (example: `ADD shifted register`).
4. If multiple variants exist, prefer the simplest variant that matches your codegen pattern.

## 3. Field glossary (the confusing symbols)

These names appear in encoding diagrams and syntax descriptions.

| Field                                         | Meaning (beginner-friendly)                                                                                      | Typical values                                           |
| --------------------------------------------- | ---------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------- |
| `op`                                          | Main operation selector bit(s) inside one instruction family. Often chooses add vs sub, signed vs unsigned, etc. | `0/1` (or bit group)                                     |
| `opc`                                         | Secondary opcode selector. Usually refines `op` to choose a concrete variant inside one encoding family.         | small bit group (for example 2~3 bits)                   |
| `op0` / `op1` / `op2` / `op3`                 | Hierarchical opcode groups used in many decode tables (especially system/branch classes).                        | bit groups, class-specific                               |
| `S`                                           | “Set flags” control. If set, instruction updates condition flags (`NZCV`).                                       | `0` no flags, `1` set flags                              |
| `N` / `U` / `L` / `Q` / `size`                | Family-level mode bits. Depending on instruction class they can mean negate/unsigned/load/quad/element size.     | class-specific control bits                              |
| `opt` / `option`                              | Operand transform option (usually register extend/arrangement mode depending on instruction class).              | instruction-specific                                     |
| `shift` / `extend`                            | Shift/extend kind used on register operands before the ALU operation.                                            | `LSL/LSR/ASR` or `UXTB/UXTH/UXTW/UXTX/SXTB/...`          |
| `amount`                                      | Shift/extend amount used with `shift` or `extend` in assembler syntax.                                           | small integer (`#0`, `#12`, etc.)                        |
| `Rm`                                          | Source register operand `m` (second/third input in many forms).                                                  | register index bits                                      |
| `Rn`                                          | Source/base register operand `n` (first input or base address).                                                  | register index bits                                      |
| `Rd`                                          | Destination register operand `d` (where result goes).                                                            | register index bits                                      |
| `Rt` / `Rt2`                                  | Transfer register(s) in load/store instructions.                                                                 | register index bits                                      |
| `Ra` / `Rs`                                   | Extra source registers used by some multiply/accumulate/divide forms.                                            | register index bits                                      |
| `sh`                                          | Shift selector/value class (whether/how shift is applied).                                                       | instruction-specific bits                                |
| `sf`                                          | Register width selector (“size flag”).                                                                           | `0` = 32-bit (`W`), `1` = 64-bit (`X`)                   |
| `imm` / `imm12` / `imm16` / `imm19` / `imm26` | Immediate fields with different widths for arithmetic, move-wide, literal load, branch, etc.                     | encoded bit ranges                                       |
| `hw`                                          | Halfword selector used by move-wide instructions (`MOVZ/MOVK/MOVN`) to choose 16-bit lane.                       | `0..3` (with `X` regs)                                   |
| `cond`                                        | Condition selector used by conditional instructions (`B.cond`, `CSEL`, etc.).                                    | `EQ/NE/GE/LT/...`                                        |
| `NZCV`                                        | Condition flags in `PSTATE`: Negative, Zero, Carry, Overflow.                                                    | 4-bit flag set                                           |
| `<imm>`                                       | Assembler immediate placeholder. Actual encoded field can be `imm12`, `imm16`, `imm19`, `imm26`, etc.            | syntax-level token                                       |
| `Xn`                                          | 64-bit general-purpose register `n`.                                                                             | `X0..X30` (sometimes `X31` special)                      |
| `Wn`                                          | Lower 32-bit view of register `n`.                                                                               | `W0..W30` (sometimes `W31` special)                      |
| `Wd`                                          | 32-bit destination register `d`.                                                                                 | `W0..W30`                                                |
| `<R><m>`                                      | Generic source-register placeholder in Arm syntax pages; expands to `Wm` or `Xm` depending on `sf` and form.     | syntax-level token                                       |
| `XZR` / `WZR`                                 | Zero register reads as zero; writes are discarded.                                                               | pseudo-register name for encoding 31 (context-dependent) |
| `SP`                                          | Stack Pointer in 64-bit context (special register meaning for index 31 in some encodings).                       | stack pointer                                            |
| `WSP`                                         | 32-bit stack-pointer form in relevant instruction forms.                                                         | 32-bit SP view                                           |
| `PSTATE`                                      | Processor state register group that includes flags (`NZCV`) and other control bits.                              | architectural state                                      |

## 4. Critical beginner caveat: register 31 is context-sensitive

In many A64 encodings, register index `31` is **not always a normal general register**:

1. In some instructions, `31` means `XZR/WZR` (zero register).
2. In others, `31` means `SP/WSP`.

Always check the specific instruction page before mapping register index 31.

## 4.1 Fast map for this repository (high-frequency terms)

When building this repo chapter-by-chapter, these fields are the ones you will see most:

1. Arithmetic/codegen core: `op`, `opc`, `S`, `sf`, `sh`, `imm12`, `Rd`, `Rn`, `Rm`
2. Memory-related chapters: `Rt`, `Rn`, `imm9/imm12`, `option`, `SP/WSP`
3. Branch/control-flow chapters: `imm19/imm26`, `cond`, `NZCV`
4. Advanced chapters (calls/tables/traps): `Xn/Wn`, `XZR/WZR`, `PSTATE`

## 4.2 Terms you will repeatedly see in Arm syntax pages

These come directly from the “Assembler Symbols” style used in the official pages:

1. `<Wd|WSP>` / `<Xd|SP>`: destination can be GPR or stack pointer (form-dependent).
2. `<Wn|WSP>` / `<Xn|SP>`: first source can be GPR or stack pointer (form-dependent).
3. `<Wm>` / `<Xm>` / `<R><m>`: second source register placeholder.
4. `#<imm>`: immediate constant placeholder.
5. `{, <shift>}` / `{, <extend> {#<amount>}}`: optional transform suffixes.

If one page has multiple encodings (immediate/register/extended), check each encoding block separately—field names can be reused with different meanings.

## 5. Minimal decode workflow for codegen validation

For each emitted instruction:

1. Confirm mnemonic and variant.
2. Confirm `sf` (32-bit vs 64-bit).
3. Confirm `Rd/Rn/Rm`.
4. Confirm immediate/shift/extend fields.
5. Disassemble bytes and compare:
   1. expected assembly
   2. emitted assembly
   3. runtime behavior

If 1 bit is wrong, behavior can still look “almost correct”, so always validate bytes + semantics.

## 6. Beginner-friendly resources (docs + videos)

### Docs

1. Arm Base Instructions index (official):  
   https://support.arm.com/documentation/ddi0602/2026-09/Base-Instructions?lang=en
2. Arm Architecture Reference (A64 base instructions):  
   https://developer.arm.com/documentation/ddi0596/latest
3. Arm community learning path (assembly basics):  
   https://learn.arm.com/
4. A64 quick references (community, good for memorization):  
   https://developer.arm.com/documentation/

### Video / tutorial entry points

1. YouTube search (AArch64 assembly for beginners):  
   https://www.youtube.com/results?search_query=aarch64+assembly+for+beginners
2. YouTube search (Arm64 instruction encoding):  
   https://www.youtube.com/results?search_query=arm64+instruction+encoding
3. YouTube search (read ARM reference manual):  
   https://www.youtube.com/results?search_query=how+to+read+arm+architecture+reference+manual

## 7. Recommended practice loop for this chapter

1. Pick one Wasm opcode (for example integer add).
2. Choose one Arm64 variant (`ADD` immediate or register).
3. Encode one concrete example by hand.
4. Emit via your JIT and disassemble.
5. Compare hand expectation vs generated result.
6. Repeat with boundary cases.

This loop is slower at first, but it is the fastest way to build durable intuition.
