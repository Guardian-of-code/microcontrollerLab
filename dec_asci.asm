#include "msp430.h"
 
	NAME main
	PUBLIC main
	ORG 0FFFEh
	  DC16 init
	ORG 0x3010
	  data DW 0x54
	RSEG DATA16_N
	ASC: DS 4H
	RSEG CODE

init:	NOP
main:	NOP
	MOV.W #WDTPW+WDTHOLD,&WDTCTL
	CLR R9
	MOV.B 0x3010(R9),R5
	MOV.B R5,R6
	AND.B #0x0F,R6
	ADD.B #0x30,R6
	MOV.B R6,&ASC
	AND.B #0xF0,R5
	MOV.B #0x04,R8
L1:	RRA.B R5
	DEC.B R8
	JNZ L1
	ADD.B #0x30,R5
	MOV.B R5,&(ASC+1)

JMP $
END