#include "msp430.h"                     ; #define controlled include file

        ORG 0X3010
mystr   DW 0X0004
        ORG 0X3020
mystr1  DW 0X000F

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
        
        MOV.W #0004H, 0X3000
        MOV.W #000FH, 0X3002
        CLR R5
        MOV.W 0X3010(R5), R4
        MOV.W 0X3020(R5), R7
        MOV #0000H, R6

L2:     SUB R4, R7
        ADD #0001H, R6
        CMP R4, R7
        JN L1
        JMP L2

L1:     MOV R7, 0X3030(R5)
        INC R5
        INC R5
        MOV R6, 0X3030(R5)
        NOP
        NOP

L3:     JMP L3
                                        ; (endless loop)
        END
