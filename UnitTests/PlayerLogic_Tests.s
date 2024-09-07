PLAYER_LOGIC_TESTS_STRING: db 'Player logic tests', 0

PlayerLogic_Tests:

    ld      hl, PLAYER_LOGIC_TESTS_STRING
    call    PrintString_CrLf

    call    .Test_angle_0
    call    .Test_angle_15
    call    .Test_angle_32
    call    .Test_angle_90
    call    .Test_angle_227
    call    .Test_angle_275
    call    .Test_angle_355

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

.Test_angle_15:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 15
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 15
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 360-(32-15)
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 32+15
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

.Test_angle_32:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 32
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 32-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 32+32
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

.Test_angle_90:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 90
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 90
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 90-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 90+32
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

.Test_angle_227:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 227
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 227
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 227-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 227+32
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

.Test_angle_275:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 275
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 275
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 275-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 275+32
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

.Test_angle_355:
    ; --- Arrange & Act
    call    PlayerInit
    ld      hl, 355
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields



    ; --- Assert
    ld      hl, (Player.angle)
    ld      de, 355
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_start)
    ld      de, 355-32
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de,  32 - (360 - 355)
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------
