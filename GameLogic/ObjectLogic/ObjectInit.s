ObjectInit:

    ld      (ObjectAddress), hl ; save address to return later

    ; Copy object to work area
    ld      de, Object_Temp
    ld      bc, Object_Temp.size
    ldir

    ; ----------------------------------

    ld      hl, 32768 + 16384
    ld      (Object_Temp), hl ; X
    ld      hl, 32768 - 16384
    ld      (Object_Temp + 2), hl ; Y
    ld      hl, 0
    ld      (Object_Temp + 4), hl ; distance X
    ld      (Object_Temp + 6), hl ; distance Y
    ld      (Object_Temp + 8), hl ; angle to player
    xor     a
    ld      (Object_Temp + 10), a ; is visible
    ;ld      (Object_Temp + 11), a ;


    ; ----------------------------------

    ; Copy work area back to object
    ld      hl, Object_Temp
    ld      de, (ObjectAddress)
    ld      bc, Object_Temp.size
    ldir

    ret