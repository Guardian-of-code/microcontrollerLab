#include "msp430.h"                     ; #define controlled include file

        ORG 0X3010
mystr   DW  0X1234      
        DW  0X6758
        DW  0XAB30
        DW  0XFFFF
        DW  0X0349
        DW  0X8719
        DW  0X4512
        DW  0X1111
        
NAME    main                    ; module name

PUBLIC  main                    ; make the main label vissible
                                        ; outside this module
        ORG     0FFFEh
        DC16    init                    ; set reset vector to 'init' label

        RSEG    CSTACK                  ; pre-declaration of segment
        RSEG    CODE                    ; place program in 'CODE' segment

init:   MOV     #SFE(CSTACK), SP        ; set up stack

main:   NOP                             ; main program
        MOV.W   #WDTPW+WDTHOLD,&WDTCTL  ; Stop watchdog timer
    L4: CLR R5
        CLR R9
        MOV.W #0X0007,R10
        MOV.W 0X3010(R5),R6
    L3: INC R5
        INC R5
        CMP 0X3010(R5),R6
        JNC L1
        JNE L2
        JMP L1
    L2: MOV.W 0X3010(R5),R6
        MOV.W R6,R7
        INC R5 
        INC R5
    L1: DEC R10
        CMP #0X0000,R10
        JNE L3
        MOV.W R6,0X3030(R10)
        
        JMP $                          ; jump to current location '$'
                                        ; (endless loop)
        END
