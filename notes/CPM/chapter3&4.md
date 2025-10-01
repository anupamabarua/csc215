# Chapter 3: THe CP/M based computer
## Logical names and physical entities
- computer's operator's console video display terminal = crt
- "CRT:" implies a physical device, in this case the tube with keyboard attached
- only 3 other physical devices are attached to a coumputer
- line printer and 2 disks drive numbered 0 and 1 in the Intel MDS tradition
- Numbber the physical disck drives 0, 1, 2, etc.
- if ur using a particular disk drive it is named logically using A, B, C
- Unlike memory, I/O devices in a CP/M system are accessed differently. As shown in Fig. 3-1, CP/M provides four logical I/O devices that can be accessed via the operating system:
- CON: The console device, used for standard input/output (already discussed previously).
- LST: The logical list device, typically mapped to LPT: (line printer) for printing or making listings of programs.
- RDR: The reader device for general-purpose input. Historically, this could refer to PTR: (paper tape reader).
- PUN: The punch device for general-purpose output. Historically, this could refer to PTP: (paper tape punch).
- These logical devices provide a standardized way to interact with various I/O hardware through the CP/M operating system.
## Selecting I/O devices
- schematic represnation of 4 selector switches
- if real swtiches are connected we can use them to switch from one I/O device to another
### 🔧 Device Selection via Software
- Device selection is done by accessing specific **device driver subroutines** based on bit patterns stored in the `IOBYT`.
- Although shown as hardware selectors in diagrams, selection is fully **software-controlled**.
- This allows the operator or even programs to change device assignments dynamically.

### 🔌 Logical vs Physical Devices

| Logical Device | Example Physical Devices             | Notes                               |
|----------------|---------------------------------------|-------------------------------------|
| `CON:`         | CRT terminal                          | Only **bi-directional** logical device |
| `RDR:`         | Card reader, tape reader, modem (Rx)  | General-purpose **input** device    |
| `PUN:`         | Tape punch, modem (Tx)                | General-purpose **output** device   |
| `LST:`         | Line printer                          | Used for printing program listings  |

### 🖧 System Flexibility
- All physical devices can remain **permanently connected** (if enough I/O ports are available).
- Selection can be:
  - Made by the **operator** via the `CON:` interface
  - **Changed by programs** (sometimes without the user's knowledge)
- Devices do **not** need to be connected to the first input on each selector — just properly mapped in `IOBYT`.

### ⚙️ Notes on `IOBYT`
- `IOBYT` uses 4-bit fields to select among up to 4 physical devices for each logical device.
- **Modems**, which support both input and output, must be correctly configured in **both `RDR:` and `PUN:`** settings.

### 💡 Default Setup (Minimum System)
In basic or minimal CP/M systems:
- No changes to `IOBYT` are needed.
- Default logical-to-physical mappings:
  - `CON:` → CRT terminal
  - `LST:` → LPT (line printer)

## Chapter 4: What the operating system provides

### Named file handling
- contents of a file can be dentfied by its lable
- name of a file in a CP/M system had a fre contrants
- cant be named "X.ASM", CP/M allowa files to be named up to 8 charecters
-  A file type of three characters is appended to the name,
following a period
![notes](/Media/naming.png "notes")

  - With CP/M booted from the **system disk in drive A:**, you could:
1. Insert a **clean disk** into **drive B:**
2. Enter a command to operate on or create files with specific types
- **DIR** Lists all files on the current disk (usually Drive A).
- **DIR *.COM**  Lists only `.COM` files (command/executable files). `*` is a **wildcard**: matches any filename.
- **Wildcards in Filenames**
  - `*` → Matches any number of characters
  - `?` → Matches a single character at a specific position
  - Example:
    - `DIR LIFE????.ASM` → Matches files like `LIFE-1.ASM`, `LIFE-2.ASM`, etc.
    - `DIR L*.ASM` → Matches all `.ASM` files starting with "L" (may include unrelated ones like `LOAD.ASM`)
- **Unambiguous Name**
  - Example: `DIR LIFE.ASM` matches one exact file.
- Copying Files Between Drives **PIP B:=A:*.* **
  - Uses the **Peripheral Interchange Program (PIP)** to copy **all files** from **Drive A** to **Drive B**.
  - `*.*` matches all files with any name and type.
- File Access Consistency All CP/M utilities (like PIP, DIR) accept:
  - Drive specifiers (e.g., `A:`, `B:`)
  - Wildcards (`*`, `?`)
- All utilities use the **same file handling routines** → consistent behavior across commands.
- You can use the same features in **your own programs** with CP/M's built-in file access routines.
-  Logical Unit Access Logical device names like `PUN:` can be mapped to any physical device.
  - Example: `PIP PUN:=FILENAME.TYP` sends the file to whatever device is assigned to `PUN:`.
- Both operators and programs can:
  - Use logical devices without knowing the actual hardware
  - Change logical device assignments
### 📝 Line Editing in CP/M
- CP/M supports **basic line editing** while typing commands:

  | Key        | Function                                           |
  |------------|----------------------------------------------------|
  | `DEL`, `DELETE`, `BS`, `RUBOUT` | Deletes the last character (may be shown differently depending on terminal) |
  | `CTRL+R`   | Redisplay the entire command line (as edited)      |
  | `CTRL+U` or `CTRL+X` | Abort the line input entirely             |

