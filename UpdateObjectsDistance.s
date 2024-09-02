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
    ld      bc, (Object_0.distance_X)
    
    ; avoid division by zero
    ld      de, 0
    call    Comp_BC_DE
    jp      z, .ret90degrees
    
    ld      de, (Object_0.distance_Y)

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

    jp      .cont

.ret90degrees:
    ld      de, 90

.cont:
    ld      (Object_0.angleToPlayer), de       ; save angle

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

;
; Divide 16-bit values (with 16-bit result)
; In: Divide BC by divider DE
; Out: BC = result, HL = rest
;
Div16:
    ld hl,0
    ld a,b
    ld b,8
Div16_Loop1:
    rla
    adc hl,hl
    sbc hl,de
    jr nc,Div16_NoAdd1
    add hl,de
Div16_NoAdd1:
    djnz Div16_Loop1
    rla
    cpl
    ld b,a
    ld a,c
    ld c,b
    ld b,8
Div16_Loop2:
    rla
    adc hl,hl
    sbc hl,de
    jr nc,Div16_NoAdd2
    add hl,de
Div16_NoAdd2:
    djnz Div16_Loop2
    rla
    cpl
    ld b,c
    ld c,a
    ret

;
; Multiply 8-bit values
; In:  Multiply H with E
; Out: HL = result
;
Mult8:
    ld d,0
    ld l,d
    ld b,8
Mult8_Loop:
    add hl,hl
    jr nc,Mult8_NoAdd
    add hl,de
Mult8_NoAdd:
    djnz Mult8_Loop
    ret


FPDE_Div_BC88:
;Inputs:
;     DE,BC are 8.8 Fixed Point numbers
;Outputs:
;     ADE is the 16.8 Fixed Point result (rounded to the least significant bit)
    ;  di
     ld a,16
     ld hl,0
Loop1:
     sla e
     rl d
     adc hl,hl
     jr nc,$+8
     or a
     sbc hl,bc
     jp incE
     sbc hl,bc
     jr c,$+5
incE:
     inc e
     jr $+3
     add hl,bc
     dec a
     jr nz,Loop1
     ex af,af'
     ld a,8
Loop2:
     ex af,af'
     sla e
     rl d
     rla
     ex af,af'
     add hl,hl
     jr nc,$+8
     or a
     sbc hl,bc
     jp incE_2
     sbc hl,bc
     jr c,$+5
incE_2:
     inc e
     jr $+3
     add hl,bc
     dec a
     jr nz,Loop2
;round
     ex af,af'
     add hl,hl
     jr c,$+5
     sbc hl,de
     ret c
     inc e
     ret nz
     inc d
     ret nz
     inc a
     ret


Comp_BC_DE:
    LD      A, b
    SUB     D
    RET     NZ
    LD      A, c
    SUB     E
    RET