PLAYER_FIELD_OF_VIEW: equ 64 ; it's important to be a power of two to make it easier to convert to screen width coordinate (0-255)

DIVISION_DIST_Y_BY_DIST_X_MAX_VALUE: equ 4096

; Input:
;   HL: object addr in RAM
ObjectLogic:

    ld      (ObjectAddress), hl ; save address to return later

    ; Copy object to work area
    ld      de, Object_Temp
    ld      bc, Object_Temp.size
    ldir

    ; ----------------------------------

    
    ; --- Calc distance X
    ld      hl, (Player.X)
    ld      de, (Object_Temp.X)
    call    .calcAbsoluteDistance
    ld      (Object_Temp.distance_X), hl




    ; --- Calc distance Y
    ld      hl, (Player.Y)
    ld      de, (Object_Temp.Y)
    call    .calcAbsoluteDistance
    ld      (Object_Temp.distance_Y), hl


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
    
    ; save division result (ADE)
    ld      (Object_Temp.Y_div_by_X), de            ; little endian: ADE turns EDA in memory
    ld      (Object_Temp.Y_div_by_X + 2), a





    ; BUG FIXED
    ; higher byte of division result (register A) is being ignored
    ; register A can be bigger than zero if BC smaller than 1.0
    ; e.g.:
    ; 255.0 / 0.5 = 510.0 (A will be higher than 0)
    ; bug fix:
    ; if (A > 0 || DE >= MAX_VALUE) ret90degrees
    or      a
    jp      nz, .ret90degrees
    ;jp      nz, $ ; pay attention, when stopped here Obj_0 vars wasn't updated yet, you need instead to watch Obj_temp vars
    ld      bc, DIVISION_DIST_Y_BY_DIST_X_MAX_VALUE - 1
    call    Comp_BC_DE         ; Compare Contents Of BC & DE, Set Z-Flag IF (BC == DE), Set CY-Flag IF (BC < DE)
    jp      c, .ret90degrees

    ; TODO: (not sure if the bad performance on results close to 90 degrees is due to LUT or division time)
    ; if (D != 0) divResultLargerThan256 else divResultSmallerThan256 ; Not sure if necessary

; .divResultLargerThan256:
    ld      b, d ; BC = DE
    ld      c, e

    ; set MegaROM page for LUT data
    ld      a, LUT_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a

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
    
    ;       if (Player.X > Object.X) angle2ndQuadrant; else angle1stQuadrant
    ld      hl, (Player.X)
    ld      de, (Object_Temp.X)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .angle2ndQuadrant

    jp      .angle1stQuadrant

.player_Y_isLessThan_object_Y:

    ;       if (Player.X > Object.X) angle3rdQuadrant; else angle4thQuadrant;
    ld      hl, (Player.X)
    ld      de, (Object_Temp.X)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .angle3rdQuadrant
    jp      .angle4thQuadrant


