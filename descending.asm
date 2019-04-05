 #include "msp430.h"                     		; #define controlled include file
       			 ORG  0X3010
mystr   		DW   0X7777
        		DW   0X1111
        		DW   0X5555
        		DW   0X2222
        		DW   0X4444
        		DW   0X8888
        		DW   0X6666
        		DW   0X3333
                     
                                         
                                       
                               
                                                      
                                                                                                                                          
        		NAME    main                    		; module name
        		PUBLIC  main                    		; make the main label vissible
                                    				 ; outside this module
        		ORG     0FFFEh
        		DC16    init                    		; set reset vector to 'init' label
        		RSEG    CSTACK                  		; pre-declaration of segment
        		RSEG    CODE                    		; place program in 'CODE' segment
init:   		MOV     #SFE(CSTACK), SP        	; set up stack
main:   		NOP                             		; main program
        		MOV.W   #WDTPW+WDTHOLD,&WDTCTL  ; Stop watchdog timer
L4:    		CLR R5
       			CLR R9
       			MOV.W #0X0007,R10
       
L3:    		MOV.W  0X3010(R5),R6
       			INC    R5
       			INC    R5
                         CMP   0X3010(R5),R6 ; compare with second value
       			JC    L1        ; if greater than jump to L1
       			JNE    L2                        		; if less than jump to L2
       			JMP    L1
 L2:    		MOV.W  0X3010(R5),R7             	;exchange the value
       			DEC    R5
       			DEC    R5
       			MOV.W  R7,0X3010(R5)
       			INC    R5
       			INC    R5
       			MOV.W  R6,0X3010(R5)
       			MOV.W  #0X0001,R9                	; set R9
L1:    		DEC   R10
       			CMP    #0X0000,R10
       			JNE    L3
       			CMP    #0X0000,R9
       			JNE    L4
                        
                        
                        
                        
                        
                        
          		JMP $                           		; jump to current location '$'
                                        				; (endless loop)
        		END
