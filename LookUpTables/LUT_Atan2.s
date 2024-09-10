; TODO: angle can be byte here

; TODO: possible performance improvement:
; table with all possible values and angles
; this way there is no need to loop through all the table until find the value (more costly when getting close to table end)
; just add LUT_Atan2 with the value to be found
; this approach trades space for speed, which is good here
;LUT_Atan2:
;   db      0 ; angle for value 0 = 0 degrees
;   db      1 ; angle for value 1 = 0 degrees
;   db      2 ; angle for value 2 = 0 degrees
;   db      3 ; angle for value 3 = 0 degrees
; (...)
;   db      16 ; angle for value 16 = 4 degrees
;   db      17 ; angle for value 17 = 4 degrees
; (...)
;   db    4096 ; angle for value 4096 = 90 degrees
; (...)
;   db   10000 ; angle for value 10000 = 90 degrees

LUT_Atan2:
    dw 0, 0
    dw 16, 4
    dw 32, 7
    dw 48, 11
    dw 64, 14
    dw 80, 17
    dw 96, 21
    dw 112, 24
    dw 128, 27
    dw 144, 29
    dw 160, 32
    dw 176, 35
    dw 192, 37
    dw 208, 39
    dw 224, 41
    dw 240, 43
; .largerThan256:
    dw 256, 45
    ;dw 256, 45
    dw 273, 47
    dw 293, 49
    dw 315, 51
    dw 341, 53
    dw 372, 55
    dw 410, 58
    dw 455, 61
    dw 512, 63
    dw 585, 66
    dw 683, 69
    dw 819, 73
    dw 1024, 76
    dw 1365, 79
    dw 2048, 83
    dw 4096, 86
.end: