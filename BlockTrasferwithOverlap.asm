#include "msp430.h"                     ; #define controlled include file

ORG 0X3010

#include "msp430.h"

ORG 0X3010
mystr1  DW 0X1111
        DW 0X2222
        DW 0X3333
        DW 0X4444
        DW 0X5555
         


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
      	
	CLR.w R5
	CLR.W R6
      	MOV.W #0008,R5
	MOV.W #0010,R6

      	
      	L1: MOV.W 0X3010(R5),0X3010(R6)
      	
      	DEC R5
      	DEC R5
	DEC R6
	DEC R6
	
	CMP #0000,R6
	
     	JNE L1
      	JMP $                           ; jump to current location '$'
                                        ; (endless loop)
        END