ReadInput:
    ; --- Read input
    ld      a, 8                    ; 8th line
    call    BIOS_SNSMAT             ; Read Data Of Specified Line From Keyboard Matrix
    
    push    af
        bit     4, a                    ; 4th bit (left)
        call   	z, .rotateLeft
    pop     af

    push    af
        bit     7, a                    ; 7th bit (right)
        call   	z, .rotateRight
    pop     af

    push    af
        bit     5, a                    ; 5th bit (up)
        call   	z, .walkForward
    pop     af

    push    af
        bit     6, a                    ; 6th bit (down)
        call   	z, .walkBackwards
    pop     af


    ret


.rotateRight:
    ; if (Player.angle == 0) Player.angle = 359; else Player.angle--;
    ld      hl, (Player.angle)
    ld      de, 0
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jr      z, .rotateRight_set359

    dec     hl
    jp      .rotate_return

.rotateRight_set359:
    ld      hl, 359
    jp      .rotate_return



.rotateLeft:
    ; if (Player.angle == 360) Player.angle = 0; else Player.angle++;
    ld      hl, (Player.angle)
    ld      de, 360
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jr      z, .rotateLeft_set0

    inc     hl
    jp      .rotate_return

.rotateLeft_set0:
    ld      hl, 0

.rotate_return:
    ld      (Player.angle), hl

    call    Update_FoV

    call    Update_walkDXandDY

    ret

.walkForward:

    ; ---- Y += DY
    ld      hl, (Player.Y)
    ld      de, (Player.walk_DY)

    add     hl, de
    ld      (Player.Y), hl

    ; TODO: check map limit

    ; ---- X += DX
    ld      hl, (Player.X)
    ld      de, (Player.walk_DX)

    add     hl, de
    ld      (Player.X), hl

    ret

.walkBackwards:

    ; ---- Y -= DY
    ld      hl, (Player.Y)
    ld      de, (Player.walk_DY)

    xor     a ; clear carry
    sbc     hl, de
    ld      (Player.Y), hl

    ; TODO: check map limit

    ; ---- X -= DX
    ld      hl, (Player.X)
    ld      de, (Player.walk_DX)

    xor     a ; clear carry
    sbc     hl, de
    ld      (Player.X), hl

    ret

; .left:
;     ; if (Player.X == 0) ret; else Player.X--;
;     ld      hl, (Player.X)
;     ld      de, 0
;     call    BIOS_DCOMPR
;     ret     z

;     ld      bc, -256
;     add     hl, bc
;     ; dec     hl
;     ld      (Player.X), hl

;     ret

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

    ; ---- if (angle >= 32) FoV_start = angle - 32; else FoV_start = 360 - (32 - angle)
    ld      de, PLAYER_FIELD_OF_VIEW / 2
    call    BIOS_DCOMPR         ; Compare Contents Of HL & DE, Set Z-Flag IF (HL == DE), Set CY-Flag IF (HL < DE)
    jp      nc, .set_FoV_start_angle_minus_32

    ; FoV_start = 360 - (32 - angle)
    ; FoV_start = 360 - 32 + angle); 
    ld      bc, 360 - (PLAYER_FIELD_OF_VIEW / 2)
    ld      hl, (Player.angle)
    add     hl, bc
    ld      (Player.FoV_start), hl
    
    jp      .cont

.set_FoV_start_angle_minus_32:
    ld      hl, (Player.angle)
    ld      bc, PLAYER_FIELD_OF_VIEW / 2
    xor     a
    sbc     hl, bc
    ld      (Player.FoV_start), hl


.cont:

    ; TODO
    ; ---- if (angle < (360-32)) FoV_end = angle + 32; else FoV_end 

    ret