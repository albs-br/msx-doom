OBJECT_LOGIC_TESTS_STRING: db 'Object logic tests', 0

ObjectLogic_Tests:

    ld      hl, OBJECT_LOGIC_TESTS_STRING
    call    PrintString_CrLf

    ; TODO: 
    ;   test all 4 quadrants OK
    ;   test edge cases, transitions 0 - 359 degrees
    ;   distance Y very big and distance X very small, etc

    ; tests object is on 1st quadrant in relation to player
    call    .Quad_1_Test_0
    call    .Quad_1_Test_1
    call    .Quad_1_Test_2
    call    .Quad_1_Test_3
    call    .Quad_1_Test_3a
    call    .Quad_1_Test_3b
    call    .Quad_1_Test_4
    call    .Quad_1_Test_5a
    call    .Quad_1_Test_5b
    call    .Quad_1_Test_6
    call    .Quad_1_Test_z

    ; tests object is on 2nd quadrant in relation to player
    call    .Quad_2_Test_0
    call    .Quad_2_Test_1
    call    .Quad_2_Test_2
    call    .Quad_2_Test_3
    call    .Quad_2_Test_z ; _Z tests: distance Y very large and distance X very small, division result uses all 3 bytes (ADE)

    ; tests object is on 3rd quadrant in relation to player
    call    .Quad_3_Test_0
    call    .Quad_3_Test_1
    call    .Quad_3_Test_2
    call    .Quad_3_Test_3
    call    .Quad_3_Test_4
    call    .Quad_3_Test_z

    ; tests object is on 4th quadrant in relation to player
    call    .Quad_4_Test_0
    call    .Quad_4_Test_1
    call    .Quad_4_Test_z

    ; distance tests
    call    .Distance_Test_0
    call    .Distance_Test_1

    ret

; ---------------------------

; --- Test case:
; Player.angle = 0
; Object.angleToPlayer = 45
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ret

; ---------------------------

; --- Test case:
; Player.angle = 2
; Player.FoV_start = 34
; Player.FoV_end = 330
; Object.angleToPlayer = 45
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 13
; Object.angleToPlayer = 45
; Object.isVisible = true
; Object.posX_inside_FoV = 0
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 0
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 45
; Object.angleToPlayer = 45
; Object.isVisible = true
; Object.posX_inside_FoV = 32
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 76
; Object.angleToPlayer = 45
; Object.isVisible = true
; Object.posX_inside_FoV = 63
.Quad_1_Test_3a:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 76
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 63
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 77
; Object.angleToPlayer = 45
; Object.isVisible = false
; Object.posX_inside_FoV = 63
.Quad_1_Test_3b:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 77
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 64
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 0
; Object.angleToPlayer = 0
; Object.isVisible = true
; Object.posX_inside_FoV = 32
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 31
; Object.angleToPlayer = 0
; Object.isVisible = true
; Object.posX_inside_FoV = 63
.Quad_1_Test_5a:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 31
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

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 63
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 32
; Object.angleToPlayer = 0
; Object.isVisible = false
.Quad_1_Test_5b:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 32
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
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 64
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 11
; Object.isVisible = true
; Object.posX_inside_FoV = 10
.Quad_1_Test_6:
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

    ld      a, (Object_0.quadrant)
    ld      b, 1 ; object is on quadrant 1 in relation to player
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 10
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 90
; Object.isVisible = true
; Object.posX_inside_FoV = 10
.Quad_1_Test_z:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 11
    ld      (Object_0.X), hl
    ld      hl, 32768 - 25800
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 90
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 10
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

    ld      a, (Object_0.quadrant)
    ld      b, 2
    call    UnitTests.check_A_equals_B

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

    ld      a, (Object_0.quadrant)
    ld      b, 2
    call    UnitTests.check_A_equals_B

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

    ld      a, (Object_0.quadrant)
    ld      b, 2
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 135
; Object.angleToPlayer = 135
; Object.isVisible = true
; Object.posX_inside_FoV = 32
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

    ld      a, (Object_0.quadrant)
    ld      b, 2
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 90
; Object.isVisible = true
; Object.posX_inside_FoV = 10
.Quad_2_Test_z:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 11
    ld      (Object_0.X), hl
    ld      hl, 32768 - 25800
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 90
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 2
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 10
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 225
; Object.angleToPlayer = 225
; Object.isVisible = true
; Object.posX_inside_FoV = 32
.Quad_3_Test_0:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 225
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields


    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 225
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 225 - 32 - 1
; Object.angleToPlayer = 225
; Object.isVisible = false
.Quad_3_Test_1:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 225 - 32 - 1
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields


    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 225
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 225 - 32
; Object.angleToPlayer = 225
; Object.isVisible = true
; Object.posX_inside_FoV = 0
.Quad_3_Test_2:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 225 - 32
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields


    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 225
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 0
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 225 + 31
; Object.angleToPlayer = 225
; Object.isVisible = true
; Object.posX_inside_FoV = 63
.Quad_3_Test_3:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 225 + 31
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields


    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 225
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 63
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 225 + 32
; Object.angleToPlayer = 225
; Object.isVisible = false
.Quad_3_Test_4:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 225 + 32
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields


    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 16384
    ld      (Object_0.X), hl
    ld      hl, 32768 + 16384
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 225
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 63
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 270
; Object.isVisible = true
; Object.posX_inside_FoV = 10
.Quad_3_Test_z:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 - 11
    ld      (Object_0.X), hl
    ld      hl, 32768 + 25800
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 270
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 3
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 10
    ; call    UnitTests.check_A_equals_B

    ret
