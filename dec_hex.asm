#include "msp430.h" 

	NAME main
	PUBLIC main
	ORG 0FFFEh
	DC16 init
	RSEG CSTACK
	RSEG CODE

init: MOV #SFE(CSTACK),SP
main: NOP
      MOV.W #WDTPW+WDTHOLD,&WDTCTL
      MOV #0x99,0x3010
      MOV #0x00,0x3020
      MOV.W #00,R5
      MOV 0x3010,R4
      MOV R4,R6
      AND #0xF0,R4
      AND #0x0F,R6
L1:   RRA R4
      INC R5
      CMP#04,R5
      JNE L1
      CLR R5
      MOV R4,R7
L2:   ADD R7,R4
      INC R5
      CMP #0x09,R5
      JNE L2
      CLR R5
      ADD R6,R4
      MOV.W R4,0x3020

	JMP $
	END