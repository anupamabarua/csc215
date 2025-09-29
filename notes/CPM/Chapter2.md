# Chapter 2 notes
## Random intro notes
- Core memory was constructed using magnetic cores and can retain its componets with power off
- To make sure that the operating system was loaded properly, it was normalized for the simple short loader to read in a smart loader, that would than load the system
- "Bootstrap" loader was the minium loader that allowed a system to pull intself up into memory by the bootstraps
- Semiconductor memory replaced core memory but flopped cause semiconductor RAM oses its meory when the power goes down
- EPROMS -  Erasable Programmable Read-Only Memory chips

## Firmware montior
- microprocessor IC of the 8080 family is reset, it begins operation by fetching an instruction from
memory location zero
- A bootup circuit is activated by the same reset signal that starts the 24 Software Components of the Computer System CPU
- RAM location zero "disappear and substitutes a shadow PROM
-  one or more instructions are fetched from the
shadow PROM and executed
- after the first instruction  the computer hardware is told that it is time to disconnect the shadow PROM, and reinstate RAM at location zero# 🖥️ CPU Bootup & Monitor PROM – Quiz Notes

1. **Power On or Reset**
   - Can be done by powering on or gently pressing the reset switch.
   - Starts the **reset sequence**.

2. **Initial State**
   - **Low RAM is disabled**
   - **Shadow PROM is enabled**

3. **First Instruction Fetch**
   - CPU fetches first instruction from **shadow PROM**.
   - This is an **unconditional jump** to the **monitor program** in ROM.

4. **Address Bus Activation**
   - CPU places jump address on **address bus** (16 signal lines).
   - When the **most significant bit (MSB)** is set, it signals the top of memory.

5. **Memory Switch**
   - Bootup circuitry:
     - **Disables shadow PROM**
     - **Enables low RAM**

6. **Monitor PROM Execution**
   - CPU now fetches instructions from **monitor ROM** (top of memory).
   - Monitor ROM includes a **loader program**.

---

## 💿 Loading CP/M OS (Typical Boot Flow)

```text
Power on / Reset
↓
Disable low RAM
↓
Enable shadow PROM
↓
Fetch first instruction from shadow PROM
↓
Jump to Monitor PROM
↓
Disable shadow PROM
↓
Enable low RAM
↓
Read bootstrap from disk (A:, track 0, sector 1)
↓
If disk error → Sign on and run Monitor
↓
If no error → Jump to Bootstrap Loader
↓
Load CP/M system from disk
↓
If disk error → Error
↓
If no error → Sign on and run CP/M
```
## The operating system
- CPM is the opertating system in the computer
- originally written on, and for, the Intel MDS-800
microprocessor development system, it has since been adapted to
more computers of more different manufacturers than any other operating system
-  physical port address for console status and data will
differ from one computer to another

## Customizing CPM
-  user-to-system conventions built into CP/M 
-  All disk and I/O accesses are passed through a single entry point into CP/M
- to implement these function codes are passed in one register, and passed througj a single entry point into CPM
- implement this, function codes are passed in one register, and the data or buffer address passed in other registers.

## Application programs
- firmware montiory takes up some space in the main memory address space and the resident portion of CPM will take up 6K
- Special areas at the bottom of RAM that are used by operating system and the rest of the meory address space is free
-  8080 family can address 64K, it is not often you find a system with the full 64K of RAM.
- CPM loads and executes user programs in RAM in the "Transient program area" or TPA
- Begins at a fixed address and includes all avalible RAM not required by CPM
- While we are in the process of editing, assembling, and debugging our application programs we will be using CP/M's editor (ED), assembler (ASM), loader (LOAD), and debugger (DDT). These programs are also going to be loaded into the TPA as we use them. Obviously, then, they will not reside in memory all at the same time, and only DDT will share main memory with our programs.
- DDT will have to be loaded along with our application programs only until the programs are fully operational.

## Special memory areas
- Vectors are unconditional jump instructions
- 8080 family uses 8 memory locations as vectors for hardware interrupts
-  CP/M establishes buffer areas that we will be using when we interface our programs with the operating system
- TPA begins at the next available location


## Key notes 
- "Bootstrap" loader was the minimum loader that allowed a system to pull intself up into memory by the bootstraps
- CPM is the opertating system in the computer. It manged a computers hardware and files allowing users to run programs from disk drives
- provided a command-line interface for interacting with the machine and included a file management system
- CPM loads and executes user programs in RAM in the "Transient program area" or TPA
- Begins at a fixed address and includes all avalible RAM not required by CPM