; ---------------------------

; --- Test case:
; Player.angle = 315
; Object.angleToPlayer = 315
; Object.isVisible = true
; Object.posX_inside_FoV = 32
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

    ld      a, (Object_0.quadrant)
    ld      b, 4
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 349
; Object.isVisible = true
; Object.posX_inside_FoV = 32
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

    ld      a, (Object_0.quadrant)
    ld      b, 4
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 349
; Object.angleToPlayer = 270
; Object.isVisible = false
; Object.posX_inside_FoV = 10
.Quad_4_Test_z:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 349
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 11
    ld      (Object_0.X), hl
    ld      hl, 32768 + 25800
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 270
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_false

    ld      a, (Object_0.quadrant)
    ld      b, 4
    call    UnitTests.check_A_equals_B

    ; ld      a, (Object_0.posX_inside_FoV)
    ; ld      b, 10
    ; call    UnitTests.check_A_equals_B

    ret

; ---------------------------

; --- Test case:
; Player.angle = 315
; Object.angleToPlayer = 315
; Object.isVisible = true
; Object.posX_inside_FoV = 32
; Object.distanceToPlayer = 255
.Distance_Test_0:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 315
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 4096 - 1
    ld      (Object_0.X), hl
    ld      hl, 32768 + 4096 - 1
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

    ld      a, (Object_0.quadrant)
    ld      b, 4
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ld      hl, (Object_0.distanceToPlayer)
    ld      de, 255
    call    UnitTests.check_HL_equals_DE

    ret

; ---------------------------

; --- Test case:
; Player.angle = 0
; Object.angleToPlayer = 0
; Object.isVisible = true
; Object.posX_inside_FoV = 32
; Object.distanceToPlayer = 180
.Distance_Test_1:
    ; --- Arrange
    call    PlayerInit
    ld      hl, 0
    ld      (Player.angle), hl
    call    PlayerInit.updateCalcFields

    ld      hl, Object_0
    call    ObjectInit
    ld      hl, 32768 + 4096 - 1
    ld      (Object_0.X), hl
    ld      hl, 32768
    ld      (Object_0.Y), hl



    ; --- Act
    ld      hl, Object_0
    call    ObjectLogic



    ; --- Assert
    ld      hl, (Object_0.angleToPlayer)
    ld      de, 0
    call    UnitTests.check_HL_equals_DE

    ld      a, (Object_0.isVisible)
    call    UnitTests.check_A_is_true

    ld      a, (Object_0.quadrant)
    ld      b, 1
    call    UnitTests.check_A_equals_B

    ld      a, (Object_0.posX_inside_FoV)
    ld      b, 32
    call    UnitTests.check_A_equals_B

    ld      hl, (Object_0.distanceToPlayer)
    ld      de, 180 ; 255 / 1.41 = 180
    call    UnitTests.check_HL_equals_DE

    ret

