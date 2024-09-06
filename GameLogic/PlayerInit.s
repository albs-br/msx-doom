PlayerInit:

    ld      hl, 32768 ; center of map
    ld      (Player.X), hl
    ld      (Player.Y), hl
    ld      hl, 0
    ld      (Player.angle), hl

    call    Update_FoV
    call    Update_walkDXandDY

    ret