ObjectLogic_Tests:

    ; --- Arrange & Act
    call    PlayerInit



    ; --- Assert
    ld      hl, (Player.angle)
    call    .check_HL_equals_0

    ld      hl, (Player.FoV_start)
    ld      de, 360-32
    call    .check_HL_equals_DE

    ld      hl, (Player.FoV_end)
    ld      de, 32
    call    .check_HL_equals_DE

    ret

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

.testPassed:
    ld      hl, TEST_PASSED_STRING
    call    PrintString_CrLf
    ret

.testFailed:
    ld      hl, TEST_FAILED_STRING
    call    PrintString_CrLf
    ret

TEST_PASSED_STRING: db 'Test passed', 0
TEST_FAILED_STRING: db 'Test failed', 0
