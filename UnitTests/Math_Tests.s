MATH_TESTS_STRING: db 'Math tests', 0

Math_Tests:

    ld      hl, MATH_TESTS_STRING
    call    PrintString_CrLf

    call    .FPDE_Div_BC88_Test_0

    ret

; ---------------------------

; --- Test case:
; 0x0000 divided by 0x4000
.FPDE_Div_BC88_Test_0:
    ; --- Arrange
    ld      de, 0x0000
    ld      bc, 0x4000



    ; --- Act
    call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0000
    call    UnitTests.check_HL_equals_DE

    ret

