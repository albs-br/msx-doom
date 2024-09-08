OBJECT_LOGIC_TESTS_STRING: db 'Object logic tests', 0

ObjectLogic_Tests:

    ld      hl, OBJECT_LOGIC_TESTS_STRING
    call    PrintString_CrLf

    ; TODO: test all 4 quadrants, test edge cases, etc

    ; tests object is on 1st quadrant in relation to player
    call    .Quad_1_Test_0
    call    .Quad_1_Test_1
    call    .Quad_1_Test_2
    call    .Quad_1_Test_3
    call    .Quad_1_Test_4
    call    .Quad_1_Test_5

    ; tests object is on 2nd quadrant in relation to player
    call    .Quad_2_Test_0
    call    .Quad_2_Test_1
    call    .Quad_2_Test_2
    call    .Quad_2_Test_3

    ; tests object is on 4th quadrant in relation to player
    call    .Quad_4_Test_0
    call    .Quad_4_Test_1
    call    .Quad_4_Test_2

    ret

; ---------------------------

; --- Test case:
; Object.angleToPlayer = 45
; Player.angle = 0
; Object.isVisible = false
.Quad_1_Test_0:
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

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ret

; ---------------------------

; --- Test case:
; Object.angleToPlayer = 45
; Player.angle = 2
; Player.FoV_start = 330
; Player.FoV_end = 34
; Object.isVisible = false
.Quad_1_Test_1:
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

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ret

; ---------------------------

; --- Test case:
; Object.angleToPlayer = 45
; Player.angle = 13
; Object.isVisible = true
.Quad_1_Test_2:
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

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ret

; ---------------------------

; --- Test case:
; Player.angle = 45
; Object.angleToPlayer = 45
; Object.isVisible = true
; Object.scrX = 128
.Quad_1_Test_3:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 45
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

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 0
; Object.angleToPlayer = 0
; Object.isVisible = true
; Object.scrX = 128
.Quad_1_Test_4:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 0
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 16384
    ld      (Object_0.X), hl
    ld      hl, 32768
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.distance_X)
    ld      de, 16384
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.distance_Y)
    ld      de, 0
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.angleToPlayer)
    ld      de, 0
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 28
; Object.angleToPlayer = 0
; Object.isVisible = true
; Object.scrX = 128
.Quad_1_Test_5:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 28
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 16384
    ld      (Object_0.X), hl
    ld      hl, 32768
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.distance_X)
    ld      de, 16384
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.distance_Y)
    ld      de, 0
    call    UnitTests.check_HL_equals_DE

    ld      hl, (Object_0.angleToPlayer)
    ld      de, 0
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 255
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 0
; Object.angleToPlayer = 135
; Object.isVisible = true
.Quad_2_Test_0:
    ; --- Arrange
    call    PlayerInit

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 135
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ret

; ---------------------------

; --- Test case:
; Player.angle = 135+32-1
; Object.angleToPlayer = 135
; Object.isVisible = true
.Quad_2_Test_1:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 135+32-1
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 135
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ret

; ---------------------------

; --- Test case:
; Player.angle = 135-32
; Object.angleToPlayer = 135
; Object.isVisible = true
.Quad_2_Test_2:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 135-32
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 135
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ret

; ---------------------------

; --- Test case:
; Player.angle = 135
; Object.angleToPlayer = 135
; Object.isVisible = true
; Object.scrX = 128
.Quad_2_Test_3:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 135
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 135
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 315
; Object.angleToPlayer = 315
; Object.isVisible = true
; Object.scrX = 128
.Quad_4_Test_0:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 315
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 315
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 349
; Object.isVisible = true
; Object.scrX = 128
.Quad_4_Test_1:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 2900
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 349
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 11
; Object.isVisible = true
; Object.scrX = 128
.Quad_4_Test_2:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 - 2900
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 11
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true


    ; ld      a, (Object_0.scrX)
    ; ld      b, 128
    ; call    UnitTests.check_A_equals_B

    ret

