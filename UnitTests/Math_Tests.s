MATH_TESTS_STRING: db 'Math tests', 0

Math_Tests:

    ld      hl, MATH_TESTS_STRING
    call    PrintString_CrLf

    call    .FPDE_Div_BC88_Test_0
    call    .FPDE_Div_BC88_Test_1
    call    .FPDE_Div_BC88_Test_2
    call    .FPDE_Div_BC88_Test_3
    call    .FPDE_Div_BC88_Test_4
    call    .FPDE_Div_BC88_Test_5
    call    .FPDE_Div_BC88_Test_6
    call    .FPDE_Div_BC88_Test_7
    call    .FPDE_Div_BC88_Test_8

    ret

; ---------------------------

; --- Test case:
; 0x0000 divided by 0x4000
.FPDE_Div_BC88_Test_0:
    ; --- Arrange
    ld      de, 0x0000
    ld      bc, 0x4000



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0000
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 0x0200 divided by 0x0100 (2.0 divided by 1.0 = 2.0)
.FPDE_Div_BC88_Test_1:
    ; --- Arrange
    ld      de, 0x0200
    ld      bc, 0x0100



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0200
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 0x0300 divided by 0x0200 (3.0 divided by 2.0 = 1.5)
.FPDE_Div_BC88_Test_2:
    ; --- Arrange
    ld      de, 0x0300
    ld      bc, 0x0200



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0180  ; 1.5
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 0x0300 divided by 0x0180 (3.0 divided by 1.5 = 2.0)
.FPDE_Div_BC88_Test_3:
    ; --- Arrange
    ld      de, 0x0300
    ld      bc, 0x0180



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0200  ; 2.0
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 0xFF00 divided by 0x0080 (255.0 divided by 0.5 = 510.0)
.FPDE_Div_BC88_Test_4:
    ; --- Arrange
    ld      de, 0xff00
    ld      bc, 0x0080



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    ld      b, 1
    call    UnitTests.check_A_equals_B
    ld      hl, 0xfe00  ; 0x1fe = 510.0
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 7245 divided by 38 = 190
; 0x1c4d (28.?) divided by 0x0026 (0.15) = aprox 187
.FPDE_Div_BC88_Test_5:
    ; --- Arrange
    ld      de, 7245
    ld      bc, 38



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0xbea8 ; 190.?
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 25800 divided by 11 = 2345.45
; 0x???? (?.?) divided by 0x???? (?.??) = aprox ?
.FPDE_Div_BC88_Test_6:
    ; --- Arrange
    ld      de, 25800
    ld      bc, 11



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    ld      b, 0x09
    call    UnitTests.check_A_equals_B
    ld      hl, 0x2974
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 1 divided by 10000 = 0.0001 ; below the maximum precision of decimal part ((1/256) = 0.0039)
.FPDE_Div_BC88_Test_7:
    ; --- Arrange
    ld      de, 1
    ld      bc, 10000



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0001
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; 1 divided by 65535 = 0.? ; below the maximum precision of decimal part ((1/256) = 0.0039)
.FPDE_Div_BC88_Test_8:
    ; --- Arrange
    ld      de, 1
    ld      bc, 65535



    ; --- Act
    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei



    ; --- Assert
    call    UnitTests.check_A_equals_0
    ld      hl, 0x0001
    call    UnitTests.check_HL_equals_DE

    ret

