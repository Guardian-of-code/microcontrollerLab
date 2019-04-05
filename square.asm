#include "msp430.h" ; #define controlled include file
 NAME main ; module name
 PUBLIC main ; make the main label visible outside this module
 ORG 0FFFEh
 DC16 init ; set reset vector to 'init' label
 RSEG CSTACK ; pre-declaration of segment
 RSEG CODE ; place program in 'CODE' segment
init: MOV #SFE(CSTACK), SP ; set up stack
main: NOP ; main program
 MOV.W #WDTPW+WDTHOLD,&WDTCTL ; Stop watchdog timer
CLR R11

 MOV.W 0X3010(R11), R4 ; R4= CDCD
 MOV.W R4, R8
 
 MOV.W 0X3010(R11), R7 ; R7= 1234, (FFFF x 1234)
 MOV.W #00, R5
 MOV.W #00, R10 ; PRODUCT LOWER 16 BIT (DB98)
 MOV.W #00, R9 ; PRODUCT UPPER 16 BIT (1233)
 CLRC
 INC.W R5
UP: ADD.W R4, R8 ; SUCCESSIVE ADDITION
 JNC COPY
 INC.W R9
COPY: INC.W R5
 CLRC
 CMP.W R5, R7
 JNE UP
 MOV.W R8, R10
 MOV.W R10,0X3030(R11)
 INC R11
 INC R11
 MOV.W R9,0X3030(R11)
 JMP $
END
