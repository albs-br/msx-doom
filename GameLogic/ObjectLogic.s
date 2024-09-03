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
    call    Comp_BC_DE
    jp      z, .ret90degrees
    
    ld      de, (Object_Temp.distance_Y)

    di
        call    FPDE_Div_BC88 ; DE divided by BC (both 8.8 fixed point), result in ADE (16.8)
    ei
    ; ld      (Object_0.angleToPlayer + 1), a     ; high byte
    ; ld      a, d
    ; ld      (Object_0.angleToPlayer), a         ; low byte
    
    ;ld      (Object_0.angleToPlayer), de       ; get two lowest bytes
    
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

    jp      .return

.ret90degrees:
    ld      de, 90

.return:
    ld      (Object_Temp.angleToPlayer), de       ; save angle

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

