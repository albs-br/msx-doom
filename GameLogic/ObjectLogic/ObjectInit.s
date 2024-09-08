; Input:
;   HL: object addr in RAM
ObjectInit:

    ld      (ObjectAddress), hl ; save address to return later

    ; Copy object to work area
    ld      de, Object_Temp
    ld      bc, Object_Temp.size
    ldir

    ; ----------------------------------

    ld      hl, 32768 + 16384
    ld      (Object_Temp.X), hl ; X
    ld      hl, 32768 - 16384
    ld      (Object_Temp.Y), hl ; Y
    ld      hl, 0
    ld      (Object_Temp.distance_X), hl ; distance X
    ld      (Object_Temp.distance_Y), hl ; distance Y
    ld      (Object_Temp.angleToPlayer), hl ; angle to player
    xor     a
    ld      (Object_Temp.isVisible), a ; is visible
    ;ld      (Object_Temp + 11), a ;


    ; ----------------------------------

    ; Copy work area back to object
    ld      hl, Object_Temp
    ld      de, (ObjectAddress)
    ld      bc, Object_Temp.size
    ldir

    ret