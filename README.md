## How does the single cycle RISC V processor work IRL?
The procesor consists of various modules integrated together to carry out different operations which are defined by a 32-bit binary instruction. These instructions are described by the RV32I Instructuction Set Architecture with different parts of those 32-bits pertaining to different things.

The whole data-path is divided into 5 stages namely-
1. **Instruction Fetch (IF)** :- Process of getting the next instruction from the instruction memory. This stage might also update the program counter if the next value of program counter is the next instruction in instruction memory.

2. **Instruction Decode (ID)** :- Defined as separating the various components of the instruction and alotting them where they are needed (register file, control signals, ALU, etc).

3. **Execute (EX)** :- This stage involves the ALU calculating anything that it has been sent from register file, immediate generator or control signals.

4. **Memory Access (MEM)** :- This stage comes in play when we need to STORE or LOAD something from the data memory. This is also often the longest stage in the whole single-cycle architecture.

5. **Write-Back (WB)** :- Writing back to the register files the values from ALU / data memory. In a single cycle processor, this happens on the clock edge of the next instruction or the IF stage of the netx instruction.

## Modules / Functional Units of the single cycle RISC V processor
- *Program Counter*:- The module which counts which instruction will be sent next for decoding. Its output is an address which can either be the last instruction's address + 4 bytes (next instruction in the instruction memory) or it can be described by a branch instruction to go to a particular address.

- *Control Logic* :- This module sends control bits to the MUXes, ALU, data memory, register file and more. It's basically the brain of our processor.

- *Instruction memory* :- The place in the memory where the 32-bit instructions are stored sequentially wordwise. Also it shares the same memory space as data memory space but we consider it different spaces for convenience purposes.

- *Register file* :- A set of 32 registers each of width 32-bits that stores variable values, immediates, address of other registers, etc. 

- *Immediate Generator* :- This module is used to create 32-bit immediates from instructions. Different instructions will cause different types and lengths of immediates to be made.

- *Branch Comparator* :- In BRANCH instruction types, this is used to compare 2 values. It is also the only module that can send control bits aside from the instruction obviously.

- *ALU* :- The Arithmetic Logic Unit is the main working head of the processor. It can perform mathematical operations like addition (of registers, intermediates, addresses), subtraction, multiplication, shift operations.

- *Data memory* :- The component of a computer used to store all kinds of data. It is divided into further sub-parts and going into all of that is another whole chapter.

and basic digital components like MUXes, decoders... All of these individual parts together (except the control logic) make up the data-path.

## Different fields in RISC V ISA
Instructions have a particular format consisting of various fields (some fields might be particular to some instructions) that tell various features of it like what operation to form, on what, where to store, etc. These are-

1. **Opcode** :- A 7-bit code occupying the bits [6:0] of all instructions that defines which type is it (R/I/S/B/U/J) which are as follows-
  - R-type : 0110011
  - I-type : 0010011 (Arithmetic)
  - S-type : 0100011
  - B-type : 1100011
  - U-type : 0110111
  - J-type : 1101111

2. **Funct3** :- This field further define what function to perform in that particular instruction type (for eg.- ADD, SUB, OR...). R-type also has another field called Funct7 for differentiating between two instructions that have same Funct3 field because we wanted to use the same hardware for both the instructions as there was only one small change.

3. **rs1 and rs2** :- These are 5 bit fields which point to the source registers from which values are taken for execution.

4. **rd** :- The destination register where the value is stored after calculation.

5. **Immediate** :- This field is used to define any constant values that appear in assembly code instead of pointing to a register that's got that value.

## Information related to my specific copy of RV32I (not final)
- *PCSel* :- If = 0 => next instruction instruction memory; if 1 i.e. the one from ALU because of jump / branch instruction.

- *ALUSel* :- If = 0 => Add, otherwise subtract. 