//ADDITION  OF   TWO   32 BIT   NUMBER
#include "msp430.h"
ORG 0x3010
    DW 0xFFFF
DW 0x9000
ORG 0x3020
DW 0xFFFF
DW 0xFFFF

 

      NAME main ; module name

PUBLIC main ; make the main label visible outside this module

ORG 0FFFEh

 DC16 init ; set reset vector to 'init' label

 RSEG CSTACK ; pre-declaration of segment

 RSEG CODE ; place program in 'CODE' segment

init: MOV #SFE(CSTACK), SP ; set up stack

main: NOP ; main program

      MOV.W #WDTPW+WDTHOLD,&WDTCTL ; Stop watchdog timer

CLR R8

 MOV.W 0X3010(R8),R4

 MOV.W 0X3020(R8),R7

 INC R8

 INC R8

 MOV.W 0X3010(R8),R5

 MOV.W 0X3020(R8),R6

 ADD.W R4,R7

 ADDC R5,R6

 JNC L1

 MOV.W #0X0004,R8

 MOV.B #0X01,0X3030(R8)

 L1:  MOV.W #0X0002,R8

  MOV.W R6,0X3030(R8)

     DEC R8

     DEC R8

 MOV.W R7,0X3030(R8)

JMP $

 END