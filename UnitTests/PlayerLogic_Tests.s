PlayerLogic_Tests:

    call    .Test_angle_0
    ;call    .Test_angle_15

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

; ---------------------------
