ORG 100H           ; TPA start

; BDOS function codes
RCONF   EQU 1             
WCONF   EQU 2             
RLINE   EQU 10            

INITF   EQU 13            ; Disk init
OPENF   EQU 15            ; Open file
CLOSF   EQU 16            ; Close file
READF   EQU 20            ; Read one record
WRTF    EQU 21            ; Write one record
MAKEF   EQU 22            ; Create file
SDMAF   EQU 26            ; Set DMA

BDOS    EQU 5             ; BDOS entry


; Buffers & variables

INBUF   DS 83             
OUTBUF  DS 128            
NUM1    DS 1              
NUM2    DS 1              
RESULT  DS 2              
OFCB    DS 36             
TFCB    DS 36             
NEXT    DS 2              



START:
    CALL GETFNAME        ; get input filename from user
    CALL READNUMS        ; read two numbers from file
    LD A,(NUM1)
    LD B,(NUM2)
    CALL MUL1DIG         ; multiply A*B, result in A
    LD (RESULT),A
    CALL WRITERESULT     ; write result to RESULT.TXT
    JMP $



GETFNAME:
    LD HL,PROMPT
    CALL PRINTSTR
    LD HL,INBUF
    MVI C,RLINE
    CALL BDOS
    RET

PROMPT: DB 'Enter filename: ',0


READNUMS:
    LD HL,INBUF
    LD DE,NEXT
    LD C,SDMAF
    CALL BDOS

    LD DE,TFCB
    LD HL,INBUF
    CALL FILLFCB
    LD C,OPENF
    CALL BDOS

    LD DE,TFCB
    LD C,READF
    CALL BDOS

    LD HL,INBUF
    LD A,(HL)
    SUB '0'
    LD (NUM1),A
    INC HL
    LD A,(HL)
    CP ' '
    JR NZ,SKIP1
    INC HL
SKIP1:
    LD A,(HL)
    SUB '0'
    LD (NUM2),A
    RET


MUL1DIG:
    LD C,A
    LD A,0
    LD D,B
MULLOOP:
    LD B,D
    OR B
    RET Z
    ADD A,C
    DEC D
    JR MULLOOP


; Write result to RESULT.TXT

WRITERESULT:
    LD HL,OUTBUF
    LD A,(RESULT)
    CALL NUMTOASCII
    LD DE,OUTBUF
    LD C,SDMAF
    CALL BDOS

    LD HL,RFNAME
    LD DE,OFCB
    CALL FILLFCB
    LD C,MAKEF
    CALL BDOS

    LD DE,OFCB
    LD C,WRTF
    CALL BDOS
    RET


NUMTOASCII:
    ADD '0'
    LD (HL),A
    RET


FILLFCB:
    LD B,12
FILLLOOP:
    LD A,(HL)
    OR A
    JR Z,FILLDONE
    LD (DE),A
    INC HL
    INC DE
    DJNZ FILLLOOP
FILLDONE:
    RET

PRINTSTR:
    LD A,(HL)
    OR A
    RET Z
    LD E,A
    LD C,WCONF
    CALL BDOS
    INC HL
    JR PRINTSTR


RFNAME: DB 'RESULT  ','TXT'

END START

