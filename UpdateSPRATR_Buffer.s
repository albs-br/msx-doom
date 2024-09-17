UpdateSPRATR_Buffer:
    ; --------------------- Update SPRATR buffer
    
    ; --- Player (map)
    ld      hl, SPRATR_Buffer

    ; convert from 16 bits to 6 bits (0-63)
    ld      a, (Player.Y + 1) ; high byte
    srl     a               ; shift right register
    srl     a
    add     128
    ld      (hl), a

    inc     hl
    ; convert from 16 bits to 6 bits (0-63)
    ld      a, (Player.X + 1) ; high byte
    srl     a               ; shift right register
    srl     a
    ld      (hl), a



    ; --- Object 0 (map)
    ld      hl, SPRATR_Buffer + 4

    ; convert from 16 bits to 6 bits (0-63)
    ld      a, (Object_0 + 3)   ; Y - high byte
    srl     a                   ; shift right register
    srl     a
    add     128
    ld      (hl), a

    inc     hl
    ; convert from 16 bits to 6 bits (0-63)
    ld      a, (Object_0 + 1)   ; X - high byte
    srl     a                   ; shift right register
    srl     a
    ld      (hl), a




    ; objs on screen
    ld      hl, SPRATR_Buffer + 8
    ld      a, (Sprites.sprite_0_Y)
    ld      (hl), a

    inc     hl
    ld      a, (Sprites.sprite_0_X)
    ld      (hl), a

    inc     hl
    ld      a, (Sprites.sprite_0_Pattern)
    ld      (hl), a

    inc     hl
    xor     a
    ld      (hl), a


    ret