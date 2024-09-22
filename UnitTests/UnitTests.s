UnitTests:

.RunAll:
    ; define screen colors
    ld 		a, 15      	            ; Foreground color
    ld 		(BIOS_FORCLR), a    
    ld 		a, 1  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 1      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    call    BIOS_INITXT     ; initialize screen 0



    call 	Math_Tests
    call 	PlayerLogic_Tests
    call 	ObjectLogic_Tests


    ; wait some seconds
    ld      b, 120
    call    Wait_B_Vblanks

    ret


; ---------------------------

.check_A_is_false:
.check_A_equals_0:
    or      a
    jp      nz, .testFailed
    jp      .testPassed

.check_A_is_true:
.check_A_not_equals_0:
    or      a
    jp      z, .testFailed
    jp      .testPassed

.check_A_equals_B:
    cp      b
    jp      nz, .testFailed
    jp      .testPassed

.check_HL_equals_0:
    ld      de, 0
    rst     BIOS_DCOMPR
    jp      nz, .testFailed
    jp      .testPassed

.check_HL_not_equals_0:
    ld      de, 0
    rst     BIOS_DCOMPR
    jp      z, .testFailed
    jp      .testPassed

.check_HL_equals_DE:
    rst     BIOS_DCOMPR
    jp      nz, .testFailed
    jp      .testPassed

; ---------------------------

.testPassed:
    ld      hl, TEST_PASSED_STRING
    call    PrintString_CrLf
    ret

.testFailed:

    call    BIOS_BEEP

    ld 		a, 8  		            ; Background color
    ld 		(BIOS_BAKCLR), a     
    ld 		a, 8      	            ; Border color
    ld 		(BIOS_BDRCLR), a    
    call 	BIOS_CHGCLR        		; Change Screen Color

    ld      hl, TEST_FAILED_STRING
    call    PrintString_CrLf

    ; ; wait some seconds
    ; ld      b, 120
    ; call    Wait_B_Vblanks

    ret

; ---------------------------

TEST_PASSED_STRING: db '  Test passed', 0
TEST_FAILED_STRING: db '  TEST FAILED !', 0
