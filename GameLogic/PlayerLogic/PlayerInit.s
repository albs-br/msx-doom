PlayerInit:

    ; ld      hl, 32768 ; center of map
    
    ld      hl, 45349
    ld      (Player.X), hl
    
    ld      hl, 13528
    ld      (Player.Y), hl
    
    ld      hl, 322
    ld      (Player.angle), hl

.updateCalcFields:
    call    Update_FoV
    call    Update_walkDXandDY

    ret