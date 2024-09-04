PLAYER_FIELD_OF_VIEW: equ 64 ; it's important to be a power of two to make it easier to convert to screen width coordinate (0-255)

ObjectLogic:

    ld      (ObjectAddress), hl ; save address to return later

    ; Copy object to work area
    ld      de, Object_Temp
    ld      bc, Object_Temp.size
    ldir

    
    ; --- Calc distance X
    push    hl
        ld      e, (hl)         ; DE = (HL)
        inc     hl
        ld      d, (hl)

        ld      hl, (Player.X)

        call    .calcAbsoluteDistance

        ld      (Object_Temp.distance_X), hl
    pop     hl




    ; --- Calc distance Y
    inc     hl
    inc     hl

    ld      e, (hl)         ; DE = (HL)
    inc     hl
    ld      d, (hl)

    ld      hl, (Player.Y)

    call    .calcAbsoluteDistance

    ld      (Object_Temp.distance_Y), hl




    ; ; Divide distance Y by distance X (8 bits)
    ; ld      hl, (Object_0.distance_Y)
    ; ld      e, h                ; get only high byte
    ; ld      hl, (Object_0.distance_X)
    ; ld      c, h                ; get only high byte
    
    ; call    Div8
    ; ld      hl, 0
    ; ld      l, a
    ; ld      (Object_0.angleToPlayer), hl



    ; ; Divide distance Y by distance X (16 bits)
    ; ld      bc, (Object_0.distance_Y)
    ; ld      de, (Object_0.distance_X)
    
    ; call    Div16
    ; ld      (Object_0.angleToPlayer), bc


    ; Divide distance Y by distance X (16 bits)
    ld      bc, (Object_Temp.distance_X)
    
    ; avoid division by zero
    ld      de, 0
    call    Comp_BC_DE         ; Compare Contents Of BC & DE, Set Z-Flag IF (BC == DE), Set CY-Flag IF (BC < DE)
    jp      z, .ret90degrees
    
    ld      de, (Object_Temp.distance_Y)

    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei
    ; ld      (Object_0.angleToPlayer + 1), a     ; high byte
    ; ld      a, d
    ; ld      (Object_0.angleToPlayer), a         ; low byte
    
    ;ld      (Object_0.angleToPlayer), de       ; get two lowest bytes
    
    ; TODO: (not sure if the bad performance on results close to 90 degrees is due to LUT or division time)
    ; if (D != 0) divResultLargerThan256 else divResultSmallerThan256

; .divResultLargerThan256:
    ld      b, d ; BC = DE
    ld      c, e

    ld      hl, LUT_Atan2

.loop:
    ld      e, (hl)
    inc     hl
    ld      d, (hl)

    ; DE: value from look up table
    ; BC: value we are looking for

    ; debug: BC=256 / DE=0
    ; debug: BC=5000 / DE=4096

    ; if (BC > DE) next else getAngle
    call    Comp_BC_DE         ; Compare Contents Of BC & DE, Set Z-Flag IF (BC == DE), Set CY-Flag IF (BC < DE)
    jp      z, .getAngle ; if (BC == DE) getAngle
    jp      nc, .next ; if (BC >= DE) next

.getAngle:
    inc     hl

    ld      e, (hl)
    inc     hl
    ld      d, (hl)

    jp      .cont_1

.ret90degrees:
    ld      de, 90

.cont_1:

    ld      (Object_Temp.angleToPlayer), de       ; save angle

    ; ------------ Update object angle based on which quadrant the object is in relation to player

    ; if (Player.Y > Object.Y)
    ld      hl, (Player.Y)
    ld      de, (Object_Temp.Y)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      c, .player_Y_isLessThan_object_Y
    
    ;       if (Player.X > Object.X) angle2ndQuadrant; else angle1stQuadrant (do nothing)
    ld      hl, (Player.X)
    ld      de, (Object_Temp.X)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .angle2ndQuadrant

    jp      .cont_2

.player_Y_isLessThan_object_Y:

    ;       if (Player.X > Object.X) angle3rdQuadrant; else angle4thQuadrant;
    ld      hl, (Player.X)
    ld      de, (Object_Temp.X)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .angle3rdQuadrant
    jp      .angle4thQuadrant


.cont_2:

    ; ------------- Update object visibility (check if object is inside player's field of view)

    ; ---- if (Object.angleToPlayer > (Player.angle - 32) && Object.angleToPlayer < (Player.angle + 32)) isVisible = true; else isVisible = false;
    
    ; TODO:
    ; working only when
    ; player angle > 32

    ld      de, (Object_Temp.angleToPlayer)
    ld      hl, (Player.angle)
    ld      bc, PLAYER_FIELD_OF_VIEW / 2        ; 32
    xor     a
    sbc     hl, bc
    ; if (DE < HL) outOfView; else do other check
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .outOfView

    ld      de, (Object_Temp.angleToPlayer)
    ld      hl, (Player.angle)
    ld      bc, PLAYER_FIELD_OF_VIEW / 2        ; 32
    add     hl, bc
    ; if (DE < HL) isVisible; else outOfView;
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .isVisible

.outOfView:
    xor     a
    ld      (Object_Temp.isVisible), a
    jp      .cont_100

.isVisible:
    ld      a, 1
    ld      (Object_Temp.isVisible), a

.cont_100:

.return:

    ; Copy work area back to object
    ld      hl, Object_Temp
    ld      de, (ObjectAddress)
    ld      bc, Object_Temp.size
    ldir


    ret

.next:
    inc     hl
    inc     hl
    inc     hl

    ld      de, LUT_Atan2.end
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    
    ; if (HL >= LUT_Atan2.end) ret90degrees else loop
    jp      c, .loop
    jp      .ret90degrees




.calcAbsoluteDistance:
    ; --- if (HL > DE) HL = HL - DE else HL = DE - HL
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      c, .DE_isBigger
    jp      .HL_isBiggerOrEqual
.DE_isBigger:
    ex      de, hl
.HL_isBiggerOrEqual:
    xor     a   ; clear carry
    sbc     hl, de

    ret

; Calc object angle for 2nd quadrant (object is above and left of player; 90-180 range)
.angle2ndQuadrant:
    ; angle = 180 - angle
    ld      hl, 180
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    xor     a
    sbc     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2

; Calc object angle for 4th quadrant (object is below and left of player; 270-359 range)
.angle4thQuadrant:
    ; angle = 360 - angle
    ld      hl, 360
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    xor     a
    sbc     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2

; Calc object angle for 3rd quadrant (object is below and left of player; 180-270 range)
.angle3rdQuadrant:
    ; angle = 270 - angle
    ld      hl, 270
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    xor     a
    sbc     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2
