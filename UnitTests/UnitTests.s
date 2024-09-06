UnitTests:

.Run:
    ; define screen colors
    ld 		a, 15      	            ; Foreground color
    ld 		(BIOS_FORCLR), a    
    ld 		a, 1  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 1      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    call    BIOS_INITXT     ; initialize screen 0


    ; ld      hl, TEST_STRING
    ; call    PrintString

    call 	PlayerLogic_Tests

    ; wait some seconds
    ld      b, 180
    call    Wait_B_Vblanks

    ret


; TEST_STRING: db 'Test String', 0

; ---------------------------

.check_HL_equals_0:
    ld      de, 0
    call    BIOS_DCOMPR
    jp      nz, .testFailed
    jp      .testPassed

.check_HL_equals_DE:
    call    BIOS_DCOMPR
    jp      nz, .testFailed
    jp      .testPassed

; ---------------------------

.testPassed:
    ld      hl, TEST_PASSED_STRING
    call    PrintString_CrLf
    ret

.testFailed:

    ld 		a, 8  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 8      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    ld      hl, TEST_FAILED_STRING
    call    PrintString_CrLf
    ret

; ---------------------------

TEST_PASSED_STRING: db 'Test passed', 0
TEST_FAILED_STRING: db 'TEST FAILED !', 0
