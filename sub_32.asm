#include "msp430.h"                     ; #define controlled include file

ORG 0X3010

DW 0X3461

DW 0X9876

ORG 0X3020

DW 0X1211

DW 0X0310

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

CLR R6

MOV.W 0X3010(R6),R7

MOV.W 0X3020(R6),R8

INC.W R6

INC.W R6

MOV.W 0X3010(R6),R9

MOV.W 0X3020(R6),R10

SUB.W R8,R7

SUBC R10,R9

JC DOWN

INC.W R6

INC.W R6

MOV.W #0XFFFF,0X3030(R6)

DEC.W R6

DEC.W R6

DOWN: MOV.W R9,0X3030(R6)

DEC.W R6

DEC.W R6

MOV.W R7,0X3030(R6)

JMP $                           ; jump to current location '$'

                                  ; (endless loop)

 END