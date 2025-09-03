# PART 3: OPERATION OF THE ALTAIR 8800

- 25 toggle switches and 36 indicator and status led lights may be confusing
- straight forward and can run it in less than a hour

## A. The Front Panel Switches and Leds

- Basic ALTAIR 8800 can be preformed with only 15 switches and by monitoring only 16 led lights

1. Front panel switches

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

2. Indicator lights

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

3. Staus LEDs
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













