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

## 🔁 Reset & Bootup Sequence

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



## Key notes 
- "Bootstrap" loader was the minium loader that allowed a system to pul
l intself up into memory by the bootstraps
-
