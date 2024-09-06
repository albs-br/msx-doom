ObjectLogic_Tests:

    ; define screen colors
    ld 		a, 15      	            ; Foreground color
    ld 		(BIOS_FORCLR), a    
    ld 		a, 1  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 1      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    call    BIOS_INITXT     ; initialize screen 0


    ld      hl, TEST_STRING
    call    PrintString



    ; wait some seconds
    ld      b, 180
    call    Wait_B_Vblanks

    ret


TEST_STRING: db 'Test String', 0