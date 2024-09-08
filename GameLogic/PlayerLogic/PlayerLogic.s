Update_walkDXandDY:
    ; --- Update .walk_DX based on angle
    ld      hl, (Player.angle)
    
    add     hl, hl          ; HL = HL * 2

    ld      d, h            ; DE = HL
    ld      e, l

    ld      hl, LUT_cos     ; HL = LUT_cos + DE
    add     hl, de

    ld      e, (hl)         ; DE = (HL)
    inc     hl
    ld      d, (hl)

    ld      (Player.walk_DX), de
    



    ; --- Update .walk_DY based on angle
    ld      hl, (Player.angle)
    
    add     hl, hl          ; HL = HL * 2

    ld      d, h            ; DE = HL
    ld      e, l

    ld      hl, LUT_sin     ; HL = LUT_sin + DE
    add     hl, de

    ld      e, (hl)         ; DE = (HL)
    inc     hl
    ld      d, (hl)

    ; ; for angles 0-89 invert signal (invert all bits, then add 1, ignoring overflow)
    ; ld      a, e
    ; xor     1111 1111 b
    ; ld      e, a
    
    ; ld      a, d
    ; xor     1111 1111 b
    ; ld      d, a

    ; inc     de

    ld      (Player.walk_DY), de

    ret



Update_FoV:
    ld      hl, (Player.angle)

    ; ---- if (angle >= 32) FoV_end = angle - 32; else FoV_end = 360 - (32 - angle)
    ld      de, PLAYER_FIELD_OF_VIEW / 2
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .set_FoV_end_angle_minus_32

    ; FoV_end = 360 - (32 - angle)
    ; FoV_end = 360 - 32 + angle)
    ld      bc, 360 - (PLAYER_FIELD_OF_VIEW / 2)
    ld      hl, (Player.angle)
    add     hl, bc
    ld      (Player.FoV_end), hl
    
    jp      .cont

.set_FoV_end_angle_minus_32:
    ; FoV_end = angle - 32
    ld      hl, (Player.angle)
    ld      bc, PLAYER_FIELD_OF_VIEW / 2
    xor     a
    sbc     hl, bc
    ld      (Player.FoV_end), hl


.cont:

    ld      hl, (Player.angle)

    ; ---- if (angle < (360-32)) FoV_start = angle + 32; else FoV_start = 32 - (360 - angle);
    ld      de, 360 - (PLAYER_FIELD_OF_VIEW / 2)
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      c, .set_FoV_start_angle_plus_32


    ; FoV_start = 32 - (360 - angle)
    ; FoV_start = 32 - 360 + angle
    ld      bc, - 360 + (PLAYER_FIELD_OF_VIEW / 2)
    ld      hl, (Player.angle)
    add     hl, bc
    ld      (Player.FoV_start), hl

    ret

.set_FoV_start_angle_plus_32:
    ; FoV_start = angle + 32
    ld      hl, (Player.angle)
    ld      bc, PLAYER_FIELD_OF_VIEW / 2
    add     hl, bc
    ld      (Player.FoV_start), hl


    ret