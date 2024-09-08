SavedJiffy:     rb 1

SPRATR_Buffer:  rb 128 ; TODO: table align it to use INC L instead of INC HL

Player:
.X:             rw 1 ; 0-65535
.Y:             rw 1 ; 0-65535
.angle:         rw 1 ; 0-359 degrees, 0 is left (east), increments counter-clockwise
.FoV_start:     rw 1 ; 0-359 degrees
.FoV_end:       rw 1 ; 0-359 degrees
.walk_DX:       rw 1 ; 8.8 fixed point
.walk_DY:       rw 1 ; 8.8 fixed point



    org     0xc100 ; fixed addr to make it easier to track on tcl debug script
Object_0:       ;rb Object_Temp.size
    .X:             rw 1 ; 0-65535
    .Y:             rw 1 ; 0-65535
    .distance_X:    rw 1 ; distance X to player
    .distance_Y:    rw 1 ; distance Y to player
    .angleToPlayer: rw 1 ; angle between player and this object (0-359)
    .isVisible:     rb 1 ; indicates if object is inside player field of view (0: not visible, not 0: visible)

;     org     0xc200
; Object_1:       rb Object_Temp.size

Object_Temp:
    .X:             rw 1 ; 0-65535
    .Y:             rw 1 ; 0-65535
    .distance_X:    rw 1 ; distance X to player
    .distance_Y:    rw 1 ; distance Y to player
    .angleToPlayer: rw 1 ; angle between player and this object (0-359)
    .isVisible:     rb 1 ; indicates if object is inside player field of view (0: not visible, not 0: visible)
    .size:          equ $ - Object_Temp

ObjectAddress:  rw 1
