; MULTIPLY SINGLE DIGIT NUMBERS
; BY ANUPAMA AND BLU AKA YOUR FAVORITE STUDENTS

; ASCII CHARACTERS
CR      EQU     0DH
LF      EQU     0AH
CTRLZ   EQU     1AH

; CP/M BDOS FUNCTIONS
RCONF   EQU     1
WCONF   EQU     2
RBUFF   EQU     10

; CP/M ADDRESSES
RBOOT   EQU     0
BDOS    EQU     5
TPA     EQU     100H

        ORG     TPA

START:  LXI     SP,STAK

MAIN:   CALL    TWOCR           ; DOUBLE SPACE
        CALL    SPMSG
        DB      'MULTIPLY 2 Single-Digit Numbers',0
        CALL    TWOCR

        ; GET FIRST DIGIT
        CALL    SPMSG
        DB      'ENTER FIRST DIGIT (0-9): ',0
        CALL    GETNUM          ; GET NUMBER INTO HL (0b9)
        SHLD    NUM1            ; SAVE FIRST NUMBER

        ; GET SECOND DIGIT
        CALL    SPMSG
        DB      'ENTER SECOND DIGIT (0-9): ',0
        CALL    GETNUM          ; GET NUMBER INTO HL (0b9)
        SHLD    NUM2            ; SAVE SECOND NUMBER

        ; MULTIPLY THE NUMBERS (HL = NUM1 * NUM2)
        LHLD    NUM1            ; HL = first number
        XCHG                    ; DE = first number
        LHLD    NUM2            ; HL = second number
        MOV     B,L             ; B = second number (0b9)
        LXI     H,0             ; HL = 0 (accumulator)

MULLP:  MOV     A,B
        ORA     A
        JZ      MULEND          ; if B == 0, done
        DAD     D               ; HL = HL + DE
        DCR     B               ; B--
        JMP     MULLP

MULEND: SHLD    RESULT          ; save product in RESULT

        ; DISPLAY RESULT
        CALL    CCRLF
        CALL    SPMSG
        DB      'PRODUCT: ',0
        LHLD    RESULT
        CALL    PRTNUM          ; PRINT THE NUMBER

        ; ASK TO CONTINUE
        CALL    CCRLF
        CALL    SPMSG
        DB      'AGAIN?',0
        CALL    GETYN
        JZ      MAIN            ; IF YES, DO ANOTHER

        ; EXIT TO CP/M
        JMP     RBOOT

; GET A DECIMAL NUMBER FROM CONSOLE (0-999)
; RETURNS VALUE IN HL
GETNUM: CALL    CIMSG           ; GET INPUT LINE
        CALL    CCRLF
        LXI     H,INBUF+2       ; POINT TO FIRST CHARACTER
        LXI     D,0             ; CLEAR RESULT IN DE

GNUM1:  MOV     A,M             ; GET CHARACTER
        ORA     A               ; CHECK FOR END
        JZ      GNUM2           ; DONE IF ZERO
        CPI     '0'             ; CHECK IF DIGIT
        JC      GNUM1X          ; SKIP IF NOT
        CPI     '9'+1
        JNC     GNUM1X          ; SKIP IF NOT

        ; MULTIPLY DE BY 10
        PUSH    H               ; SAVE POINTER
        PUSH    D               ; SAVE CURRENT RESULT
        MOV     H,D             ; COPY DE TO HL
        MOV     L,E
        DAD     H               ; HL = DE * 2
        DAD     H               ; HL = DE * 4
        POP     D               ; RESTORE ORIGINAL DE
        PUSH    D               ; SAVE IT AGAIN
        DAD     D               ; HL = DE * 5
        DAD     H               ; HL = DE * 10
        POP     D               ; CLEAN UP STACK
        XCHG                    ; RESULT TO DE

        ; ADD DIGIT TO RESULT
        POP     H               ; RESTORE POINTER
        MOV     A,M             ; GET DIGIT CHARACTER
        SUI     '0'             ; CONVERT TO BINARY
        ADD     E               ; ADD TO LOW BYTE
        MOV     E,A
        MVI     A,0
        ADC     D               ; ADD CARRY TO HIGH BYTE
        MOV     D,A

GNUM1X: INX     H               ; NEXT CHARACTER
        JMP     GNUM1

GNUM2:  XCHG                    ; RESULT TO HL
        RET

; PRINT NUMBER FROM HL (0b999)
PRTNUM: LXI     D,NUMBUF+5      ; POINT TO END OF BUFFER
        MVI     B,0             ; DIGIT COUNTER

PRTN1:  LXI     D,10            ; DIVISOR
        CALL    DIVIDE          ; HL / 10, A = remainder
        ADI     '0'             ; CONVERT REMAINDER TO ASCII
        PUSH    PSW             ; SAVE DIGIT ON STACK
        INR     B               ; COUNT DIGITS
        MOV     A,H             ; CHECK IF QUOTIENT IS ZERO
        ORA     L
        JNZ     PRTN1           ; CONTINUE IF NOT ZERO

PRTN2:  POP     PSW             ; GET DIGIT
        CALL    CO              ; PRINT IT
        DCR     B               ; COUNT DOWN
        JNZ     PRTN2
        RET

