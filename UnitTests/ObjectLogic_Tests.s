OBJECT_LOGIC_TESTS_STRING: db 'Object logic tests', 0

 ObjectLogic_Tests:

    ld      hl, OBJECT_LOGIC_TESTS_STRING
    call    PrintString_CrLf

    ; TODO

    ; --- test case:
    ; Object.angleToPlayer = 45
    ; Player.angle = 2
    ; Player.FoV_start = 330
    ; Player.FoV_end = 34
    ; Object.isVisible = false

    ret

; ---------------------------

.Test_angle_0:
    ; --- Arrange & Act
    call    PlayerInit



    ; --- Assert
    ld      hl, (Player.angle)
    call    UnitTests.check_HL_equals_0

    ld      hl, (Player.FoV_start)
    ld      de, 360-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 32
    call    UnitTests.check_HL_equals_DE

    ret

