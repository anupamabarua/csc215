# PART 3: OPERATION OF THE ALTAIR 8800

- 25 toggle switches and 36 indicator and status led lights may be confusing
- straight forward and can run it in less than a hour

## A. The Front Panel Switches and Leds

- Basic ALTAIR 8800 can be preformed with only 15 switches and by monitoring only 16 led lights

### 1. Front panel switches

ON-OFF Switch
- ON postion gives power to the computer
- OFF postion cuts off power and erases the contents of the memory

STOP-RUN Switch
- STOP postion stops the program execution
- RUN postion implements program execution

SINGLE STEP Switch
- Implements a single machine language instuction each time it it actuated (put into motion)
- A single machine language insturction may require as many as 5 machine cycles

EXAMINE-EXAMINE NEXT Switch
- EXAMINE Displays the cintents of any specified memory address previously loaded into the DATA/ADDRESS Swirches on the 8 data led
- EXAMINE NEXT displays the contents of the next sequential memory address
- Each time EXAMINE NEXT is actuated, the contents of the next sequential memory address are displayed

DEPOSIT-SEPOSIT NEXT Switch
- loads the data byte into memory address/loads the data byte into the next memory address

RESET-CLR Switch
-  sets the Program Counter to the first memory address (goes to the first step of a program)/clears external equipment

PROTECT-UNPROTECT Switch
- Protect prevents memory content from being chnaged and vise versa for unprotect

AUX Switches
- used in conjuction with peripherals added to the basic machine

DATA/ADDRESS Switches
- up means a 1 bit, down means a 0 bit

### 2. Indicator lights

ADDRESS: A15-A0
-  LEDs denotes the memory address being examined or loaded with data

DATA: D7-DO
- The data in a specified memory address

INTE
- Interupt when led is glowing

PROT
- PROTECTED when led is glowing

WAIT
- WAIT when led is glowing

HLDA
- HOLD ACKNOWLAGED led is glowing

### 3. Staus LEDs
MEMR
- memory bus used to read memory data

INP
- input data on the data bus

M1
- the CPU is processing the first machine cycle

OUT
- contains the address of an output device

HLTA
- a halt instruction has been executed and acknowledged

STACK
- Holds the Stack Pointer’s push-down stack address

WO
- operation in the cycle will be a write memory or output function. Otherwise, a read memory or input operation will occur

INT
-  an interrupt request has been acknowledged

## B. Loading a sample program

- The program is designed to retrive two numbers from memory and add them together and store the result in memory. Called Mnemonic

LDA
- Load the accumulator with the contents of a specified memory address

MOV
- (A→B)–Move the contents of the accumulator into register B

ADD
- (B+A)–Add the contents of register B to the contents of the accumulator and store the result in the accumulator

STA
- Store the contents of the accumulator ina specified memory address

JMP
- Jump to the first step in the program

- Each of these machine language instructions requires a single byte bit pattern to implement the basic instruction

Bit patterns:
![bit patterns](/Media/bit patterns "bit patterns") 

## C. Using the Memory
- Memory Mapping: assigns various types of data to certain blocks of memeory reserved for a spefic purpose
- effectively organizes the avalible memeory into efficient and readily accesible storage medium
- You can make a new memory map each time tou change the program in the ALTAIR 8800

## D. Memory Addressing
Direct Addressing
- instruction supplies the specified mempry address in the form of 2 bytes immediatly following the actual instruction byte

Register Pair Addresssing
- register pair can contain a memory address
- H and L registers must be used for this purpose for most insturctions
- H contains the most significant 8 bits 
- L contains the least significant 8 bits
- H is high and L is low

Stack Pointer Addressing
- PUSH and POP
- PUSHing data onto the stack causes two bytes (16 bits) of data to be stored in a special block of memory reserved by the programmer and called the stack
- POPing data from the stack causes this data to be retrieved

## E. Operating Hints
- lways proof read you programs by resseting the the first memory location of the program and reading though and checking to make sure everything is correct and fixing it if it isnt
if you need more steps later and you already added some NOP(No OPeration) it is much easier to just add the steps instead of a NOP
when debuging you can use a single step switch to go though the code step by step and examin the memory
