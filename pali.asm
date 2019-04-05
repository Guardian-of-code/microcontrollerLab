#include "msp430.h"                     ; #define controlled include file

        NAME    main                    ; module name

        PUBLIC  main                    ; make the main label vissible
                                        ; outside this module
        ORG     0FFFEh
        DC16    init                    ; set reset vector to 'init' label
        RSEG DATA16_N
        SourceStr: ; SOURCE STRING
        DB "racecar";
        DestStr: DS 40h
        RSEG    CSTACK                  ; pre-declaration of segment
        RSEG    CODE                    ; place program in 'CODE' segment

init:   MOV     #SFE(CSTACK), SP        ; set up stack

main:   NOP                             ; main program
        MOV.W   #WDTPW+WDTHOLD,&WDTCTL  ; Stop watchdog timer
        mov.w #SourceStr,r14
        mov.w r14,r10
        MOV.W #DestStr,r12
        MOV.W R12,R9
        SUB R10,R9
        DECD R9
        
        MOV R9,R4
        INC R4
        ADD R9,R12
        call #revMyStrCpy
        CLR R7
        MOV #DestStr,R5
        
        MOV.W #SourceStr,R6
        MOV.B 0(R5),R9
        MOV.B 0(R6),R11
        pal1: CMP.B 0(R5),0(R6)
        JNZ OVER
        INC R5
        INC R6
        DEC R4
        JNZ pal1
        MOV.B #11H,R13
        JMP FIN
        OVER: MOV.B #00H,R13
        
        FIN: 
        CLR R4
        MOV R13,0X3010(R4)
        JMP $
        
        revMyStrCpy:
        JMP CopyTest
        CopyLoop:
        DEC.W R12;
        CopyTest:
        MOV.B @R14+,0(R12);
        TST.B 0(R14);
        JNZ CopyLoop;
        RET 
        END
        JMP $                           ; jump to current location '$'
                                        ; (endless loop)
        END
