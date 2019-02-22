//multiplication OF   TWO   8/16 BIT   NUMBER
#include "msp430.h"


NAME main ; module name
PUBLIC main ; make the main label visible outside this module


ORG 0X3010
num1 dw 0x10ef

ORG 0X3020
num2 dw 0x201f

 


ORG 0FFFEh

DC16 init ; set reset vector to 'init' label

RSEG CSTACK ; pre-declaration of segment

RSEG CODE ; place program in 'CODE' segment

init: MOV #SFE(CSTACK), SP ; set up stack

main: NOP ; main program

     MOV.W #WDTPW+WDTHOLD,&WDTCTL ; Stop watchdog timer





CLR R11

 MOV.W 0X3010(R11),R4
 
 MOV.W R4,R8

 MOV.W 0X3020(R11),R7


 MOV.W #00,R5
 MOV.W #00,R10
 MOV.W #00,R9

 CLRC 

 INC.W R5

 UP:
 ADD.W R4,R8
 JNC COPY

 INC.W R9
 COPY: 
 INC.W R5
 CLRC 
 CMP.W R5,R7
 JNE UP
 MOV.W R8,R10
 MOV.W R10,0X3030(R11)
 INC R11
 INC R11
 MOV.W R9,0X3030(R11)


JMP $

END