; DIVIDE HL BY 10, RESULT IN HL, REMAINDER IN A
DIVIDE: PUSH    B
        PUSH    D
        LXI     B,0             ; BC WILL HOLD RESULT
        LXI     D,10            ; DIVISOR = 10
DIV1:   MOV     A,H             ; CHECK HIGH BYTE
        ORA     A
        JNZ     DIV2
        MOV     A,L             ; IF H == 0, CHECK L
        CMP     E               ; COMPARE L WITH 10
        JC      DIV3            ; IF L < 10, DONE
DIV2:   MOV     A,L             ; SUBTRACT 10 FROM L
        SUB     E
        MOV     L,A
        MOV     A,H
        SBB     D
        MOV     H,A
        INX     B               ; INCREMENT QUOTIENT
        JMP     DIV1
DIV3:   MOV     A,L             ; REMAINDER IN A
        MOV     H,B             ; QUOTIENT HIGH BYTE
        MOV     L,C             ; QUOTIENT LOW BYTE
        POP     D
        POP     B
        RET

; STORAGE FOR NUMBERS
NUM1:   DW      0
NUM2:   DW      0
RESULT: DW      0
NUMBUF: DS      6

; CP/M I/O LIBRARY FUNCTIONS

; CONSOLE CHARACTER INTO REGISTER A MASKED TO 7 BITS
CI:     PUSH    B               ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        MVI     C,RCONF         ; READ FUNCTION
        CALL    BDOS
        ANI     7FH             ; MASK TO 7 BITS
        POP     H               ; RESTORE REGISTERS
        POP     D
        POP     B
        RET

; CHARACTER IN REGISTER A OUTPUT TO CONSOLE
CO:     PUSH    B               ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        MVI     C,WCONF         ; SELECT FUNCTION
        MOV     E,A             ; CHARACTER TO E
        CALL    BDOS            ; OUTPUT BY CP/M
        POP     H               ; RESTORE REGISTERS
        POP     D
        POP     B
        RET

; CARRIAGE RETURN, LINE FEED TO CONSOLE
TWOCR:  CALL    CCRLF           ; DOUBLE SPACE LINES
CCRLF:  MVI     A,CR
        CALL    CO
        MVI     A,LF
        JMP     CO

; MESSAGE POINTED TO BY HL OUT TO CONSOLE
COMSG:  MOV     A,M             ; GET A CHARACTER
        ORA     A               ; ZERO IS THE TERMINATOR
        RZ                      ; RETURN ON ZERO
        CALL    CO              ; ELSE OUTPUT THE CHARACTER
        INX     H               ; POINT TO THE NEXT ONE
        JMP     COMSG           ; AND CONTINUE

; MESSAGE POINTED TO BY STACK OUT TO CONSOLE
SPMSG:  XTHL                    ; GET "RETURN ADDRESS" TO HL
        XRA     A               ; CLEAR FLAGS AND ACCUMULATOR
        ADD     M               ; GET ONE MESSAGE CHARACTER
        INX     H               ; POINT TO NEXT
        XTHL                    ; RESTORE STACK FOR
        RZ                      ; RETURN IF DONE
        CALL    CO              ; ELSE DISPLAY CHARACTER
        JMP     SPMSG           ; AND DO ANOTHER

; INPUT CONSOLE MESSAGE INTO BUFFER
CIMSG:  PUSH    B               ; SAVE REGISTERS
        PUSH    D
        PUSH    H
        LXI     H,INBUF+1       ; ZERO CHARACTER COUNTER
        MVI     M,0
        DCX     H               ; SET MAXIMUM LINE LENGTH
        MVI     M,80
        XCHG                    ; INBUF POINTER TO DE REGISTERS
        MVI     C,RBUFF         ; SET UP READ BUFFER FUNCTION
        CALL    BDOS            ; INPUT A LINE
        LXI     H,INBUF+1       ; GET CHARACTER COUNTER
        MOV     E,M             ; INTO LSB OF DE REGISTER PAIR
        MVI     D,0             ; ZERO MSB
        DAD     D               ; ADD LENGTH TO START
        INX     H               ; PLUS ONE POINTS TO END
        MVI     M,0             ; INSERT TERMINATOR AT END
        POP     H               ; RESTORE ALL REGISTERS
        POP     D
        POP     B
        RET

; GET YES OR NO FROM CONSOLE
GETYN:  CALL    SPMSG
        DB      ' (Y/N)?: ',0
        CALL    CIMSG           ; GET INPUT LINE
        CALL    CCRLF           ; ECHO CARRIAGE RETURN
        LDA     INBUF+2         ; FIRST CHARACTER ONLY
        ANI     01011111B       ; CONVERT LOWER CASE TO UPPER
        CPI     'Y'             ; RETURN WITH ZERO = YES
        RZ
        CPI     'N'             ; NON-ZERO = NO
        JNZ     GETYN           ; ELSE TRY AGAIN
        CPI     0               ; RESET ZERO FLAG
        RET                     ; AND ALL DONE

INBUF:  DS      83              ; LINE INPUT BUFFER

; SET UP STACK SPACE
        DS      64              ; 40H LOCATIONS
STAK:   DB      0               ; TOP OF STACK

        END     START
