OBJECT_LOGIC_TESTS_STRING: db 'Object logic tests', 0

 ObjectLogic_Tests:

    ld      hl, OBJECT_LOGIC_TESTS_STRING
    call    PrintString_CrLf

    ; TODO

    call    .Test_0
    call    .Test_1
    call    .Test_2

    ret

; ---------------------------

.Test_0:
    ; --- Arrange
    call    PlayerInit
    ld      hl, Object_0
    call    ObjectInit



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ; TODO: test x and y distances to player
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 45
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.isVisible)
    call    UnitTests.check_HL_equals_0

    ret

; ---------------------------

; --- Test case:
; Object.angleToPlayer = 45
; Player.angle = 2
; Player.FoV_start = 330
; Player.FoV_end = 34
; Object.isVisible = false
.Test_1:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 2
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields
    ld      hl, Object_0
    call    ObjectInit



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 45
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.isVisible)
    call    UnitTests.check_HL_equals_0

    ret

; ---------------------------

; --- Test case:
; Object.angleToPlayer = 45
; Player.angle = 13
; Object.isVisible = true
.Test_2:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 13
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields
    ld      hl, Object_0
    call    ObjectInit



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 45
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.isVisible)
    call    UnitTests.check_HL_not_equals_0

    ret

