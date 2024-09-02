UpdateObjectsDistance:

    ld      hl, Object_0

    
    ; --- Calc distance X
    push    hl
        ld      e, (hl)         ; DE = (HL)
        inc     hl
        ld      d, (hl)

        ld      hl, (Player.X)

        call    .calcAbsoluteDistance

        ld      (Object_0.distance_X), hl
    pop     hl




    ; --- Calc distance Y
    inc     hl
    inc     hl

    ld      e, (hl)         ; DE = (HL)
    inc     hl
    ld      d, (hl)

    ld      hl, (Player.Y)

    call    .calcAbsoluteDistance

    ld      (Object_0.distance_Y), hl




    ; Divide distance Y by distance X
    ld      hl, (Object_0.distance_Y)
    ld      e, h                ; get only high byte
    ld      hl, (Object_0.distance_X)
    ld      c, h                ; get only high byte

    
    call    Div8
    ld      hl, 0
    ld      l, a
    ld      (Object_0.angleToPlayer), hl


    ret

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




;
; Divide 8-bit values
; In: Divide E by divider C
; Out: A = result, B = rest
;
Div8:
    xor a
    ld b,8
Div8_Loop:
    rl e
    rla
    sub c
    jr nc,Div8_NoAdd
    add a,c
Div8_NoAdd:
    djnz Div8_Loop
    ld b,a
    ld a,e
    rla
    cpl
    ret