.cont_2:

    ; ------------- Update object visibility (check if object is inside player's field of view)

    ; if (FoV_start > FoV_end) {
    ;   if (Object.angleToPlayer <= FoV_start && Object.angleToPlayer > FoV_end) isVisible = true; else isVisible = false;
    ; }
    ; else {
    ;   if (Object.angleToPlayer > FoV_end || Object.angleToPlayer < FoV_start) isVisible = true; else isVisible = false;
    ; }
    ld      hl, (Player.FoV_start)
    ld      de, (Player.FoV_end)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      c, .FoVstart_isSmaller

;FoVstart_isBigger

    ; if (Object.angleToPlayer <= FoV_start && Object.angleToPlayer > FoV_end) isVisible = true; else isVisible = false;

    ; if (DE < HL) outOfView; else do other check
    ld      hl, (Object_Temp.angleToPlayer)
    ld      de, (Player.FoV_start)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      z, .FoVstart_isBigger_isVisible
    jp      nc, .outOfView

    ; if (DE < HL) isVisible; else outOfView;
    ld      hl, (Object_Temp.angleToPlayer)
    ld      de, (Player.FoV_end)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    ; jp      c, .outOfView
    ; jp      .FoVstart_isBigger_isVisible
    jp      z, .outOfView
    jp      nc, .FoVstart_isBigger_isVisible
    jp      .outOfView

.FoVstart_isSmaller:

    ; if (Object.angleToPlayer > FoV_end || Object.angleToPlayer < FoV_start) isVisible = true; else isVisible = false;

    ; if (DE > HL) isVisible; else do other check
    ld      de, (Object_Temp.angleToPlayer)
    ld      hl, (Player.FoV_end)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      c, .FoVstart_isSmaller_isVisible

    ; if (DE < HL) isVisible; else outOfView;
    ld      de, (Object_Temp.angleToPlayer)
    ld      hl, (Player.FoV_start)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .FoVstart_isSmaller_isVisible
    ; jp      .outOfView

.outOfView:
    xor     a
    ld      (Object_Temp.isVisible), a
    jp      .cont_100

.FoVstart_isSmaller_isVisible:
    ld      a, 1
    ld      (Object_Temp.isVisible), a

    call    .calcDistanceFromPlayer

    ; calc position of object center within player FoV

    ; if (obj.angle <= FoV_start) posX_inside_FoV = FoV_start - obj.angle;
    ld      hl, (Object_Temp.angleToPlayer)
    ld      de, (Player.FoV_start)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      z, .less_than_FoV_start
    jp      c, .less_than_FoV_start

    ; else posX_inside_FoV = 360 - obj.angle + FoV_start;
    ld      hl, 360
    ld      de, (Object_Temp.angleToPlayer)
    xor     a
    sbc     hl, de
    ld      de, (Player.FoV_start)
    add     hl, de
    ld      a, l
    ld      (Object_Temp.posX_inside_FoV), a

    jp      .cont_100

.less_than_FoV_start:
    ; posX_inside_FoV = FoV_start - obj.angle;
    ld      hl, (Player.FoV_start)
    ld      de, (Object_Temp.angleToPlayer)
    xor     a
    sbc     hl, de
    ld      a, l
    ld      (Object_Temp.posX_inside_FoV), a

    jp      .cont_100

.FoVstart_isBigger_isVisible:
    ld      a, 1
    ld      (Object_Temp.isVisible), a

    call    .calcDistanceFromPlayer

    ; calc position of object center within player FoV
    ; scr_X = 64 - (Object.angleToPlayer - Player.FoV_end)
    ld      hl, (Object_Temp.angleToPlayer)
    ld      de, (Player.FoV_end)
    xor     a
    sbc     hl, de
    ex      de, hl ; DE = HL
    ld      hl, 64
    xor     a
    sbc     hl, de
    ld      a, l
    ld      (Object_Temp.posX_inside_FoV), a


    jp      .cont_100

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




; this method calc disntances X and Y ignoring signal (always positive value)
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

; 1st quadrant (no need to adjust angle, it is already in the correct range (0-90))
.angle1stQuadrant:
    ld      a, 1
    ld      (Object_Temp.quadrant), a

    jp      .cont_2


; Calc object angle for 2nd quadrant (object is above and left of player; 90-180 range)
.angle2ndQuadrant:
    ld      a, 2
    ld      (Object_Temp.quadrant), a

    ; angle = 180 - angle
    ld      hl, 180
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    xor     a
    sbc     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2

; Calc object angle for 4th quadrant (object is below and left of player; 270-359 range)
.angle4thQuadrant:
    ld      a, 4
    ld      (Object_Temp.quadrant), a

    ; angle = 360 - angle
    ld      hl, 360
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    xor     a
    sbc     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2

; Calc object angle for 3rd quadrant (object is below and left of player; 180-270 range)
.angle3rdQuadrant:
    ld      a, 3
    ld      (Object_Temp.quadrant), a

    ; angle = 180 + angle
    ld      hl, 180
    ld      bc, (Object_Temp.angleToPlayer) ; must be on (0-90 range)
    add     hl, bc
    ld      (Object_Temp.angleToPlayer), hl

    jp      .cont_2


;---------------------------

.calcDistanceFromPlayer:

    ; set MegaROM page for LUT data
    ld      a, LUT_MEGAROM_PAGE
    ld	    (Seg_P8000_SW), a


    ; if (Obj.distance_X >= 4096 || Obj.distance_Y >= 4096) ret;
    ld      hl, (Object_Temp.distance_X)
    ld      de, 4096
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .calcDistanceFromPlayer_outOfView
    ;ret     nc
    ld      hl, (Object_Temp.distance_Y)
    ld      de, 4096
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .calcDistanceFromPlayer_outOfView
    ;ret     nc


    ; --- calc Obj.distance_X ^ 2
    ld      hl, (Object_Temp.distance_X)
    call    .HL_ToPowerOf2
    ld      b, d        ; BC = DE
    ld      c, e


    ; --- calc Obj.distance_Y ^ 2
    ld      hl, (Object_Temp.distance_Y)
    call    .HL_ToPowerOf2
    ex      de, hl      ; HL = DE

    ; sum Obj.distance_X ^ 2 and Obj.distance_Y ^ 2
    add     hl, bc
    ; xor     a
    ; add     hl, bc
    ; adc     0 ; A = A + 0 + carry
    ; ;   AHL contains result (17 bits)

    ; get high byte of the result and used it as index to SqRoot_LUT
    ld      b, 0
    ld      c, h
    ld      hl, LUT_SqRoot
    add     hl, bc
    ld      a, (hl)


    ; ; shift right AHL and save
    ; srl     a   ; shift right, 0 --> bit 7, bit 0 --> carry
    ; rr      h   ; rotate right, carry --> bit 7, bit 0 --> carry
    ; rr      l   ; rotate right, carry --> bit 7, bit 0 --> carry

    ld      (Object_Temp.distanceToPlayer), a

    ret

.calcDistanceFromPlayer_outOfView:
    ld      a, 255
    ld      (Object_Temp.distanceToPlayer), a
    ret

; Input: HL
; Output: DE
.HL_ToPowerOf2:

    ; HL = HL * 2
    add     hl, hl

    ex      de, hl ; DE = HL

    ld      hl, LUT_PowerOf2
    add     hl, de

    ld      e, (hl)
    inc     hl
    ld      d, (hl)     ; DE = 2 most significant bytes

    ret